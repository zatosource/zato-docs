---
title: Cassandra queries
---

Overview
========

Synchronously sends ad-hoc or precompiled CQL queries to Cassandra nodes.

The underlying client Cassandra library is [python-driver](https://github.com/datastax/python-driver) by Datastax.

API
===

Ad-hoc queries
--------------

### self.cassandra_conn.get

Precompiled queries
-------------------

### self.cassandra_query.get

Usage examples
==============

Ad-hoc queries
--------------

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        conn = self.cassandra_conn.get('My Database').conn
        result = conn.execute('SELECT * FROM schema_columns')

        self.logger.info(result)
```

``` {.python}
2015-01-06 16:25:39,601 - INFO - 29854:Dummy-72 - cassandra1.my-service:22 -
   [{u'index_options': u'null', u'index_name': None, u'keyspace_name': u'system',
    u'index_type': None, u'validator': u'org.apache.cassandra.db.marshal.BytesType',
    u'columnfamily_name': u'IndexInfo', u'component_index': None, u'type': u'compact_value'}]
```

Precompiled queries
-------------------

Assuming an existing [query \<../../web-admin/query/cassandra\>] such as below, stored under \'My Query\':

``` {.python}
SELECT * FROM account_info WHERE client_id =: client_id AND account_id =: account_id
```

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        query = self.cassandra_query.get('My Query')
        result = query.execute(client_id=123, account_id=456)

        self.logger.info(result)
```

``` {.python}
2015-01-06 16:40:48,983 - INFO - 30113:Dummy-89 - {"client_name: "Alex Green"}
```
