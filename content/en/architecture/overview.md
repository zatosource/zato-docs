---
title: Architecture overview
---

Zato is composed of several components that cooperate with the aim of exposing
[services and applications \<../progguide/overview\>] to external clients.

![image](/gfx/arch-tech-overview.png){.align-center}

  -------------------------------------------------------- --------------------------------------------------------------------------------
  [Web admin\<./web-admin\>] Main              GUI for the management of servers running in clusters
  [HA load-balancer\<./load-balancer\>] Sits   in front of servers and distributes the incoming HTTP traffic in a fair manner
  [Servers\<./servers\>] The c                 entral piece where services are located. Servers are where HTTP, JSON, SOAP,
                                                           AMQP, IBM MQ, ZeroMQ, Redis, SQL and FTP are dealt with. A server is
                                                           always a part of a cluster.
                                                           One of the servers of a cluster assumes the role of initiating the
                                                           execution of scheduler jobs.
  [SQL ODB\<./sql-odb\>] Opera                 tional Database for storing configuration that is usually static and can take
                                                           advantage of SQL\'s relational model
  [Redis\<./redis\>] A NoS                     QL key/value DB used for highly dynamic and rapidly changing data
  [Certificate Authority (CA)\<./ca\>] An ad   ditional component, an SSL CA used during the development,
                                                           mainly with the goal of supporting
                                                           [zato quickstart \</admin/cli/quickstart-create\>] clusters
  -------------------------------------------------------- --------------------------------------------------------------------------------

Most of Zato is in Python but all the performance-critical parts are in Cython, C or C++,
including the underlying asynchronous HTTP server which is written on top of [gunicorn](http://gunicorn.org).
It\'s a modern server which lets one handle large numbers of incoming connections.
