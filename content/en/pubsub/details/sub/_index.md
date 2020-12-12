---
title: Subscriptions
---

Preliminary materials: [Pub/sub architecture \<../../arch/index\>].

Overview
========

A subscription needs to be created before an endpoint can consume messages from a given topic.
Depending on particular needs, subscriptions can and may be created either manually using web-admin or through API calls.

Stemming from their specific connection requirements, subscriptions for WebSockets endpoints cannot be created in web-admin
in advance by administrators.

Creating subscriptions
======================

In web-admin, go to *Pub/sub* → *Subscriptions* → *Create new pub/sub subscriptions*.

![image](/gfx/pubsub/details/sub-create.png)

All subscriptions are grouped by an endpoint\'s type. Choosing one of types re-populates the form with elements specific to this
kind of endpoints.

Each subscription has a delivery server - this is one of servers in the Zato cluster that will queue up in-RAM all messages
destined for a particular endpoint. It will be also the server that will send outgoing pub/sub messages to the endpoint.

For each endpoint type, one of endpoints need to be selected. Doing it will add to the form all the topics that the chosen
endpoint is allowed to subscribe to.

If an endpoint is already subscribed to a topic, the topic will be grayed out and disabled to indicate it. Otherwise,
clicking the checkbox or the Toggle link will enable the subscription. Clicking the topic\'s name will open the topic\'s details
in a new tab. There needs to be always at least one new topic toggled when submitting the form, otherwise an error will
be reported.

A subscription has a delivery method - Notify or Pull. If Notify, Zato will send all the messages to the subscribers as they
appear in topics. If Pull, this indicates that the endpoint will periodically connect to Zato to check if there are new messages
and Zato will not deliver them itself.

Delivery batch size specifies at most how many messages to deliver to the endpoint in one call. If \"list required\" is selected,
all the messages will be always sent wrapped in a list even if there is only one message to be delivered, in which case
the list will have only that one element.

Delivery max retries signifies after how many delivery attempts of a single message Zato should abandon the task of delivery
if the message cannot be delivered for any reason - be it a network or any other error.

If there is any error during delivery of messages to the endpoint, the delivery task for this endpoint will pause for a configured
time, which can be specified separately for TCP-level or other errors. All errors such as \"No route to host\" or \"Unknown host\"
are grouped under TCP error. Other errors include situations where there is TCP connectivity but the endpoint still rejects the
message.

For REST and SOAP endpoints, the HTTP method to use during deliveries can be chosen. If delivery method is Notify,
for endpoints of this type it an outgoing connection needs to be also picked to deliver the messages through.

Clicking \"OK\" will create the subscription and start a background delivery task, assuming that the delivery server
is up and running.

Updating an endpoint\'s subscriptions
=====================================

In web-admin, go to *Pub/sub* → *Subscriptions* → Click *\# of subscriptions* for the required endpoint.
→ Click *Edit* for the required topic

![image](/gfx/pubsub/details/update-sub1.png)

![image](/gfx/pubsub/details/update-sub2.png)

![image](/gfx/pubsub/details/update-sub3.png)

All of the fields in the edit form have the same meaning as in the creation form with the following notes:

-   If a delivery server is changed, all new messages for that topic and endpoint will be routed through the new server.
    Any outstanting messages will not be migrated to the new server and will continue to be delivered using the old server.

-   Subscription state can have one of four values:

      State         Notes
      ------------- ----------------------------------------------------------------------------------------------
      Pub and sub   Messages published to topics will be sent to the endpoint\'s delivery queue and the endpoint
                    is allowed to consume them
      Pub only      Messages published to topics will be sent to the endpoint\'s delivery queue but the endpoint
                    is not allowed to consume them
      Sub only      No new messages may be sent to the endpoint\'s delivery queue but the endpoint is allowed
                    to consume all the messages that are in its queue
      Disabled      No new messages will be sent to the endpoint\'s delivery queue and the endpoint
                    is not allowed to consume any that are in its queue

Deleting an endpoint\'s subscriptions
=====================================

In web-admin, go to *Pub/sub* → *Subscriptions* → Click *\# of subscriptions* for the required endpoint
→ Click *Delete* for the required topic.

Deleting a subscription for a topic that an endpoint is subscribed to will stop the delivery of any GD or in-RAM messages
and will ensure that no further messages for this topic will be sent to the chosen endpoint. This operation cannot be undone.

Browsing subscription queues
============================

In web-admin, go to *Pub/sub* → *Subscriptions* → Click *\# of subscriptions* for the required endpoint
→ Click *Total* for the required topic.

![image](/gfx/pubsub/details/browse-list.png)

![image](/gfx/pubsub/details/browse-details.png){width="98.0%"}

For each queue of outgoing messages pertaining to a particular subscription, it is possibly to list all of them, including
GD and in-RAM ones. Entering search terms will narrow down the results to these messages that contain a substring in their
message prefix (first 64 bytes).

Clicking on a message\'s ID leads to a page containing both data and metadata about a message, including information about
what matching security patterns led to the appearance of the message in this endpoint\'s queue for topic.

WebSockets
==========

WebSockets-based endpoints [subscribe to topics using the public API \<../../api/wsx\>] - this is because there is no way
to predict to which server a given WebSocket connection will be routed from the cluster\'s load-balancer which in turn means that
it is impossible to choose any particular delivery server in the web-admin.

File transfer
=============

Subscriptions for file transfer are regular subscriptions to topics, just like with any other publisher. For instance,
if an endpoint wishes to subscribe to new invoices from topic */invoices/new*, an administrator may create such a subscription
in web-admin and file transfer messages, once [configured \<../../details/endpoint/file\>], will be delivered to that topic as they
arrive in the filesystem, and out of the topic they will be sent to the endpoint\'s queue.
