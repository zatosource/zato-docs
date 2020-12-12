---
title: Cassandra CQL
---

Ad-hoc queries {#progguide-examples-cassandra-ad-hoc}
==============

Ad-hoc queries against
[Cassandra connection \<../../web-admin/conn-def/cassandra\>]
definitions
can be constructed and executed at any time. The flexibility of being
able to dynamically create them on fly comes at a cost of decreased performance - execution time will increase.

``` {.python}
from zato.server.service import Service

class MyService(Service):

    def handle(self):

        # Obtains a connection the named pool
        conn = self.cassandra_conn['My Connection'].conn

        # Executes an ad-hoc query and obtains result
        result = conn.execute('SELECT * FROM schema_columns')

        # Let's find out what we have here..
        for row in result:
            self.logger.info(row)
```

``` {.python}
INFO - {'index_type': None, 'validator': 'org.apache.cassandra.db.marshal.Int32Type' ..
INFO - {index_type': None, 'validator': 'org.apache.cassandra.db.marshal.UTF8Type' ..
```

Pre-compiled query templates {#progguide-examples-cassandra-templates}
============================

Query templates can be
[compiled \<../../web-admin/query/cassandra\>]
upfront before any services start to make use of them. Such queries will execute faster but won\'t be as flexible
as ad-hoc ones because they cannot be constructed dynamically in run-time.

``` {.python}
from zato.server.service import Service

class MyService(Service):

    def handle(self):

        # Obtains a pre-compiled query
        query = self.cassandra_query['Get Customers']

        # Execute the query providing a dictionary of input parameters it expects
        result = query.execute(cust_name='Smith', account_type='SOHO')

        # Let's check out what the query returned
        for item in result:
            self.logger.info(item)
```

``` {.python}
INFO - {'cust_name': 'Alexis Smith', 'account_no': '387017'}
INFO - {'cust_name': 'Mark Smith', 'account_no': '732561'}
```
