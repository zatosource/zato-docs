---
title: High-availability
---

Overview
========

Zato\'s high-availability options can be discussed on several planes, depending
on the level of granularity needed and on a need or the lack of to make a given
component redundant.

Reminding a couple of facts will make it easier to discuss the matter:

-   Each server in a cluster always carry the same set of services as the others

-   All servers are always active, there\'s no concept of an active-standby setup

-   Each cluster has a single HTTP load-balancer in front of it so the traffic
    is always distribute fairly over all servers

-   If a cluster establishes any AMQP, IBM MQ or ZeroMQ connections,
    these are always managed by connector processes - there are as many connectors
    as there are channels and outgoing connections using these 3 technologies.

    As far as AMQP and IBM MQ go, connectors are used for both channels
    and outgoing connections. With ZeroMQ, only channels use connectors and outgoing connections
    are created from Zato servers directly without connectors.

    One of the servers in the cluster assumes a role of the connector server
    and every connector process runs on the system this particular server is on.

    Connectors are never redundant, there is always one copy of a given connector
    process in a given cluster.

    When a connector receives interal request to update its configuration, it is stopped
    for a moment and doesn\'t process any business messages.

    Should the connector server ever die, another server will pick up the former\'s duties
    and the connector processes will be restarted on the system the latter is on.

Clusters without connectors
===========================

If there are no connectors and all the incoming traffic is HTTP, the frontend
load-balancer will take care of making each server gets its own fair share of requests
to handle. Each server contains the same services so if there are at least 2 servers
running in such a cluster and each one can handle the full traffic in the case the other
one should fail, it can be said that HA has been provided to a great extent.

![](/gfx/ha-no-connectors.png)

However, in such a situation, the load-balancer itself becomes a part that has
no redundant copy so it may be worth considering whether such a particular environment
shouldn\'t be composed of at least 2 identical clusters with a load-balancing mechanism
external to Zato to distribute the requests.

![](/gfx/ha-no-connectors-2-clusters.png)

Naturally, there still remains the question of how to make the external load-balancer
immune to crashes and downtimes but this is something that should be considered
on a case by case basis and is well beyond the scope of this document.

Monitoring services {#admin-ha-monitoring-services}
===================

-   The load-balancer exposes an HTTP monitoring service, on /zato-lb-alive by default,
    that can be used by external tools to check whether the component is still alive, e.g.
    by checking if HTTP response code is 200:

    ``` {.text emphasize-lines="4,10"}
    $ curl -v localhost:11223/zato-lb-alive
    * About to connect() to localhost port 11223 (#0)
    *   Trying 127.0.0.1... connected
    > GET /zato-lb-alive HTTP/1.1
    > User-Agent: curl/7.22.0 (x86_64-pc-linux-gnu) libcurl/7.22.0 OpenSSL/1.0.1
    > Host: localhost:11223
    > Accept: */*
    >
    * HTTP 1.0, assume close after body
    < HTTP/1.0 200 OK
    < Cache-Control: no-cache
    < Connection: close
    < Content-Type: text/html
    <
    <html><body><h1>200 OK</h1>
    HAProxy: service ready.
    </body></html>
    * Closing connection #0
    $
    ```

-   Each server exposes a /zato/ping service that also can be used by external
    tools to check whether the server is still alive, e.g.
    by checking if HTTP response code is 200 as well:

    ``` {.text emphasize-lines="4,9"}
    $ curl -v localhost:17010/zato/ping
    * About to connect() to localhost port 17010 (#0)
    *   Trying 127.0.0.1... connected
    > GET /zato/ping HTTP/1.1
    > User-Agent: curl/7.22.0 (x86_64-pc-linux-gnu) libcurl/7.22.0 OpenSSL/1.0.1
    > Host: localhost:17010
    > Accept: */*
    >
    < HTTP/1.1 200 OK
    < Server: gunicorn/0.16.1
    < Date: Sun, 05 May 2013 15:55:16 GMT
    < Connection: keep-alive
    < Transfer-Encoding: chunked
    < Content-Type: application/json
    < X-Zato-CID: K320539453722916924772131370942490069006
    <
    * Connection #0 to host localhooverviewst left intact
    * Closing connection #0
    {"zato_env": {"details": "", "result": "ZATO_OK", "cid":
    "K320539453722916924772131370942490069006"}, "zato_ping_response": {"pong": "zato"}}
    $
    ```

Other considerations
====================

Recall from
chapters on the architecture
that Zato makes use of
[Redis](http://redis.io) and an SQL database,
[PostgreSQL](https://www.postgresql.org/)
or
[Oracle](http://www.oracle.com/us/products/database/). These elements should also
be part of an HA plan, however how they should be
tackled is something outside the scope of this discussion.

Zato and Redis can be configured in an HA-aware fashion with sentinels, the process is documented
in [its own chapter \<./redis-ha/sentinels\>].
