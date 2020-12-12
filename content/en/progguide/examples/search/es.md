---
title: Search - ElasticSearch
---

[ElasticSearch connections \<../../../../web-admin/cloud/openstack/swift\>]
allows one to index, look up or delete stored documents and access other features
ElasticSearch itself offers.

Indexing {#progguide-examples-search-es-index}
========

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        conn = self.search.es.get('My Connection').conn

        # Create a document
        conn.create('my-idx', 'my-type', {'hello':'world'}, 'my-id')
```

In server.log:

``` 
INFO - PUT http://es:9200/my-idx/my-type/my-id?op_type=create [status:201 request:0.057s]
```

Searching {#progguide-examples-search-es-search}
=========

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        conn = self.search.es.get('My Connection').conn

        # Look up documents using ES syntax
        result = conn.search(q='hello:*')

        # Iterate over what ES gave us
        for item in result:
            self.logger.info(result)
```

In server.log:

``` 
INFO - GET http://es:9200/_search?q=hello%3A%2A [status:200 request:0.058s]
INFO - {u'hits': {u'hits': [{u'_score': 1.0, u'_type': u'my-type', u'_id': u'my-id' ..
```

Deleting {#progguide-examples-search-es-delete}
========

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        conn = self.search.es.get('My Connection').conn

        # Delete a document by its ID
        conn.delete('my-idx', 'my-type', 'my-id')
```

In server.log:

``` 
INFO - DELETE http://es:9200/my-idx/my-type/my-id [status:200 request:0.003s]
```

Other features {#progguide-examples-search-es-more}
==============

The connection object is an instance of
[elasticsearch.client.Elasticsearch](https://elasticsearch-py.readthedocs.org/en/master/api.html).
Refer to
[its main documentation](https://elasticsearch-py.readthedocs.org/en/master/)
in order to learn how to access other features such as bulk deleting, counting and more.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        conn = self.search.es.get('My Connection').conn

        self.logger.info(conn.__class__)
```

``` 
INFO - <class 'elasticsearch.client.Elasticsearch'>
```