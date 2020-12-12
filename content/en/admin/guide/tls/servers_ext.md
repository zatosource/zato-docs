---
title: SSL/TLS traffic to external applications
---

Key features:

-   Services can invoke SSL/TLS-protected HTTP resources, including authentication using client certificates
-   Target server certificates can be validated or ignored
-   Everything can be configured on-fly without restarts nor coding

![image](/gfx/admin/tls/path-servers-ext.png)

Tasks
=====

-   [Uploading and updating client certificates \<admin-tls-upload-client-certs\>] for services to use when connecting to external HTTP resources
-   [Uploading CA certificates \<admin-tls-upload-ca-certs\>] used for validation of external applications\' certificates

Uploading and updating client certificates {#admin-tls-upload-client-certs}
==========================================

-   Use [a dedicated form \<../../../web-admin/security/tls/keys-certs\>] to upload concatenated pairs of PEM certificate
    and private key for services to use through outgoing connections
    ([Plain HTTP \<../../../web-admin/outgoing/plain-http\>] or [SOAP \<../../../web-admin/outgoing/soap\>]).
    The material cannot be secured with a password.
-   No restarts are needed after updating an already existing pair with a new one.

Uploading and updating CA certificates {#admin-tls-upload-ca-certs}
======================================

-   Use [a dedicated form \<../../../web-admin/security/tls/ca-certs\>] to upload bundles of certificates, in PEM,
    to use for validating server certificates services will access through outgoing connections. A bundle may consist of one
    or more CA certificates, including any intermediate ones.
-   No restarts are needed after updating an already existing bundle of certificates.
