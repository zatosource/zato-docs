---
title: IBM MQ outgoing connections
---

Overview
========

Sends a message to an IBM MQ queue manager using
[connection \<../../web-admin/conn-def/jms-wmq\>]
[parameters \<../../web-admin/outgoing/jms-wmq\>]
specified.

The application on the receiving end may be written in Java
using MQ JMS API. This allows for seamless integration with Java JMS MQ systems -from their point of view Zato, despite being written in Python, will appear to be
a Java application.

::: {.note}
::: {.title}
Note
:::

Before making using of the connections,
[PyMQI needs to be first manually enabled \<../../admin/guide/enabling-extra-libs\>]
by administrators.
:::

API
===

self.outgoing.ibm_mq.send {#progguide-outconn-jms-wmq.send}
-------------------------

Usage example
=============

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):

        # Request parameters
        msg = 'Hello MQ!'
        out_name = 'Customer Cases'
        queue = 'CUSTOMER.CASES.1'

        # Send the message to a queue manager
        self.outgoing.ibm_mq.send(msg, out_name, queue)
```
