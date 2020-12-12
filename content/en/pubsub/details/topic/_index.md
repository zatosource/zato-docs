---
title: Publish/subscribe topics
---

Preliminary materials: [Pub/sub architecture \<../../arch/index\>].

Overview
========

In a typical point-to-point system, applications send messages to each other directly, usually knowing who the recipient
or recipients will be.

On the other hand, publish/subscribe workflows are arranged around a concept of messages published to topics with possibly
many subscribers about whom the publishing endpoint may not have any foreknowledge.

For instance, a CRM system may want to publish events about changes to customer accounts - in an enterprise system there will
various recipients interested in this information but the CRM itself does not need to know what they are.

Another example may be an exchange rates system publishing information about latest rates - there may be dozens or hundreds
of applications subscribed to this stream of updates, each independently consuming the information but the source system does not
have to know who they are, it just focuses on publications and delivery to subscribers is carried out by Zato.

Each topic has a unique name which represents the business subject of the information that can be published to it,
that is, names are descriptive and relate to the business purpose of the topic.

Topic names follow a hierarchical tree of elements, from the least specific to the most specific ones. Slash */* has a special
meaning and is used to separate business components of the name. It is up to users to decide how deeply nested, if at all,
a topic\'s name should be. Names must be ASCII-only and they cannot exceed 200 characters.

An example topic could belong to a network of IoT devices with one of topics being */asia/sg/changi/building/3/floor/9* -used to represent events related to devices from the 9th floor of Building 3 in the Changi Business Park in Singapore, Asia.

Another example name could be */customer/new* used by applications to publish and consume messages about new customers in a
particular system.

Configuration
=============

![image](/gfx/pubsub/details/topic-create.png)

Each name must be unique - details of how to form names are presented in the overview of this chapter.

A topic may be active or inactive. If it\'s inactive, no new messages can be published to it. If clients try to do it,
they will receive an error message.

When a message is published to the topic, its list of recipients is established once, at the time when the message is published.
If subscribers appear while the message is being delivered to the original recipients, the new ones will not receive
the message.

Each topic may have Guaranteed Delivery (GD) enabled. This setting indicates if messages published to the topic should be
by default covered by GD although it can also be set or overridden on a per-message basis.

If a message uses GD, its contents will be stored in an SQL database until all subscribers to the topic existing at the time
of the message\'s publication confirm that they have received it.

Messages to non-GD topics that have no subscribers at the time of their publications are turned into GD ones.

For each topic, it is possible to set a flag that allows external API clients to subscribe to it. If it is not checked,
only administrators will be able to create new subscriptions to that topic. In some cases, tight oversight is required
over what applications subscribe to a topic and API subscriptions may be turned off. In other cases, there may be so
many dynamic and transient subscribers that manual administration will not be feasible, in this situation, API subscriptions
can be enabled.

WebSockets-based clients always subscribe through API calls and in scenarios utilizing WebSockets clients,
API subscriptions must be enabled for their relevant topics.

Topics have their depths - maintained individually for GD and non-GD (in-RAM) messages. If current depth reaches the maximum,
all new messages will be rejected. A topic\'s depth has no fixed limits but note that in-RAM messages are indeed kept in RAM
of servers which are usually a resource more scarcer than disk storage for GD ones - care must be taken so as not to run out
of RAM.

Depth check frequency specifies after one in how many messages current depth will be checked to have reached its maximum value.
For instance, assume a topic has depth of 1000 and the frequency is 100. Since after 1 in 100 messages published the depth will be
checked, it is possible that the depth will actually reach 1100 in the worst case before it is found out that no new messages
should be allowed.

The reason for not checking it exactly before each publication is efficiency - in most business applications,
there is almost never any difference if there are a few dozens more messages in the topic yet the performance can be increased
by about 15% if only 1 in 100 is checked. If absolute correctness is required, the frequency can be set to 1, meaning each
and every message published will trigger a depth check.

With non-GD messages, current topic\'s depth is calculated separately for each Zato server. For GD topics, it is counted globally.

Sync and delivery intervals concern how often servers will internally synchronize the current state of deliveries to a particular
topic. For each topic, there is exactly one server that will be responsible for deliveries to that topic. Delivery interval
indicates how often this server will push out its messages to recipients. Conversely, sync interval dictates how often other
server push out messages they received for topic to that delivery server.

For each topic it is possible to assign a service that will execute at specific points,
e.g. before the message is published or before it is delivered to a subscriber. The service has access to full business
data and metadata. This lets one, for instance, to transform messages on a per-recipient basis, possibly
including changing its data format or enrichment with data obtained by invoking other services.
