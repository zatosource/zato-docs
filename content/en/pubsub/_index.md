---
title: Publish/subscribe topics and guaranteed delivery queues
---

What is publish/subscribe?
==========================

![image](/gfx/pubsub/intro.png)

Constituting a core part of Zato, publish/subscribe message brokering facilities simplify integration of distributed and diverse
applications, including cloud-based, on premise, mobile and IoT ones.

Integrated environments can be created using an event-based approach of publishers sending
messages to topics out of which they are delivered to independent subscribers. This promotes the
architecture that can dynamically adapt to business and technical changes - application can come and go freely without
influencing each other.

While in transit, data is kept in message queues that ensure integrity and availability of the system. Should a subscribing
application go down, messages are safely retained until the recipient is ready to read them again.

Publishers and subscribers may use different communication protocols or data formats. Each subscriber may choose its own
preferred method.

Python programmers and administrators use a browser-based GUI to access configuration and run-time data, including ability to read
message queues and update their contents in place.

Publish/subscribe provides topics, queues, routing, security, APIs and administration facilities - applications
publish and consume messages using REST, AMQP, SOAP, WebSockets, Zato services, file transfer or Java JMS.

Topics
======

> -   **Architecture:**
>     [High-level overview \<./arch/index\>]
> -   **Details:**
>     [Topics \<./details/topic/index\>] \|
>     [Endpoints \<./details/endpoint/index\>] \|
>     [Subscriptions \<./details/sub/index\>]
> -   **Usage:**
>     [REST \<./api/rest\>] \|
>     [AMQP \<./details/endpoint/amqp\>] \|
>     [SOAP \<./details/endpoint/soap\>] \|
>     [WebSockets \<./api/wsx\>] \|
>     [Zato services \<./api/zato-service\>] \|
>     [File transfer \<./details/endpoint/file\>]
> -   **Security:**
>     [Securing access to topics and queues \<./sec/index\>]
