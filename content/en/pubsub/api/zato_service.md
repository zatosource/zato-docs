---
title: Pub/sub - API - Zato services
---

Preliminary materials: [Pub/sub architecture \<../arch/index\>].

Overview
========

From the perspective of Zato service authors, publish/subscribe offers a few methods for publications and reception
of messages:

  Method                                Notes
  ------------------------------------- --------------------------------------------------------------------------
  self.pubsub.publish                   Sends a message to input topic
  self.pubsub.subscribe                 Subscribes to a topic, returning subscription key on output
  self.pubsub.get_messages              Receives all outstanding messages from input queue by subscription key
  self.pubsub.resume_wsx_subscription   Invoked on behalf of WebSocket clients to resume delivery of messages
                                        for an already existing subscription key after clients reconnect to Zato

Note that *get_messages* expects a subscription key - this is because there may be multiple subscriptions
for each topic so the method needs to know from whose queue to return the messages and it is subscription key
that points to each queue.

Security-wise, methods *publish* and *subscribe* check if the endpoints given to them on input have
correct permissions to topics that the endpoints are about to publish or subscribe to.

On the other hand, *get_messages* assumes that the service that execute it has already carried out any necessary
input validation and authentication or authorization checks, i.e. the method should be used in
trusted code paths because it potentially allows one to access any arbitrary topics and subscriptions.

self.pubsub.publish
===================

    # -*- coding: utf-8 -*-

    from __future__ import absolute_import, division, print_function, unicode_literals

    from zato.server.service import Service

    class PublishSample(Service):
        def handle(self):

            # Prepare input
            topic_name = '/zato/demo/sample'
            data = 'My data'
            priority = 9

            # Publish the message
            msg_id = self.pubsub.publish(topic_name, data=data, priority=priority)

            # Log the message ID received
            self.logger.info('Message ID is `%s`', msg_id)

    INFO - Message ID is `zpsmc53c2e078eafd1c476b49623`

![image](/gfx/pubsub/api/python-publish.png){width="99.0%"}

self.pubsub.subscribe
=====================

How to subscribe non-WebSocket endpoints
----------------------------------------

    # -*- coding: utf-8 -*-

    from __future__ import absolute_import, division, print_function, unicode_literals

    from zato.server.service import Service

    class SubscribeWebSocket(Service):
        def handle(self):

            # Prepare input
            topic_name = '/zato/demo/sample'
            endpoint_name = 'My REST Endpoint'

            # Subscribe an explicitly named endpoint..
            sub_key = self.pubsub.subscribe(topic_name, endpoint_name=endpoint_name)

            # .. and log the subscription key received.
            self.logger.info('Received sub_key `%s`', sub_key)

    INFO - Received sub_key `zpsk.rest.a01be4755a87d6fd24276929`

How to subscribe WebSockets
---------------------------

    # -*- coding: utf-8 -*-

    from __future__ import absolute_import, division, print_function, unicode_literals

    from zato.server.service import Service

    class SubscribeWebSocket(Service):
        def handle(self):

            # Prepare input
            topic_name = '/zato/demo/sample'

            # Subscribe current WebSocket ..
            sub_key = self.pubsub.subscribe(topic_name, use_current_wsx=True, service=self)

            # .. and log the subscription key received.
            self.logger.info('Received sub_key `%s`', sub_key)

    INFO - Received sub_key `zpsk.websockets.d552ea2b0f2ff7a3815f9282`

self.pubsub.get_messages
========================

    # -*- coding: utf-8 -*-

    from __future__ import absolute_import, division, print_function, unicode_literals

    from zato.server.service import Service

    class GetMessages(Service):
        def handle(self):

            # Prepare input
            topic_name = '/zato/demo/sample'
            sub_key = 'zpsk.rest.6b0b83ebea3f6e6a64e8e73f'

            # Get all messages available ..
            messages = self.pubsub.get_messages(topic_name, sub_key)

            # .. and log them all.
            self.logger.info('Messages `%s`', messages)

    INFO - Messages `[
      {
       u'delivery_count': 0,
       u'has_gd': False,
       u'server_name': u'server1',
       u'topic_name': u'/zato/demo/sample',
       u'pub_time_iso': u'2018-07-04T19:58:08.020493',
       u'priority': 5,
       u'expiration_time_iso': u'2086-07-22T23:12:15.020493',
       u'expiration': 2147483647000,
       u'server_pid': 19218,
       u'size': 27,
       u'data': u'This is a sample message #2',
       u'sub_key': u'zpsk.rest.6b0b83ebea3f6e6a64e8e73f',
       u'mime_type': u'text/plain'},
      {
        u'delivery_count': 0,
        u'has_gd': False,
        u'server_name': u'server1',
        u'topic_name': u'/zato/demo/sample',
        u'pub_time_iso': u'2018-07-04T19:58:01.144177',
        u'priority': 5,
        u'expiration_time_iso': u'2086-07-22T23:12:08.144177',
        u'expiration': 2147483647000,
        u'server_pid': 19218,
        u'size': 24,
        u'data': u'This is a sample message',
        u'sub_key': u'zpsk.rest.6b0b83ebea3f6e6a64e8e73f',
        u'mime_type': u'text/plain'
      }]`

self.pubsub.resume_wsx_subscription
===================================

    # -*- coding: utf-8 -*-

    from __future__ import absolute_import, division, print_function, unicode_literals

    from zato.server.service import Service

    class ResumeWSXSubscription(Service):
        def handle(self):

            # Prepare input
            sub_key = 'zpsk.wsx.6b0b83ebea3f6e6a64e8e73f'

            # Resume delivery for that key,
            # if there is no exception, it means that everything went fine
            self.pubsub.resume_wsx_subscription(sub_key, self)
