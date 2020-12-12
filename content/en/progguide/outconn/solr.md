---
title: Solr queries
---

Overview
========

Synchronously issues queries against Solr search servers.

The underlying client Solr library is [pysolr](https://github.com/toastdriven/pysolr/).

API
===

self.search.solr\[name\].conn.client() {#progguide-outconn-search-solr-conn-client}
--------------------------------------

Usage example
=============

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        with self.search.solr['My Solr Connection'].conn.client() as client:

            # Grab all documents
            result = client.search('*:*')

            # And convert the result to a list to be displayed
            self.logger.info(list(result))
```

``` {.python}
2015-01-06 19:57:38,771 - INFO - 2295:Dummy-109 - solr1.my-service:22 -
  [{u'_version_': 1489572119768465408, u'id': u'my.id', u'title': [u'my.title']}]
```
