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

- redis_open(HOST, PORT): to connect to the Redis server,
- redis_close(CONN): to close the connection to the Redis server,
- redis_command(CONN, RESP, ARGC, ...): to request Redis operation,
- redis_dump(RESP): (for debugging purpose) to dump the response from the Redis server.

Note that you should provide the number of arguments, ARGC to *redis_command()*.  For example, if you want to request "SET KEY VAL" to the Redis server, you should provide 3 as ARGC parameter like:

    redis_command(conn, resp, 3, "SET", "KEY", "VAL")

Look at the example files for the demonstration.
