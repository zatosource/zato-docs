---
title: ZeroMQ outgoing connections
---

Overview
========

Uses a PUSH socket to send messages to a remote PULL ZeroMQ socket.

The underlying client ZeroMQ library is [pyzmq-static](https://pypi.python.org/pypi/pyzmq-static).

API
===

self.outgoing.zmq.send {#progguide-outconn-zmq-send}
----------------------

Usage example
=============

``` {.python}
# stdlib
from datetime import datetime
from json import dumps

# Zato
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        out_name  = 'Debit Card Operations Log'
        request = {'card_no':123, 'withdraw':45.0, 'ts':datetime.utcnow().isoformat()}

        self.outgoing.zmq.send(dumps(request), out_name)
```

``` {.python}
# stdlib
import logging

# zmq
import zmq

context = zmq.Context()
socket = context.socket(zmq.PULL)
socket.bind('tcp://127.0.0.1:35101')

logging.basicConfig(level=logging.DEBUG)

while True:
    msg = socket.recv_json()
    logging.debug('Got message:[{}]'.format(msg))

    # A real server would do something useful here..
```

``` {.python}
DEBUG:root:Got message:[{u'ts': u'2013-04-27T10:49:57.475841',
    u'withdraw': 45.0, u'card_no': 123L}]
```
