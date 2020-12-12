---
title: CSV examples
---

Reading CSV on input {#progguide-examples-csv-request}
====================

Regardless of what [channel \<../channels\>] CSV data will be sent in, it\'s available
in self.request.payload and can be parsed using Python\'s built in
[csv](http://docs.python.org/2.7/library/csv.html)
module which lets you choose, among
other things, what delimiter or dialect (such as Excel) to use.

``` 
taxon_id,resource_id,spp_id,scientific_name
plants,USDA_2012dl,,Allium aaseae,,Allium
,,EUAA,
plants,USDA_2012dl,ERAB3,Erigeron abajoensis
```

``` {.python}
# stdlib
import csv

# Zato
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        for row in csv.DictReader(self.request.payload.splitlines()):
            self.logger.info(row['scientific_name'])
```

``` 
INFO - Allium aaseae
INFO -
INFO - Erigeron abajoensis
```

Producing CSV {#progguide-examples-csv-response}
=============

Create the appropriate Content-Type header and assign a string representation
of CSV data to self.response.payload.

It doesn\'t matter how the string is produced
as long as it\'s assigned to self.response.payload and Zato can return it.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        data = []

        data.append('Archaea;Aeropyrum')
        data.append('Archaea;Desulfurococcus')
        data.append('Archaea;Ignicoccus')

        self.response.payload = '\n'.join(data)
        self.response.content_type = 'text/csv'
```

``` {.text emphasize-lines="14,17-19"}
$ curl -v localhost:17010/example
* About to connect() to localhost port 17010 (#0)
*   Trying 127.0.0.1... connected
> GET /example HTTP/1.1
> User-Agent: curl/7.22.0 (x86_64-pc-linux-gnu) libcurl/7.22.0 OpenSSL/1.0.1
> Host: localhost:17010
> Accept: */*
>
< HTTP/1.1 200 OK
< Server: gunicorn/0.16.1
< Date: Mon, 01 Jul 2013 19:19:53 GMT
< Connection: keep-alive
< Transfer-Encoding: chunked
< Content-Type: text/csv
< X-Zato-CID: K154603402599025049106318218400849260983
<
Archaea;Aeropyrum
Archaea;Desulfurococcus
Archaea;Ignicoccus
* Connection #0 to host localhost left intact
* Closing connection #0
$
```
