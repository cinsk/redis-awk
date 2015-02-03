#!/usr/bin/awk -f

function error(code, msg) {
    printf "%s: %s\n", ARGV[0], msg > "/dev/stderr"
    if (code)
        exit code
}

# Get the endpoint string of the redis server.
#
# the endpoint string has the form, "HOST:PORT", and read from the
# environment variable REDIS_ENDPOINT.  If not available,
# "localhost:6379" is used as the default.
function redis__get_endpoint(    m, sock) {
    if ("REDIS_ENDPOINT" in ENVIRON)
        sock=ENVIRON["REDIS_ENDPOINT"]
    else
        sock="localhost:6379"

    if (!match(sock, /^([^:]+)(:([0-9]+))?$/, m)) {
        error(1, "invalid redis endpoint: " sock)
        exit 1
    }

    return sprintf("/inet/tcp/0/%s/%s", m[1], m[3] ? m[3] : "6379")
}

#
# Dump RESP to STREAM (for debugging purpose)
#
# If STREAM is not provided, "/dev/stderr" will be used by default
# LEV is the indentation level, and the default value will be 0.
function redis__dump_resp(resp, stream, lev,    rsp_, i_) {
    if (length(lev) == 0)
        lev = 0
    if (length(stream) == 0)
        stream = "/dev/stderr"

    #print "resp: ", resp
    switch (resp[1]) {
    case "e":
        printf "%*s[ERR] |%s|\n", lev * 2, "", resp[0] > stream
        break
    case "s":
        printf "%*s[STR] |%s|\n", lev * 2, "", resp[0] > stream
        break
    case "i":
        printf "%*s[STR] |%d|\n", lev * 2, "", resp[0] > stream
        break
    case "a":
        printf "%*s[ARR]\n", lev * 2, "" > stream
        for (i_ = 0; i_ < length(resp[0]) / 2; i_++) {
            rsp_[0] = resp[0][i_ * 2]
            rsp_[1] = resp[0][i_ * 2 + 1]
            redis__dump_resp(rsp_, stream, lev + 1)
        }
        break
    default:
        return 0
    }
    return 1
}

#
# Get the response from the stream, C.
#
# RESP will be set by this function.
#
# resp[0] contains the response from the redis server, and
# resp[1] has the type of resp[0], in one of these strings:
#  - "s": string type
#  - "e": error type
#  - "i": integer type
#  - "a": array type
function redis__get_resp(c, resp,   resp_, oldRS_, ln_, first_, i_, size_) {
    oldRS_ = RS
    RS = "\r\n"

    c |& getline ln_
    _REDIS_["resp"] = ln_
    first_ = substr(ln_, 1, 1)

    delete resp[0]
    switch (first_ = substr(ln_, 1, 1)) {
    case "+":                   # simple string
        resp[0] = substr(ln_, 2)
        resp[1] = "s"
        break
    case "-":                   # error
        resp[0] = substr(ln_, 2)
        resp[1] = "e"
        RS = oldRS_
        return 0
    case ":":                   # number
        resp[0] = strtonum(substr(ln_, 2))
        resp[1] = "i"
        break
    case "*":
        size_ = strtonum(substr(ln_, 2))
        resp[1] = "a"
        for (i_ = 0; i_ < size_; i_++) {
            redis__get_resp(c, resp_)
            resp[0][i_ * 2] = resp_[0]
            resp[0][i_ * 2 + 1] = resp_[1]
        }
        break
    case "$":                   # bulk string
        size_ = strtonum(substr(ln_, 2))
        read_ = 0
        resp[0] = ""
        resp[1] = "s"
        while (c |& getline ln_) {
            resp[0] = (resp[0] ln_)
            read_ += length(ln_)

            if (read_ >= size_)
                break
            resp[0] = (resp[0] RS)
            read_ += length(RS)
        }
        break
    default:
        error(1, sprintf("unrecognized RESP, %0o", first_))
    }
    return 1
}


BEGIN {
    REDIS = redis__get_endpoint()
    #redis_select(REDIS, 0)
    #print "result: ", _REDIS_["resp"]
    #print "error: ", _REDIS_["error"]

    print "get foo" |& REDIS
    redis__get_resp(REDIS, resp)
    redis__dump_resp(resp)
    # 
    # for (k in resp) {
    #     printf "resp[%s]: %s\n", k, resp[k]
    # }

    print "smembers myset" |& REDIS
    #print "get foo" |& REDIS
    redis__get_resp(REDIS, resp)

    redis__dump_resp(resp)
    # for (k in resp[0]) {
    #     printf "resp[%s]: %s\n", k, resp[0][k]
    # }
}
