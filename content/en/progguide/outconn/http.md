---
title: HTTP outgoing connections
---

Overview
========

Synchronously invokes a remote HTTP server using JSON, SOAP or any other transport
method using
[previously configured \<../../web-admin/outgoing/plain-http\>]
[connection parameters \<../../web-admin/outgoing/soap\>].

If the connection has been configured to use a security definition, it will be picked up
automatically, without any coding. Likewise, if the service to be invoked is a SOAP one,
only the contents of a SOAP body should be passed to [.post \<progguide-outconn-post\>]
and the envelope will be added by Zato.

Requests are sent in a synchronous manner but they don\'t block the current server thread.

The underlying client HTTP library is [Requests](http://docs.python-requests.org/en/latest/).

Each request sent using one of the
[.ping \<progguide-outconn-ping\>],
[.get \<progguide-outconn-get\>]
or
[.post \<progguide-outconn-post\>]
methods will contain 3
Zato-specific HTTP headers:

  Name               Example                                         Notes
  ------------------ ----------------------------------------------- -----------------------------------------------------------------------------------
  X-Zato-CID         K294883017331181958264688131768546402685        [CID \<progguide-write-service-cid\>] the service issuing the request
                                                                     has been invoked with
  X-Zato-Component   parallel/esb1/esb1.example.com/21358/Thread-4   Information regarding which Zato parallel server issued the request
  X-Zato-Msg-TS      2013-04-26T23:41:45.271911                      Request timestamp (in UTC)

API
===

self.outgoing.plain_http.get {#progguide-outconn-plain_http-get}
----------------------------

self.outgoing.soap.get {#progguide-outconn-soap-get}
----------------------

  Name      Type        Notes
  --------- ----------- -------------------------------------------------------------------------------------------------
  auth      attribute   A username/password configured for the given HTTP connection, if any has been configured at all
  ping      method      [Pings the remote server \<progguide-outconn-ping\>]
  get       method      [Issues a GET request \<progguide-outconn-get\>]
  post      method      [Issues a POST request \<progguide-outconn-post\>]
  send      method      Alias to .post
  session   attribute   A handle to the underlying [Requests](http://docs.python-requests.org/en/latest/) library
                        which can be used to issue any other requests possible

::: {#progguide-outconn-ping}
:::

::: {#progguide-outconn-get}
:::

.post {#progguide-outconn-post}
-----

.delete, .options, .put, .patch
-------------------------------

Represent DELETE, OPTIONS, PUT and PATCH HTTP verbs. .delete and .options use the same API
[.get does \<progguide-outconn-get\>]. .put and .patch
the same as
[.post \<progguide-outconn-post\>].

Usage examples
==============

Plain HTTP - POST JSON
----------------------

``` {.python}
# stdlib
from json import dumps

# Zato
from zato.server.service import Service

class MyService(Service):
    def handle(self):

        cust_profile = self.outgoing.plain_http.get('CRM Customer Profile')
        cust_cases = self.outgoing.plain_http.get('CRM Customer Cases')

        request = dumps({'cust_id':1, 'name':'Foo Bar'})
        response = cust_profile.conn.post(self.cid, request)

        self.logger.info(response.headers['content-type'])
        self.logger.info(response.text)

        ping_info = cust_cases.conn.ping(self.cid)
        self.logger.info(ping_info)
```

Plain HTTP - GET requests
-------------------------

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        out = self.outgoing.plain_http.get('CRM Connection')
        url_params = {'id':1, 'type_id':2}
        response = out.conn.get(self.cid, url_params)
        self.logger.info(response.text)
```

SOAP
----

``` {.python}
# lxml
from lxml import etree

# Zato
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        service = self.outgoing.soap.get('Set Account Balance')
        resp = service.conn.send(self.cid, '<data><id>123</id><val>45.67</val></data>')

        # Parse resp.text to create an XML object
        xml = etree.fromstring(resp.text)
```
