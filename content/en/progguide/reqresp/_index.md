---
subtitle: Overview
title: Request and response objects
---

[Request \<./request\>]
and
[response \<./response\>]
objects encapsulate information regarding the data a service
receives and produces. Both objects will always exist for each service invocation
but their payload can be empty, it is perfectly fine for a service not to accept
any input data nor to create output either.

Their respective chapters document how to work with requests and responses, including how to access or produce
protocol-specific metadata, such as HTTP or AMQP headers:

-   Details of [requests \<./request\>] objects
-   Details of [response \<./response\>] objects
