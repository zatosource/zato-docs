---
title: JSON examples
---

Create a [plain HTTP \<../../web-admin/channels/plain-http\>] with data format
set to JSON to turn on automatic (de-)serialization of incoming/returned JSON messages.

Accessing JSON request {#progguide-examples-json-request}
======================

By default, a JSON message is converted to a Python dictionary.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        self.logger.info(type(self.request.payload))
        self.logger.info(self.request.payload)
        self.logger.info(self.request.payload['mydata']['cust']['id'])
```

``` 
$ curl localhost:11223/example -d '{"mydata":{"cust":{"id":1,"name":"Jack Brown"}}}'
$
```

``` 
INFO - <type 'dict'>
INFO - {u'mydata': {u'cust': {u'id': 1L, u'name': u'Jack Brown'}}}
INFO - 1
```

Converting JSON to Bunch {#progguide-examples-json-bunch}
========================

It\'s usually convenient to convert JSON to a [Bunch](http://pypi.python.org/pypi/bunch) instance
and use dotted notation to reference elements of the request.

``` {.python}
# bunch
from bunch import bunchify

# Zato
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        mydata = bunchify(self.request.payload['mydata'])
        self.logger.info(mydata.cust.id)
        self.logger.info(mydata.cust.name)
```

``` 
$ curl localhost:11223/example -d '{"mydata":{"cust":{"id":1,"name":"Jack Brown"}}}'
$
```

``` 
INFO - 1
INFO - Jack Brown
```

Creating responses {#progguide-examples-json-responses}
==================

Assign a string representation of JSON to self.response.payload - it doesn\'t matter
how it\'s produced as long as it results in a string, hence all the examples below
achieve the same.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        self.response.payload = """{"customer": {"products": [{"type": "AMZN",
          "id": 1}, {"type": "KZUA", "id": 2}], "id": 123, "name": "John Brown"}}"""
```

``` {.python}
# anyjson
from anyjson import dumps

# Zato
from zato.server.service import Service

class MyService(Service):
    def handle(self):

        response = {
          'customer': {
            'id':123,
            'name':'John Brown',
            'products': [
                {'id':1, 'type':'AMZN'},
                {'id':2, 'type':'KZUA'}
        ]}}

        self.response.payload = dumps(response)
```

``` {.python}
# anyjson
from anyjson import dumps

# bunch
from bunch import Bunch

# Zato
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        response = Bunch()
        response.customer = Bunch()
        response.customer.id = 123
        response.customer.name = 'John Brown'
        response.customer.products = []
        response.customer.products.append({'id':1, 'type':'AMZN'})
        response.customer.products.append({'id':2, 'type':'KZUA'})

        self.response.payload = dumps(response)
```

Output below reformatted for clarity.

``` 
$ curl localhost:11223/example -d '{}'
{"customer":
  {"products": [
    {"type": "AMZN", "id": 1},
    {"type": "KZUA", "id": 2}],
 "id": 123,
 "name": "John Brown"}}
$
```

Invoking a JSON service using GET {#progguide-examples-json-invoking-get}
=================================

Create a
[plain HTTP \<../../web-admin/outgoing/plain-http\>]
outgoing connection to a remote JSON service,
[such as this one provided by Yahoo!](http://finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote?format=json)
and
[invoke \<../outconn/http\>]
it through self.outgoing.plain_http.

The response is a string that can be turned into a Python dictionary or a
[Bunch](http://pypi.python.org/pypi/bunch)
instance, like in the examples below.

``` {.python}
# anyjson
from anyjson import loads

# Zato
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        response = self.outgoing.plain_http.get('Yahoo! Finance').conn.get(self.cid)
        data = loads(response.text)

        for item in data['list']['resources']:
            name = item['resource']['fields']['name']
            price = item['resource']['fields']['price']

            self.logger.info('{} {}'.format(name, price))
```

``` {.python}
# anyjson
from anyjson import loads

# bunch
from bunch import bunchify

# Zato
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        response = self.outgoing.plain_http.get('Yahoo! Finance').conn.get(self.cid)
        data = bunchify(loads(response.text))

        for item in data.list.resources:
            name = item.resource.fields.name
            price = item.resource.fields.price

            self.logger.info('{} {}'.format(name, price))
```

Invoking a JSON service using POST {#progguide-examples-json-invoking-post}
==================================

Create a
[plain HTTP outgoing connection \<../../web-admin/outgoing/plain-http\>]
to a remote JSON service and
[invoke \<../outconn/http\>]
it
through self.outgoing.plain_http passing the input JSON document as a string
to the .post method.

``` {.python}
# anyjson
from anyjson import dumps

# Zato
from zato.server.service import Service

class MyService(Service):
    def handle(self):

        cust_profile = self.outgoing.plain_http.get('CRM Customer Profile')

        request = dumps({'cust_id':1, 'name':'Foo Bar'})
        response = cust_profile.conn.post(self.cid, request)

        self.logger.info(response.text)
```
