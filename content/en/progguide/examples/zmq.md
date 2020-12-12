---
title: ZeroMQ usage examples
---

Receiving messages from queues {#progguide-examples-zmq-receiving}
==============================

No programming is needed to receive messages from ZeroMQ sockets. Create a new
[ZeroMQ channel \<../../web-admin/channels/zmq\>]
and a given service will be invoked for each message taken from a socket.
The request will be in self.request.payload.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        self.logger.info('Got message: {}'.format(self.request.payload))
```

Sending messages to sockets {#progguide-examples-zmq-sending}
===========================

Create a new
[outgoing ZeroMQ connection \<../../web-admin/outgoing/zmq\>]
and send a message like in the example below.

The API is documented [here \<../outconn/zmq\>].

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        self.outgoing.zmq.send('my-message', 'outconn-name')
```
