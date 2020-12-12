---
title: SOAP examples
---

Create a [SOAP channel\<../../web-admin/channels/soap\>] to turn on
automatic (de-)serialization of incoming/returned SOAP messages. You deal with the SOAP
body only, headers are dealt with by Zato itself.

As with [XML\<./xml\>], the examples below use [lxml](http://lxml.de) because it\'s
a very good choice for efficient XML processing but you\'re not constrained to that one library
only.

lxml offers every feature you need for working XML, such as namespaces, XPath,
XSLT, XInclude, XML Schema, RelaxNG and many more but if you prefer other tools
you can use anything and Zato won\'t constrain you.

Accessing SOAP request {#progguide-examples-soap-request}
======================

The SOAP body converted to an [ObjectifiedElement](http://lxml.de/objectify.html)
is available as self.request.payload. As with any other channels, the raw request
is available as self.request.raw_request should you need to access SOAP headers
manually.

``` {.xml}
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
  xmlns:ns="http://example.com/ns">
   <soapenv:Header/>
   <soapenv:Body>
     <ns:request>
      <ns:customer>
       <ns:id>123</ns:id>
       <ns:name type="NCHZ">John Brown</ns:name>
      </ns:customer>
     </ns:request>
   </soapenv:Body>
</soapenv:Envelope>
```

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        root = self.request.payload
        self.logger.info(type(root))
        self.logger.info(root.customer.id.text)
        self.logger.info(root.customer.name.text)
        self.logger.info(root.customer.name.get('type'))
```

``` {.python}
INFO - <type 'lxml.objectify.ObjectifiedElement'>
INFO - 123
INFO - John Brown
INFO - NCHZ
```

Creating responses {#progguide-examples-soap-response}
==================

Assign a string representation of the SOAP body to return to self.response.payload. It doesn\'t
matter how the payload is produced as long as it results in a string. The payload is wrapped
in a SOAP header by Zato.

``` {.python}
# lxml
from lxml.builder import E as e
from lxml.etree import tostring

# Zato
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        root = e.response(e.customer(e.preferred_currency('SGD')))
        self.response.payload = tostring(root)
```

``` {.xml}
$ curl localhost:11223/example -H 'SOAPAction:example' -d @soap1.xml
<?xml version='1.0' encoding='UTF-8'?>
 <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
  xmlns="https://zato.io/ns/20130518">
   <soap:Body>
    <response>
     <customer>
      <preferred_currency>SGD</preferred_currency>
     </customer>
    </response>
   </soap:Body>
  </soap:Envelope>
$
```

Invoking a SOAP service (from WSDL) {#progguide-examples-soap-invoking-wsdl}
===================================

If you created
an [outgoing SOAP connection \<../../web-admin/outgoing/soap\>]
using the serialization format of *Suds* and linked the connection to a WSDL,
the remote end can be invoked directly using pure-Python business objects
automatically read from the WSDL\'s XSD schema.

Note that the client object is based on [Suds](https://bitbucket.org/ovnicraft/suds/) and offers everything Suds does.

Assumming the WSDL is as [here](http://www.thomas-bayer.com/axis2/services/BLZService?wsdl) the code to invoke
it will be as follows - observe that no manual serialization is needed to invoke WSDL-based resources.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    """ Obtains BLZ bank details for input bank code.
    More about BLZ at Wikipedia - https://en.wikipedia.org/wiki/Bankleitzahl.
    """
    def handle(self):

        with self.outgoing.soap.get('BLZ').conn.client() as client:

            # Prepare input data
            bank_code = '12070000'

            # Only pure-Python objects are used to invoke a remote service
            output = client.service.getBank(bank_code)

            # Log response received
            self.logger.info('BIC `%s`', output.bic)
            self.logger.info('Name `%s`', output.bezeichnung)
```

In server.log:

``` {.python}
INFO - BIC `DEUTDEBB160`
INFO - Name `Deutsche Bank Ld Brandenburg`
```

Invoking a SOAP service (no WSDL) {#progguide-examples-soap-invoking-no-wsdl}
=================================

After creating an [outgoing SOAP connection \<../../web-admin/outgoing/soap\>]
with serialization format of *String*
and without providing a link to a WSDL, you need to invoke it with a string on input. The string will
be wrapped in a SOAP body by Zato. Likewise, Zato will add all the SOAP headers required.

Request and response as expected/returned by a sample
[CurrencyConverter](http://www.webservicex.net/CurrencyConvertor.asmx)
online:

``` {.xml}
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:web="http://www.webserviceX.NET/">
   <soapenv:Header/>
   <soapenv:Body>
      <web:ConversionRate>
         <web:FromCurrency>NOK</web:FromCurrency>
         <web:ToCurrency>HRK</web:ToCurrency>
      </web:ConversionRate>
   </soapenv:Body>
</soapenv:Envelope>
```

``` {.xml}
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/CurrencyConvertersoap/envelope/"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema">
   <soap:Body>
      <ConversionRateResponse xmlns="http://www.webserviceX.NET/">
         <ConversionRateResult>0.9384</ConversionRateResult>
      </ConversionRateResponse>
   </soap:Body>
</soap:Envelope>
```

It doesn\'t matter how a request is produced as long as an outgoing connection
is invoked with its string representation.

Sample code to invoke the service and get the conversion rate:

``` {.python}
# lxml
from lxml.etree import Element, fromstring, QName, SubElement, tostring

# Zato
from zato.server.service import Service

class MyService(Service):
    def handle(self):

        # Remote service's namespace
        ns = 'http://www.webserviceX.NET/'

        # Create a request
        root = Element(QName(ns, 'ConversionRate'), nsmap={None:ns})
        FromCurrency = SubElement(root, 'FromCurrency')
        ToCurrency = SubElement(root, 'ToCurrency')

        FromCurrency.text = 'NOK'
        ToCurrency.text = 'HRK'

        # Convert the XML object to string that will be wrapped in the SOAP body
        req = tostring(root)

        # Invoke a service and fetch its response
        response = self.outgoing.soap.get('CurrencyConverter').conn.send(self.cid, req)

        # Convert the response to XML and fetch the rate using XPath
        xml = fromstring(response.text.encode('utf-8'))
        rate = xml.xpath('//ws:ConversionRateResult/text()', namespaces={'ws':ns})

        # XPath above returned a one-element list of results hence index notation here
        self.logger.info(rate[0])
```

``` 
INFO - 0.9384
```
