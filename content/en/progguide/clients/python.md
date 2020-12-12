---
title: Python client
---

Zato provides a convenience client, called AnyServiceInvoker, for use by other Python applications to invoke
services in a given cluster. Because Zato services can be exposed through many methods, there is no hard requirement
that Python applications use the client, instead it\'s rather meant to be an easy to use API client
that a Zato user would like to have in any case.

CLI\'s [zato service invoke \</admin/cli/service-invoke\>] and the [web admin \</architecture/web-admin\>]
both use [AnyServiceInvoker \<progguide-clients-python-AnyServiceInvoker\>].

AnyServiceInvoker {#progguide-clients-python-AnyServiceInvoker}
=================

------------------------------------------------------------------------

invoke {#progguide-clients-python-invoke}
------

``` {.python}
from zato.client import AnyServiceInvoker

address = 'http://localhost:11223'
path = '/zato/admin/invoke'
auth = ('admin.invoke', 'ccd77ca1ff414c3e8308e3f35d8292df')

client = AnyServiceInvoker(address, path, auth)
response = client.invoke('zato.ping')

if response.ok:
    print(response.data)
else:
    print(response.details)
```

``` 
$ py myclient.py
{u'pong': u'zato'}
$
```

invoke_async {#progguide-clients-python-invoke_async}
------------

Invokes a service asynchronously. Works exactly like [invoke \<progguide-clients-python-invoke\>]
except that the client isn\'t blocked. Instead a message to invoke the service is published
in Redis and client receives the CID a service has been invoked with so that its actual response
can be correlated with the client request at a later time.

``` {.python}
from zato.client import AnyServiceInvoker

address = 'http://localhost:11223'
path = '/zato/admin/invoke'
auth = ('admin.invoke', 'ccd77ca1ff414c3e8308e3f35d8292df')

client = AnyServiceInvoker(address, path, auth)
response = client.invoke_async('zato.ping')

if response.ok:
    print(response.data)
else:
    print(response.details)
```

``` 
$ py myclient.py
f53b59e2215cc7cb608d0382
$
```

Response object {#progguide-clients-python-response}
===============

The result of invoking a service, no matter if in a blocking way or asynchronously,
is always a
[Response](https://github.com/zatosource/zato/blob/support/2.0/code/zato-client/src/zato/client/__init__.py)
object which provides access to the underlying data a service
produced along with a couple of useful attributes.

Depending on the client class used, the response attributes may hold data of different
types.

+----------+----------------------------+----------------------------+
| Name     | Datatype                   | Description                |
+==========+============================+============================+
| inner    | [reques                    | The inner HTTP response as |
|          | ts.Response](http://docs.p | returned by the            |
|          | ython-requests.org/en/late | [requests](h               |
|          | st/api/#requests.Response) | ttp://python-requests.org) |
|          |                            | library                    |
+----------+----------------------------+----------------------------+
| ok       | boolean                    | Whether the invocation     |
|          |                            | succeeded, True if         |
|          |                            | zato_env.result is equal   |
|          |                            | to ZATO_OK                 |
+----------+----------------------------+----------------------------+
| has_data | boolean                    | If data a service produced |
|          |                            | is available. Will be set  |
|          |                            | to True only if ok is      |
|          |                            | True.                      |
|          |                            | Otherwise, if ok is not    |
|          |                            | True, details will contain |
|          |                            | error information.         |
|          |                            |                            |
|          |                            | Note however that both ok  |
|          |                            | and data can be True if a  |
|          |                            | service was invoked with   |
|          |                            | no problems                |
|          |                            | yet it didn\'t return any  |
|          |                            | output.                    |
+----------+----------------------------+----------------------------+
| data     | (depends)                  | Service response in format |
|          |                            | depending on the client    |
|          |                            | class used. Will be        |
|          |                            | available                  |
|          |                            | only if ok and has_data    |
|          |                            | are True. If a service     |
|          |                            | returns JSON document, the |
|          |                            | document converted to a    |
|          |                            | Python object. Otherwise,  |
|          |                            | service response as a      |
|          |                            | string.                    |
+----------+----------------------------+----------------------------+
| details  | (depends)                  | Taken from                 |
|          |                            | zato_env.details           |
+----------+----------------------------+----------------------------+
