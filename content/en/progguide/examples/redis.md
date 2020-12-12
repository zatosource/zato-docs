---
title: Redis usage examples
---

Any programming feature Redis
[offers](http://redis.io/commands)
can be accessed with
the
[client library](https://github.com/andymccurdy/redis-py)
Zato uses
and the chapter below
serves as a set of usage examples only, not as a complete reference.

Simple keys {#progguide-examples-redis-simple-keys}
===========

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        self.kvdb.conn.set('my-key', 'my-value')
        self.logger.info(self.kvdb.conn.get('my-key'))
```

``` 
INFO - my-value
```

Lists {#progguide-examples-redis-lists}
=====

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):

        # Clear/delete the list
        self.kvdb.conn.delete('my-list')

        # Push 10 elements
        for x in range(10):
            self.kvdb.conn.lpush('my-list', x)

        # Read them back
        self.logger.info(self.kvdb.conn.lrange('my-list', 0, 9999))
```

``` 
INFO - ['9', '8', '7', '6', '5', '4', '3', '2', '1', '0']
```

Dictionaries (hashmaps) {#progguide-examples-redis-dictionaries}
=======================

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):

        # Clear/delete the dictionary
        self.kvdb.conn.delete('my-dict')

        # Set 10 keys and values
        for x in range(10):
            self.kvdb.conn.hset('my-dict', x, x**x)

        # Read one of them back
        self.logger.info(self.kvdb.conn.hget('my-dict', 7))
```

``` 
INFO - 823543
```

Transactions {#progguide-examples-redis-transactions}
============

Pipelines can be used to improve performance of executing multiple operations
and to invoke them atomically.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):

        # Either deletes all the keys specified and adds a new one or none
        # of it is performed.
        with self.kvdb.conn.pipeline() as p:

            # Deletes
            p.delete('my-key-1')
            p.delete('my-key-2')
            p.delete('my-key-3')

            # Add new key
            p.set('my-key-4', 'my-value')

            # Execute all the commands queued up in a single transaction
            p.execute()
```
