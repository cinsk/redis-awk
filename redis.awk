
# error(CODE, MSG, STREAM = "/dev/stderr")
function error(code, msg, stream) {
    if (length(stream) == 0)
        stream = "/dev/stderr"

    printf "%s: %s\n", ARGV[0], msg > stream
    if (code)
        exit code
}


function debug(msg, stream) {
    if (_REDIS_DEBUG) {
        if (length(stream) == 0)
            stream = "/dev/stderr"

        printf "%s: %s\n", ARGV[0], msg > stream
    }
}

function args2array(array, num, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, 
                    i_) {
    delete array

    if (num == 0 || num == "0")
        return 0;

    if (num > 0) {
        for (i_ = 0; i_ < num; ) {
            array[i_++] = a;  if (i_ >= num) break
            array[i_++] = b;  if (i_ >= num) break
            array[i_++] = c;  if (i_ >= num) break
            array[i_++] = d;  if (i_ >= num) break
            array[i_++] = e;  if (i_ >= num) break
            array[i_++] = f;  if (i_ >= num) break
            array[i_++] = g;  if (i_ >= num) break
            array[i_++] = h;  if (i_ >= num) break
            array[i_++] = i;  if (i_ >= num) break
            array[i_++] = j;  if (i_ >= num) break
            array[i_++] = k;  if (i_ >= num) break
            array[i_++] = l;  if (i_ >= num) break
            array[i_++] = m;  if (i_ >= num) break
            array[i_++] = n;  if (i_ >= num) break
            array[i_++] = o;  if (i_ >= num) break
            array[i_++] = p;  if (i_ >= num) break
        }
    }
    else {
        i_ = 0
        while (1) {
            if (length(a) <= 0) break; array[i_++] = a;
            if (length(b) <= 0) break; array[i_++] = b;
            if (length(c) <= 0) break; array[i_++] = c;
            if (length(d) <= 0) break; array[i_++] = d;
            if (length(e) <= 0) break; array[i_++] = e;
            if (length(f) <= 0) break; array[i_++] = f;
            if (length(g) <= 0) break; array[i_++] = g;
            if (length(h) <= 0) break; array[i_++] = h;
            if (length(i) <= 0) break; array[i_++] = i;
            if (length(j) <= 0) break; array[i_++] = j;
            if (length(k) <= 0) break; array[i_++] = k;
            if (length(l) <= 0) break; array[i_++] = l;
            if (length(m) <= 0) break; array[i_++] = m;
            if (length(n) <= 0) break; array[i_++] = n;
            if (length(o) <= 0) break; array[i_++] = o;
            if (length(p) <= 0) break; array[i_++] = p;
            break
        }
    }
    return i_
}

function array2str(array, sep,     s_, i_) {
    s_ = ""
    for (i_ = 0; i_ < length(array); i_++) {
        s_ = (s_ sep array[i_])
    }
    return substr(s_, 1 + length(sep))
}


function args2cmdv(array, num, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, 
                    i_) {
    delete array

    if (num == 0 || num == "0")
        return 0;

    if (num > 0) {
        i_ = 0
        array[i_++] = ("*" num)

        num = 1 + num * 2
        for (; i_ < num; ) {
            array[i_++] = ("$" length(a))
            array[i_++] = a;  if (i_ >= num) break
            array[i_++] = ("$" length(b))
            array[i_++] = b;  if (i_ >= num) break
            array[i_++] = ("$" length(c))
            array[i_++] = c;  if (i_ >= num) break
            array[i_++] = ("$" length(d))
            array[i_++] = d;  if (i_ >= num) break
            array[i_++] = ("$" length(e))
            array[i_++] = e;  if (i_ >= num) break
            array[i_++] = ("$" length(f))
            array[i_++] = f;  if (i_ >= num) break
            array[i_++] = ("$" length(g))
            array[i_++] = g;  if (i_ >= num) break
            array[i_++] = ("$" length(h))
            array[i_++] = h;  if (i_ >= num) break
            array[i_++] = ("$" length(i))
            array[i_++] = i;  if (i_ >= num) break
            array[i_++] = ("$" length(j))
            array[i_++] = j;  if (i_ >= num) break
            array[i_++] = ("$" length(k))
            array[i_++] = k;  if (i_ >= num) break
            array[i_++] = ("$" length(l))
            array[i_++] = l;  if (i_ >= num) break
            array[i_++] = ("$" length(m))
            array[i_++] = m;  if (i_ >= num) break
            array[i_++] = ("$" length(n))
            array[i_++] = n;  if (i_ >= num) break
            array[i_++] = ("$" length(o))
            array[i_++] = o;  if (i_ >= num) break
            array[i_++] = ("$" length(p))
            array[i_++] = p;  if (i_ >= num) break
        }
    }
    else {
        i_ = 0
        array[i_++] = "*"       # bogus

        while (1) {
            if (length(a) <= 0) break; 
            array[i_++] = ("$" length(a));  array[i_++] = a;
            if (length(b) <= 0) break;
            array[i_++] = ("$" length(b));  array[i_++] = b;
            if (length(c) <= 0) break;
            array[i_++] = ("$" length(c));  array[i_++] = c;
            if (length(d) <= 0) break;
            array[i_++] = ("$" length(d));  array[i_++] = d;
            if (length(e) <= 0) break;
            array[i_++] = ("$" length(e));  array[i_++] = e;
            if (length(f) <= 0) break;
            array[i_++] = ("$" length(f));  array[i_++] = f;
            if (length(g) <= 0) break;
            array[i_++] = ("$" length(g));  array[i_++] = g;
            if (length(h) <= 0) break;
            array[i_++] = ("$" length(h));  array[i_++] = h;
            if (length(i) <= 0) break;
            array[i_++] = ("$" length(i));  array[i_++] = i;
            if (length(j) <= 0) break;
            array[i_++] = ("$" length(j));  array[i_++] = j;
            if (length(k) <= 0) break;
            array[i_++] = ("$" length(k));  array[i_++] = k;
            if (length(l) <= 0) break;
            array[i_++] = ("$" length(l));  array[i_++] = l;
            if (length(m) <= 0) break;
            array[i_++] = ("$" length(m));  array[i_++] = m;
            if (length(n) <= 0) break;
            array[i_++] = ("$" length(n));  array[i_++] = n;
            if (length(o) <= 0) break;
            array[i_++] = ("$" length(o));  array[i_++] = o;
            if (length(p) <= 0) break;
            array[i_++] = ("$" length(p));  array[i_++] = p;
            break
        }
        array[0] = ("*" (i - 1)/2)
    }
    return i_
}

# redis__get_endpoint()
#
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

function redis_open(host, port) {
    if (length(host) == 0) {
        if ("REDIS_ENDPOINT" in ENVIRON) {
            sock=ENVIRON["REDIS_ENDPOINT"]

            if (!match(sock, /^([^:]+)(:([0-9]+))?$/, m))
                return ""
            else {
                sock = sprintf("/inet/tcp/0/%s/%s", m[1], m[3] ? m[3] : "6379")
            }
        }
        else
            sock = "/inet/tcp/0/localhost/6379"
    }
    else {
        if (length(port) == 0)
            port = 6379
        sock = sprintf("/inet/tcp/0/%s/%d", host, port)
    }
    return sock
}

function redis_close(conn) {
    close(conn)
}

# redis_dump(RESP, STREAM = "/dev/stderr", LEV = 0)
#
# Dump RESP to STREAM (for debugging purpose)
#
# If STREAM is not provided, "/dev/stderr" will be used by default
# LEV is the indentation level, and the default value will be 0.
function redis_dump(resp, stream, lev,    rsp_, i_) {
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
            redis_dump(rsp_, stream, lev + 1)
        }
        break
    default:
        return 0
    }
    return 1
}

# redis__get_resp(CONN, [out] RESP)
#
# Get the response from the stream, CONN.
#
# RESP will be set by this function.
#
# resp[0] contains the response from the redis server, and
# resp[1] has the type of resp[0], in one of these strings:
#  - "s": string type
#  - "e": error type
#  - "i": integer type
#  - "a": array type
function redis__get_resp(c, resp,   resp_, oldRS_, ln_, 
                                    first_, i_, size_, read_) {
    oldRS_ = RS
    RS = "\r\n"

    debug(sprintf("receiving..."))

    c |& getline ln_
    debug(sprintf("received: |%s|", ln_))

    _REDIS_["resp"] = ln_
    first_ = substr(ln_, 1, 1)

    delete resp
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
        if (size_ < 0) {        # Null array
            resp[0] = ""
            resp[1] = "n"
            break
        }
        else
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
        if (size_ < 0) {        # Null string
            resp[1] = "n"
            break
        }
        else
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
    RS = oldRS_
    return 1
}


function redis_command(conn, resp, num, 
                       a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, 
                       v_, c_, oldRS_, i_) {
    oldRS_ = ORS
    ORS = "\r\n"
    c_ = args2cmdv(v_, num, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p)

    if (_REDIS_DEBUG) {
        for (i_ = 0; i_ < c_; i_++) {
            debug(sprintf("REQ[%d] = |%s|", i_, v_[i_]))
        }
    }

    print array2str(v_, "\r\n") |& conn
    i_ = redis__get_resp(conn, resp)

    ORS = oldRS_

    return i_
}

BEGIN {
    if ("REDIS_DEBUG" in ENVIRON)
        _REDIS_DEBUG = 1
    else
        _REDIS_DEBUG = 0


    # REDIS = redis__get_endpoint()
    #redis_select(REDIS, 0)
    #print "result: ", _REDIS_["resp"]
    #print "error: ", _REDIS_["error"]

    # redis_command(REDIS, resp, 3, "expire", "foo", 100)
    # redis_dump(resp)
    # 
    # redis_command(REDIS, resp, 2, "keys", "*")
    # redis_dump(resp)
    # 
    # exit 0

    # print "redis: ", REDIS
    # print "get foo" |& REDIS
    # print "huh"
    # redis__get_resp(REDIS, resp)
    # print "huh"
    # redis_dump(resp)
    # print "huh"
    # 
    # for (k in resp) {
    #     printf "resp[%s]: %s\n", k, resp[k]
    # }

    # print "smembers myset" |& REDIS
    #print "get foo" |& REDIS
    # redis__get_resp(REDIS, resp)
    # 
    # redis_dump(resp)
    # for (k in resp[0]) {
    #     printf "resp[%s]: %s\n", k, resp[0][k]
    # }

    # print "--"
    # len = args2cmdv(ar, 3, "expire", "foo", "32")
    # for (i = 0; i < len; i++) {
    #     printf "ar[%d] = |%s|\n", i, ar[i]
    # }
    # print "--"
    # 
    # len = args2cmdv(ar, 2, "expire",  32)
    # for (i = 0; i < len; i++) {
    #     printf "ar[%d] = |%s|\n", i, ar[i]
    # }

}
