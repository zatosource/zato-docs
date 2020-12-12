---
title: Request objects
---

Overview
========

All services always have access to the attributes which describes the request being handled in a general way.
Additionally, protocol-specific attributes, such as *self.request.http* cover information pertaining to information that
is limited to a particular protocol.

Most commonly accessed attributes are:

  Attribute                  Description
  -------------------------- -------------------------------------------------------------------------------------
  self.request.input         Used to access incoming data if [SimpleIO \<../sio/index\>] is used
  self.request.payload       Used to access incoming data if [SimpleIO \<../sio/index\>] is not used
  self.request.raw_request   Used to access incoming data in exactly the same format as it was received
                             by the service, prior to any parsing or transformations

The chapter first details common attributes and then goes into particulars of each protocol-specific part.

Several attributes and methods return Bunch instances - they are dict-like objects that support dot-notation access
in addition to regular dict methods, e.g.

``` {.python}
def handle(self):

  # Assume there was a parameter called 'user_id' in request
  data = self.request.bunchified()

  # This will return the ID ..
  self.logger.info(data.user_id)

  # .. and so will this.
  self.logger.info(data['user_id'])
```

Common attributes
=================

Attributes listed in this section are available to all services, regardless of what kind of channel they are invoked over,
be it HTTP, AMQP, ZeroMQ, scheduler, SQL notifications or any other.

  Attribute                        Description
  -------------------------------- ----------------------------------------------------------------------------------------------------
  self.request                     Along with self.channel, one of main attributes describing incoming messages
  self.request.raw_request         Input message exactly as it was received, byte-for-byte, prior to any transformations
                                   or parsing attempts on Zato end
  self.request.input               Input message after parsing it into a channel-specific data format. For JSON messages,
                                   this will be a Bunch object. Available only if [SimpleIO \<../sio/index\>] is used.
  self.request.payload             Input message after parsing it into a channel-specific data format. For JSON messages,
                                   this will be a dict object. Available even if [SimpleIO \<../sio/index\>] is not used.
  self.request.bunchified()        Returns a Bunch version of self.request.raw_request. Works only with JSON input.
  self.request.deepcopy()          Returns a deep copy of self.request
  self.channel                     Along with self.request, describes data and metadata about incoming messages. Unlike self.request,
                                   this attribute is the same for all requests coming through the same channel, i.e. it describes
                                   details of the channel itself rather than each individual message received.
  self.channel.name                Name of the channel the request was received through
  self.channel.type                Type of the channel - will be equal to one of the constants in zato.common.CHANNEL
  self.chan                        Alias to self.channel
  self.channel.security            Describes a security definition attached to the channel, if any is at all
  self.channel.security.name       Name of the security definition
  self.channel.security.username   Username used to invoke the channel, if applicable for a particular security type
  self.channel.security.type       Type of the security definition - will be equal to one of the constants
                                   in zato.common.SEC_DEF_TYPE
  self.channel.sec                 Alias to self.channel.security

HTTP-specific attributes
========================

  Attribute                  Description
  -------------------------- ----------------------------------------------------------------------------------------------------
  self.request.http          The attribute to use to access HTTP-specific information
  self.request.http.method   HTTP method used to invoke the service
  self.request.http.GET      All GET parameters as a Bunch object, each value is either an exact one received or a list of
                             values if there were more than one for a given key
  self.request.http.POST     All POST parameters as a Bunch object, each value is either an exact one received or a list of
                             values if there were more than one for a given key. Available only if there is no data format
                             set for channel.
  self.request.http.path     URL path that the request was received through, e.g. */customer/123* in
                             \"<https://localhost:17010/customer/123>\", does not include query string
  self.request.http.params   A Bunch object with a concatenation of query string and path parameters. Available even
                             if [SimpleIO \<../sio/index\>] is not used.
  self.wsgi_environ          While not belonging directly to self.request.http, each service can always have access to the full
                             WSGI dictionary of data and metadata about the request

AMQP-specific attributes
========================

  Attribute                    Description
  ---------------------------- --------------------------------------------------------------
  self.request.amqp            The attribute to use to access AMQP-specific information
  self.request.amqp.msg        Low-level object representing the incoming message
  self.request.amqp.ack()      Used by services to acknowledge the reception of a message
  self.request.amqp.reject()   Used by services to reject a message back to the AMQP broker

IBM MQ-specific attributes
==========================

  Attribute                            Description                                                    MQMD equivalent
  ------------------------------------ -------------------------------------------------------------- -----------------
  self.request.ibm_mq                  The attribute to use to access IBM MQ-specific information     \-\--
  self.request.ibm_mq.msg_id           Message ID                                                     MsgId
  self.request.ibm_mq.correlation_id   Correlation ID                                                 CorrelId
  self.request.ibm_mq.timestamp        Timestamp of when the message was created                      \-\--
  self.request.ibm_mq.put_date         Date part of when the message was enqueued                     PutDate
  self.request.ibm_mq.put_time         Time part of when the message was enqueued                     PutTime
  self.request.ibm_mq.reply_to         To what queue responses should be sent, if any are expected    ReplyToQ
  self.request.ibm_mq.mqmd             The whole MQMD header as it was received from MQ               MQMD
  self.request.ibm_mq.data             The same as self.request.raw_request - added for convenience   \-\--

More information
================

-   Consult the [dedicated chapter \<../examples/index\>] with programming examples for more details.
-   To learn more about SimpleIO, click [here \<../sio/index\>]
-   Visit [this chapter \<./response\>] to read more about response objects