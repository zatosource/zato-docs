---
title: SSL/TLS traffic from a load-balancer to servers
---

Key features:

-   A cluster\'s HAProxy-based load-balancer can connect to servers using an encrypted SSL/TLS link
-   Servers can be configured to require a client certificate from the load-balancer
-   Connections from the load-balancer to servers can be encrypted even if connections from client applications to the load-balancer
    are not

![image](/gfx/admin/tls/path-lb-servers.png)

Tasks
=====

-   Configuring a load-balancer and servers to use [use SSL/TLS without client certificates ](admin-tls-lb-no-certs)
-   Configuring a load-balancer and servers to use [use SSL/TLS with client certificates ](admin-tls-lb-certs)

SSL/TLS from a load-balancer to servers - no client certificates {#admin-tls-lb-no-certs}
================================================================

-   For each server in a cluster:

    -   Open [server.conf ](../install-config/config-server) and set *crypto.use_tls* to True, so it reads:

        ``` {.ini}
        [crypto]
        use_tls=True
        ```

    -   Restart the server

-   Open the load-balancer\'s configuration in [source code view ](../../../web-admin/load-balancer/source-code)

-   Find lines referring to servers - contained within the *ZATO begin backend bck_http_plain* block, such as below.
    Note that the example shown splits a long line into several ones but the line must be kept long without newlines:

    ```
    server http_plain--server1 127.0.0.1:17010 \
      check inter 2s rise 2 fall 2 \
      # ZATO backend bck_http_plain:server--server1
    ```

-   Add TLS-related configuration, including a path to CA certificates in *ca-file* which points to CA(s) the
    server certificates are signed off by, using the example below as a template. Again, all pieces should be placed
    on one line which has been broken out into multiple ones for clarity:

    ``` {.text emphasize-lines="3,4"}
    server http_plain--server1 127.0.0.1:17010 \
      check inter 2s rise 2 fall 2 \
      ssl verify required \
      ca-file /path/to/ca.cert.pem  \
      # ZATO backend bck_http_plain:server--server1
    ```

-   Validate and save the load-balancer\'s configuration

SSL/TLS from a load-balancer to servers - with client certificates {#admin-tls-lb-certs}
==================================================================

-   For each server in a cluster:

    -   Open [server.conf ](../install-config/config-server) and set:

        -   *crypto.use_tls* to True:
        -   *crypto.tls_client_certs* to required

        ``` {.ini}
        [crypto]
        use_tls=True
        tls_client_certs=required
        ```

    -   Restart the server

-   Open the load-balancer\'s configuration in [source code view ](../../../web-admin/load-balancer/source-code)

-   Find lines referring to servers - contained within the *ZATO begin backend bck_http_plain* block, such as below.
    Note that the example shown splits a long line into several ones but the line must be kept long without newlines:

    ```
    server http_plain--server1 127.0.0.1:17010 \
      check inter 2s rise 2 fall 2 \
      # ZATO backend bck_http_plain:server--server1
    ```

-   Add TLS-related configuration, including a path to CA certificates in *ca-file* which points to CA(s) the
    server certificates are signed off by, and *crt* containing the load-balancer\'s private key and certificate,
    using the example below as a template. Again, all pieces should be placed
    on one line which has been broken out into multiple ones for clarity:

    ``` {.text emphasize-lines="3,4,5"}
    server http_plain--server1 127.0.0.1:17010 \
      check inter 2s rise 2 fall 2 \
      ssl verify required \
      ca-file /path/to/ca.cert.pem  \
      crt /path/to/key-cert.pem  \
      # ZATO backend bck_http_plain:server--server1
    ```

-   Validate and save the load-balancer\'s configuration
