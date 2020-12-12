---
title: Outgoing connections
---

![image](/gfx/progguide-outconn.png){.align-center}

Each service can automatically access external resources using a range of protocols
documented in subsequent chapters.

HTTP-based publish/subscribe offers another alternative to direct messaging between applications
and is [documented \<../../pubsub/index\>] separately.

Some of the protocols are synchronous while communicating over the rest is
performed asynchronously, in a fire-and-forget manner.

Note that you always need to take
[high-availability (HA) \<../../admin/guide/ha\>]
into account, particularly so
if you\'re using
[AMQP \<./amqp\>] or
[IBM MQ \<./jms-wmq\>]
outgoing connections.

  Protocol                                                                              Synchronous
  ------------------------------------------------------------------------------------- -------------
  [AMQP \<./amqp\>] \-\--[Cassandra CQL \<./cassandra\>] Yes    
  [ElasticSearch \<./es\>] Yes                                              
  [FTP \<./ftp\>] Yes                                                       
  [HTTP \<./http\>] Yes                                                     
  [IMAP \<./imap\>] Yes                                                     
  [IBM MQ \<./jms-wmq\>] \-\--[Odoo (OpenERP) \<./odoo\>] Yes   
  [SMTP \<./smtp\>] Yes                                                     
  [Solr \<./solr\>] Yes                                                     
  [SQL \<./sql\>] Yes                                                       
  [ZeroMQ \<./zmq\>] \-\--                                                  

::: {.note}
::: {.title}
Note
:::

There\'s nothing preventing you from accessing external resources using
other transfer protocols.

You won\'t have any particular support for doing
so from Zato but the platform itself doesn\'t disallow using any other means of
communicating if you establish and maintain the connections yourself.

Do keep
in mind though that Zato servers use a gevent-based main loop so TCP connections
should be created in pure-Python code, preferrably, rather than in C.
:::
