---
title: AMQP outgoing connections
---

Overview
========

Asynchronously sends a message to an AMQP exchange using
[connection \<../../web-admin/conn-def/amqp\>]
[parameters \<../../web-admin/outgoing/amqp\>]
specified.

The message is first published on the [Zato broker \</architecture/redis\>]
off of which the connector process responsible for communication with this particular
AMQP broker picks it up and actually sends it to the remote exchange.

Note that the connection to the broker is initialized in a lazy fashion, it will
be established the first time it\'s needed.

The underlying client AMQP library is [Kombu](https://kombu.readthedocs.org/).

API
===

self.outgoing.amqp.send {#progguide-outconn-amqp-send}
-----------------------

Usage example
=============

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):

        # Request parameters
        msg = 'Hello AMQP broker!'
        out_name = 'CRM1'
        exchange = 'CRM1'
        routing_key = ''
        properties = {'app_id': 'ESB'}
        headers = {'X-Foo': 'bar'}

        # Send a message to the broker
        self.outgoing.amqp.send(msg, out_name, exchange, routing_key,
            properties, headers)
```

We can now observe that a message sent to the CRM1 exchange ..

![image](/gfx/progguide/outconn-amqp-exch.png){.align-center}

went straight to the queue bound to the exchange - named CRM1 as well.

![image](/gfx/progguide/outconn-amqp-queue.png){.align-center}
