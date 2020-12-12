---
title: AMQP usage examples
---

Receiving messages from queues {#progguide-examples-amqp-receiving}
==============================

No programming is needed to receive messages from AMQP queues. Create a new
[AMQP channel \<../../web-admin/channels/amqp\>]
and a given service will be invoked for each message taken off a queue.
The request will be in self.request.payload.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        self.logger.info('Got message: {}'.format(self.request.payload))
```

Sending messages to exchanges {#progguide-examples-amqp-sending}
=============================

Create a new
[outgoing AMQP connection \<../../web-admin/outgoing/amqp\>]
and send a message like in the example below. The
[full API \<../outconn/amqp\>]
allows to set or override custom headers and properties.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        self.outgoing.amqp.send('my-message', 'outconn-name', '/exchange', 'route-key')
```
