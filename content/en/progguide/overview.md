Overview
========

You
[develop \<./service-dev\>]
[services \<progguide-what-is-a-service\>]
and
[applications \<progguide-what-is-an-application\>]
using Python, a very high-level,
full featured and highly productive, programming language, that allows you to
implement any solution of any scale and size, from tiny ones to the very
largest.

Code you develop is
[hot-deployed or installed statically \<../admin/guide/installing-services\>]
on servers running in high-availability clusters.

You have access to a browser-based
[web admin \<../web-admin/intro\>]
which aids you with development and maintenance.

Your code can both
[invoke \<./outconn/overview\>]
or
[accept connections \<./channels\>]
through the most commonly used
protocols and transports -[Plain HTTP, SOAP, JSON \<./outconn/http\>],
[AMQP \<./outconn/amqp\>],
[IBM MQ \<./outconn/jms-wmq\>],
[ZeroMQ \<./outconn/zmq\>],
[SQL \<./outconn/sql\>],
and
[FTP(S) \<./outconn/ftp\>].

[Services can invoke each other \<./invoking-services\>] and other Python
applications can use [a convenience client \<./clients/python\>] to access
your services programmatically.

At your disposal are also
[Redis key/value database \<./kvdb\>]
and a built-in
[scheduler \<./scheduler\>]
which is used for executing recurring tasks.

Servers know how to secure and to make use of resources secured with
[HTTP Basic Auth \<../web-admin/security/basic-auth\>]
and
[WS-Security \<../web-admin/security/ws-security\>].

Zato\'s
[SimpleIO (SIO) \<./sio/index\>]
mechanism allows you to write code once while still being able to expose
it through multiple protocols and interfaces without any code change nor restarts.

You are supported in writing code that is easy to
test
and
[document \<./documenting\>].

While technically possible, you\'ll rarely, if ever, use HTML or CSS. Zato is a
[middleware and backend server \</intro/overview-high-level\>]. Consider using
[Django](https://djangoproject.com) or a similar technology for frontend programming.

What is a service {#progguide-what-is-a-service}
=================

A service is a piece of reusable code which does something interesting and useful for its users.
Think of it as an atomic building block of the Zato-based solution you want to develop.

For instance, if you are writing a [CRM system](https://en.wikipedia.org/wiki/Customer_relationship_management)
you will need services that are to do with customer details - returning
a customer\'s addresses, fetching their products, getting their details,
these are all typical services you\'ll have to develop.

In another scenario, when integrating multiple applications in a
[SOA](https://en.wikipedia.org/wiki/Service-oriented_architecture), you may want
want to create a composite service that will invoke lower-level services of applications
being integrated, aggregate their output and present a unified view to applications
that invoke your service.

From another point of view, a service is like a function or method in your programming
language, only catapulted to a much higher level - instead of exposing API to other
classes or modules, you operate with services and data-sources dispersed across
many applications and systems.

Reusability is the key to creating successful services. Services should be reusable
across multiple applications, regarding of programming languages they\'re implemented in
or particulars of any specific data format they may use internally or when connecting to Zato.

What is an application {#progguide-what-is-an-application}
======================

An application is simply a set of [services \<progguide-what-is-a-service\>]
you, as a human being, attach a special meaning to.

There is no custom application packaging format nor does Zato know that what
you call an application is more than just one or more services that are logically
grouped together.

Programming examples
====================

[Click here \<./examples/index\>] to visit a chapter with programming examples.
