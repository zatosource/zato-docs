---
title: SQL usage examples
---

SQL databases are accessed through
[SQLAlchemy](http://docs.sqlalchemy.org)
sessions and any feature SQLAlchemy supports is available to Zato services.

Regardless of how a database is accessed and what sort of queries are issued,
it\'s always required to close a session object when a service is done using it.
It\'s easiest to use the Python\'s built-in
[contextlib.closing](http://docs.python.org/2.7/library/contextlib.html#contextlib.closing)
manager for doing it.

The full API is documented
[here \<../outconn/sql\>].

Issuing raw SQL {#progguide-examples-sql-raw}
===============

``` {.python}
# stdlib
from contextlib import closing

# Zato
from zato.server.service import Service

class MyService(Service):
    def handle(self):

        # Always use templates and bind variables
        template = 'SELECT name FROM http_soap WHERE data_format=:data_format'
        parameters = {'data_format':'json'}

        with closing(self.outgoing.sql.get('my-conn').session()) as session:
            result = session.execute(template, parameters)
            for item in result:
                self.logger.info(item)
```

``` 
INFO - (u'zato.security.wss.create.json',)
INFO - (u'zato.http-soap.ping.json',)
INFO - (u'zato.service.configure-request-response.json',)
INFO - (u'zato.kvdb.data-dict.dictionary.get-key-list.json',)
```

SQLAlchemy models {#progguide-examples-sql-sqlalchemy}
=================

SQLAlchemy models can be used instead of issuing plain SQL queries. This is what
Zato\'s
[own services](https://github.com/zatosource/zato/tree/master/code/zato-server/src/zato/server/service/internal)
to stay database-neutral and support more than one database engine.

Refer to the [API docs \<../outconn/sql\>] for a usage example involving SQLAlchemy
models.
