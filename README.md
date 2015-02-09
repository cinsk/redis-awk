Introduction
============

Redis client binding for [gawk](http://www.gnu.org/software/gawk/), the GNU implementation of *awk*.

It's features includes

- no global variable pollusion
- convinient functions with variable-length parameter list, though limited
- multiple redis connection supported


*Warning!!!*  Since *awk/gawk* was not designed to handle binary data, it will be difficult to handle binary data in Redis server.  I haven not tested thorougly.

Usage
=====

Currently, *redis.awk* provides following functions:

* `redis_open(HOST, PORT)`: to connect to the Redis server,
* `redis_close(CONN)`: to close the connection to the Redis server,
* `redis_command(CONN, RESP, ARGC, ...)`: to request Redis operation,
* `redis_dump(RESP)`: (for debugging purpose) to dump the response from the Redis server.

Note that you should provide the number of arguments, ARGC to `redis_command()`.  For example, if you want to request `SET KEY VAL` to the Redis server, you should provide 3 as ARGC parameter like:

    redis_command(conn, resp, 3, "SET", "KEY", "VAL")

Look at the [example1](https://github.com/cinsk/redis-awk/blob/master/example2-3) file for the demonstration.

Pipeline
--------

Currently, I'm experimental several implementaion choices.

Look at the example file especially, [example2-3](https://github.com/cinsk/redis-awk/blob/master/example2-3). Basically, you'll canned the Redis commands using `redis_append()`, then call `redis_flush()` to send to the Redis server, then, call `redis_resp()` multiple times exactly the same numbers that you called `redis_append()`.

     redis_append(conn, reqs, 2, "GET", "name")
     redis_append(conn, reqs, 2, "INCR", "count")
     ...
     redis_flush(conn, reqs)
     
     for (i = 0; i < reqs["nreq"]; i++) {
       redis_resp(conn, resp)    # Get response Nth command
       # process 'resp' if needed
     }

`redis_append()` may send the Redis command to the server even if you didn't call `redis_flush()` if the queued command exceeds the internal limit.  You may control the internal limit, by modifying `REDIS["pipesize"]`.  Before modifying it, please read read the comment in the function definition of `redis_append()`.
