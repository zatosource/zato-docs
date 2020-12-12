---
title: Key/value DB (Redis)
---

As a programmer, you can observe that Zato uses [Redis](http://redis.io) as its
[key/value database (KVDB) \</architecture/redis\>]
to support several distinct mechanisms:

-   As a broker for Zato\'s [publish/subscribe feature \<progguide-write-service-broker-client\>].
    Each service can use
    [1:N \<progguide-write-service-broker-client-publish\>]
    and
    [1:1 \<progguide-write-service-broker-client-invoke_async\>]
    publishing. There\'s also
    [a convenience method \<progguide-write-service-invoke_async\>]
    to simplify invoking other services asynchronously.
-   [Translating \<progguide-write-service-translate\>] the
    [dictionary values \<../web-admin/kvdb/data-dict\>]
-   Storing [statistics \<../stats/guide\>] that can be accessed through
    the public API
-   Accessing Redis directly through the self.kvdb.conn object, which is an instance
    of the [StrictRedis connection](https://github.com/andymccurdy/redis-py)- there\'s a full
    support for all [Redis verbs](http://redis.io/commands), such as in the examples
    below.
    -   Setting a value and getting it back:

        ``` {.python}
        from zato.server.service import Service

        class MyService(Service):
            def handle(self):
                key = 'my-key'
                self.kvdb.conn.set(key, 'my-value')
                self.logger.info('key:[{}]'.format(self.kvdb.conn.get(key)))
        ```

        ``` {.python}
        INFO - key:[my-value]
        ```

    -   Reading Redis server info:

        ``` {.python}
        from zato.server.service import Service

        class MyService(Service):
            def handle(self):
                self.logger.info(self.kvdb.conn.info())
        ```

        ``` {.python}
        INFO - {'pubsub_channels': 3, 'aof_enabled': 0, 'bgrewriteaof_in_progress': 0,
          'connected_slaves': 0, 'uptime_in_days': 0, 'multiplexing_api': 'epoll',
          'lru_clock': 1912835, 'last_save_time': 1361305387,
          'redis_version': '2.2.12', 'redis_git_sha1': 0, 'loading': 0,
          'connected_clients': 7, 'keyspace_misses': 231, 'used_memory': 5825776,
          'vm_enabled': 0, 'used_cpu_user_children': 0.01, 'role': 'master',
          'total_commands_processed': 2357, 'used_memory_rss': 7643136,
          'total_connections_received': 14, 'pubsub_patterns': 0,
          'used_cpu_sys': 4.94, 'used_memory_human': '5.56M',
          'used_cpu_sys_children': 0.11, 'blocked_clients': 0,
          'used_cpu_user': 0.68, 'use_tcmalloc': 0, 'client_biggest_input_buf': 0,
          'db0': {'keys': 19934, 'expires': 23}, 'arch_bits': 64,
          'redis_git_dirty': 0, 'expired_keys': 17, 'hash_max_zipmap_entries': 512,
          'evicted_keys': 0, 'bgsave_in_progress': 0, 'client_longest_output_list': 0,
          'hash_max_zipmap_value': 64, 'process_id': 1465, 'uptime_in_seconds': 3935,
          'changes_since_last_save': 278, 'mem_fragmentation_ratio': 1.31,
          'keyspace_hits': 1628}
        ```

    -   [Pipelines](https://github.com/andymccurdy/redis-py#pipelines) can be used
        to send multiple commands in a single batch to improve performance:

        > ``` {.python}
        > from zato.server.service import Service
        >
        > class MyService(Service):
        >     def handle(self):
        >         with self.kvdb.conn.pipeline() as p:
        >             for idx in range(30):
        >                 key = 'my-key-{}'.format(idx)
        >                 p.delete(key)
        >
        >             p.execute()
        > ```

Calling Lua functions {#progguide-kvdb-lua}
=====================

Each server contains a *config/repo/lua/user* directory, such as */opt/zato/env1/config/repo/lua/user*. Any Lua program
placed in the directory in its own file will be available to services through the *self.kvdb.lua_container.run_lua* method.

For example, given the program as below stored in a file called \'mylib.check_if_exists.lua\':

``` {.lua}
-- Checks whether a from_key exists and if it does renames it to to_key.
-- Returns an error code otherwise.

-- Return codes:
-- 10 = Ok, renamed from_key -> to_key
-- 11 = No such from_key

local from_key = KEYS[1]
local to_key = KEYS[2]

if redis.call('exists', from_key) == 1 then
    redis.call('rename', from_key, to_key)
    return 10
else
    return 11
end
```

This is the Python code to invoke it in order to atomically check and rename a Redis key only if it exists.

``` {.python}
from zato.server.service import Service

class MyService(Service):

    def handle(self):

        # Keys the program operates on, if any
        keys = ['rename-from', 'rename-to']

        # Value the program operates on, if any
        values = None

        # Both keys and values can be skipped if not needed,
        # shown here for completeness.
        out = self.kvdb.lua_container.run_lua('mylib.rename_if_exists', keys, values)

        # 10 if renamed, 11 otherwise
        self.logger.info('Rename result: %s', out)
```

Changelog
=========

  Version   Notes
  --------- --------------------------------------------------
  2.0       Added means to invoke user-defined Lua functions
  1.0       Added initially
