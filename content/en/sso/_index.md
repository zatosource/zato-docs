---
title: Single Sign-On and user management API
---

Overview
========

![image](/gfx/sso/intro.png)

Zato offers a series of secure REST endpoints that let applications manage users in an API-driven manner -everything from signup, sessions to password reset is accessible through APIs,
without a need for applications to maintain their own databases or servers.

All of the endpoints are SSO-aware (Single Sign-On) which allows people to transparently make use of multiple applications
without a need for entering credentials in each one.

The same functionality is available to programmers developing Zato services in Python - opening doors to endless API interaction
possibilities - from synchronization using IBM MQ, through FTP data export, ZeroMQ alerts to AMQP events and more,
there are no limits to the kind of processes that can be handled.

Key features
============

-   Powerful yet straightforward
-   Programming-language independent, may be used from Python, JavaScript, Java, .NET or others
-   Very well suited for modern mobile, serverless, WebSocket-based or single-page applications
-   Secure storage, including encryption and customizable password hashing with strong defaults
-   Supports a variety of workflows, easy to plug into new or existing environments
-   Audit log to trace access to PII (Personally Identifiable Information)
-   Scriptable from command line

Topic guides
============

+----------------------------------+----------------------------------+
| Topic                            | Description                      |
+==================================+==================================+
| [Quick reference                 | PI calls and methods             |
| \<./ref\>] All A     |                                  |
+----------------------------------+----------------------------------+
| [Users                           | e, manage and access user        |
| \<.                              | accounts                         |
| /topic/user/index\>] |                                  |
| Creat                            |                                  |
+----------------------------------+----------------------------------+
| [Sessions                        | ng users in or out and checking  |
| \<./to                           | their existing sessions          |
| pic/session/index\>] |                                  |
| Loggi                            |                                  |
+----------------------------------+----------------------------------+
| [Passwords                       | cement and validation of user    |
| \<./top                          | passwords                        |
| ic/password/index\>] |                                  |
| Enfor                            |                                  |
+----------------------------------+----------------------------------+
| [Configuration                   | tuning the system                |
| \<./config/index\>]  |                                  |
| Fine-                            |                                  |
+----------------------------------+----------------------------------+
| [Audit                           | kind of information is stored    |
| \<./audit/index\>]   | where, when and how to access it |
| What                             |                                  |
+----------------------------------+----------------------------------+
| [Command line interface          | > commands for admins to use     |
| \                                |                                  |
| <../admin/cli/sso\>] |                                  |
| Shell                            |                                  |
+----------------------------------+----------------------------------+
| [Status codes                    | ngs and errors returned by APIs  |
| \<./status-code\>]   |                                  |
| Warni                            |                                  |
+----------------------------------+----------------------------------+
