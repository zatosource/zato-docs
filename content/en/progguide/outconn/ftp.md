---
title: FTP outgoing connections
---

Overview
========

Synchronously sends commands to a remote FTP server. Each service invocation
receives own connection which is closed after the service is done,
connections are not kept around across multiple invocations.

Commands are sent in a synchronous manner but they don\'t block the current server thread.

The underlying client FTP library is [fs](https://pypi.python.org/pypi/fs).

API
===

self.outgoing.ftp.get {#progguide-outconn-ftp-get}
---------------------

Usage example
=============

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):

        # Assumes there's been a 'Linux kernel FTP' connection created
        # which points to kernel.org
        conn = self.outgoing.ftp.get('Linux kernel FTP')
        data = conn.getcontents('/pub/site/README')

        self.logger.info(data)
```

``` {.python}
2013-04-24 00:08:43,711 - INFO - 32647:Dummy-7 - ftp1.my-service:33 - This
directory contains files related to the operation of the
kernel.org file itself.

The file sample_mirror_script.pl is a sample script for mirroring
kernel.org via rsync.
```
