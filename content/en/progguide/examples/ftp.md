---
title: FTP usage examples
---

FTP servers are accessed through the
[fs](http://docs.pyfilesystem.org/en/latest/)
library and any method
the library supports is available to Zato services as well.

Hence the code below serves as a set of examples only, it\'s not a full reference.

Putting files on server {#progguide-examples-ftp-putting}
=======================

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        conn = self.outgoing.ftp.get('My FTP')
        contents = conn.setcontents('/tmp/myfile', 'Hello\nFTP!\n')
```

``` 
$ cat /tmp/myfile
Hello
FTP!
$
```

Listing directories {#progguide-examples-ftp-listing}
===================

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        conn = self.outgoing.ftp.get('My FTP')
        listing = conn.listdir('/usr')
        self.logger.info(listing)
```

``` {.python}
INFO - [u'bin', u'src', u'sbin', u'lib32', u'lib', u'share', u'include']
```

Reading files {#progguide-examples-ftp-reading}
=============

``` 
$ cat /tmp/myfile
123
456
789
$
```

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        conn = self.outgoing.ftp.get('My FTP')
        contents = conn.getcontents('/tmp/myfile')
        self.logger.info(contents)
```

``` 
INFO - 123
456
789
```
