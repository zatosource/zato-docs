---
title: XML examples
---

Create a [plain HTTP channel\<../../web-admin/channels/plain-http\>] with data format
set to XML to turn on automatic (de-)serialization of incoming/returned XML messages.

As with [SOAP \<./soap\>], the examples below use [lxml](http://lxml.de) because it\'s
a very good choice for efficient XML processing but you\'re not constrained to that one library
only.

lxml offers every feature you need for working XML, such as namespaces, XPath,
XSLT, XInclude, XML Schema, RelaxNG and many more but if you prefer other tools
you can use anything and Zato won\'t constrain you.

Accessing XML request {#progguide-examples-xml-request}
=====================

XML document will be converted to an
[ObjectifiedElement](http://lxml.de/objectify.html) - elements are accessed
using dotted notation, their textual values are available through the .text attribute
and .get is used to fetch attributes.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        root = self.request.payload
        self.logger.info(type(root))
        self.logger.info(root.cust.id.text)
        self.logger.info(root.cust.get('type'))
```

``` 
$ curl localhost:11223/example -d '<data><cust type="soho"><id>123</id></cust></data>'
$
```

``` 
INFO - <type 'lxml.objectify.ObjectifiedElement'>
INFO - 123
INFO - soho
```

You have access to each part of the API offered by
[lxml](http://lxml.de),
for instance, to iterate
over child elements use the .getchildren method.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        root = self.request.payload
        for child in root.ids.getchildren():
            self.logger.info(child.text)
```

``` 
$ curl localhost:11223/example -d '<data><ids><id>1</id><id>2</id><id>3</id></ids></data>'
$
```

``` 
INFO - 1
INFO - 2
INFO - 3
```

Creating responses {#progguide-examples-xml-responses}
==================

Assign a string representation of an XML document to return to self.response.payload. It doesn\'t
matter how the string payload is produced thus both examples below result in the same
response.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        self.response.payload = '<data><customer><id>123</id></customer></data>'
```

``` {.python}
# lxml
from lxml.builder import E as e
from lxml.etree import tostring

# Zato
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        root = e.data(e.customer(e.id('123')))
        self.response.payload = tostring(root)
```

``` 
$ curl localhost:11223/example -d '<root/>'
<data><customer><id>123</id></customer></data>
$
```

Invoking an XML service {#progguide-examples-xml-invoking}
=======================

Create a
[plain HTTP outgoing connection \<../../web-admin/outgoing/plain-http\>]
to a remote XML service and
[invoke \<../outconn/http\>]
it through self.outgoing.plain_http passing the input XML document as a string
to the .post method.

Example below assumes an \'EuroBank\' connection was defined and configured
to use this address <https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml>

``` {.python}
# lxml
from lxml.builder import E as e
from lxml.etree import tostring

# Zato
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        root = e.mydata(e.mysubelement(e.mysub2('abc')))
        request = tostring(root)

        out = self.outgoing.plain_http.get('EuroBank')
        response = out.conn.post(self.cid, request)

        self.response.payload = response.text
```

``` 
$ curl localhost:17010/example -d '<root/>'
<?xml version="1.0" encoding="UTF-8"?>
<gesmes:Envelope xmlns:gesmes="http://www.gesmes.org/xml/2002-08-01"
  xmlns="http://www.ecb.int/vocabulary/2002-08-01/eurofxref">
    <gesmes:subject>Reference rates</gesmes:subject>
    <gesmes:Sender>
       <gesmes:name>European Central Bank</gesmes:name>
    </gesmes:Sender>
    <Cube>
      <Cube time='2013-06-27'>
        <Cube currency='USD' rate='1.3032'/>
        <Cube currency='JPY' rate='127.93'/>
        <Cube currency='BGN' rate='1.9558'/>


(snip)
...
...
```
