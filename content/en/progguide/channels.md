---
title: Channels
---

![image](/gfx/progguide-channels.png){.align-center}

Services accept requests either from jobs initiated by the
[scheduler \<./scheduler\>] or via
[AMQP \<../web-admin/channels/amqp\>],
[IBM MQ \<../web-admin/channels/jms-wmq\>],
[plain HTTP \<../web-admin/channels/plain-http\>],
[SOAP \<../web-admin/channels/soap\>] and
[ZeroMQ \<../web-admin/channels/zmq\>]
channels.

Only HTTP channels are synchronous and make the requesting side wait before the response is ready.

Except for plain HTTP and SOAP channels, requests are accepted through connector
processes which publish messages on Zato broker off of which they are consumed by
services.

Plain HTTP and SOAP channels are exposed via Zato servers directly.

One of the key features of Zato is that precisely the same service can be exposed over
multiple channels without any changes to the service\'s implementation. That is,
once the service has been written and deployed, it\'s only a matter of a server\'s
configuration to make a service available through, say, AMQP in addition to ZeroMQ
or HTTP.

Regardless of which channel a service was invoked over, the very same
[request and response objects \<./reqresp/index\>]
will be available, same
[attributes \<progguide-write-service-attributes\>]
and
[methods \<progguide-write-service-methods\>],
and the service
can make use of the same API for producing responses using
[Simple IO \<./sio/index\>],
[JSON \<./json\>],
[XML \<./xml\>]
or
[any other data format \<./other-formats\>].

Note that you always need to take
[high-availability (HA) \<../admin/guide/ha\>]
into account, particularly so
if you\'re using
[AMQP \<../web-admin/channels/amqp\>],
[IBM MQ \<../web-admin/channels/jms-wmq\>]
or
[ZeroMQ \<../web-admin/channels/zmq\>] channels.
