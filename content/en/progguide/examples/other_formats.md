---
title: Other data formats
---

Reading arbitrary data formats {#progguide-examples-other-formats-reading}
==============================

If not using
[SIO \<./sio\>],
[XML \<./xml\>],
[SOAP \<./soap\>]
or
[CSV \<./csv\>],
data in virtually any format can be accepted
but the so called \'binary\' data needs to be encoded using, for instance, BASE64.
Zato doesn\'t place any limits on what sort of information is exchanged and how it\'s
represented.

Regardless of the format, the request it\'s always available in self.request.payload.

Accessing BASE64-encoded data {#progguide-examples-other-formats-base64}
=============================

When a service is sent BASE64-encoded data it can be decoded from self.request.payload
like that:

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        data = self.request.payload.decode('base64')
        self.logger.info(data)
```

``` 
$ curl localhost:11223/example -d 'SGVsbG8gWmF0byE=\n'
$
```

``` 
INFO - Hello Zato!
```
