---
title: Elastic Search queries
---

Overview
========

Synchronously issues queries against ElasticSearch search servers.

The underlying client ElasticSearch library is [elasticsearch-py](https://elasticsearch-py.readthedocs.org/en/master/).

API
===

self.search.es.get {#progguide-outconn-search-es-get}
------------------

Usage example
=============

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        conn = self.search.es.get('My ES Connection').conn

        # Create a document
        result = conn.create('my-index', 'my-doc-type', {'hello':'world'}, 'doc-id')
        self.logger.info(result)

        # And look it up
        result = conn.search(q='hello:*')
        self.logger.info(result)
```

``` {.python}
2015-01-06 17:34:38,548 - INFO - 30928:Dummy-249 - es1.my-service:22 -
    {u'_type': u'my-doc-type', u'_id': u'doc-id',
    u'created': True, u'_version': 1, u'_index': u'my-index'}

2015-01-06 17:34:38,581 - INFO - 30928:Dummy-249 - es1.my-service:22 -
    {u'hits': {u'hits': [{u'_score': 1.0, u'_type': u'my-doc-type',
     u'_id': u'doc-id', u'_source': {u'hello': u'world'},
    u'_index': u'my-index'}], u'total': 1, u'max_score': 1.0},
    u'_shards': {u'successful': 5, u'failed': 0, u'total': 5},
     u'took': 32, u'timed_out': False}
```
