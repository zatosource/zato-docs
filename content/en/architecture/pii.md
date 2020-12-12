---
title: PII - GDPR, HIPAA, PDPA and other regulations
---

Security is of paramount importance to [Zato Source](https://zato.io/) and Zato is a product with security designed
in. In all phases of development or maintenance, at each step, a great deal of effort goes into making sure that Zato
is secure by default.

This document presents an overview of security mechanisms that can be used by technical architects to design
environments expected to protect Personally Identifiable Information (PII) in accordance with regulations such
as
[GDPR](https://en.wikipedia.org/wiki/GDPR),
[HIPAA](https://en.wikipedia.org/wiki/HIPAA)
or
[PDPA](https://www.pdpc.gov.sg/).

The contents is provided for informational purposes and it is not legal advice. Readers are advised to contact
qualified personnel to discuss PII requirements in their projects.

Secure by design
================

-   Security is an ingrained part of the product, it is not an afterthought; instead, each and every part of
    the architecture takes strong security into account from a given part\'s very inception, through development up to ongoing
    maintenance

Access permissions
==================

-   User-defined services can be secured with a range mechanisms ([API keys \<../web-admin/security/apikey\>],
    [AWS \<../web-admin/security/aws\>],
    [Basic Auth \<../web-admin/security/basic-auth\>],
    [JWT \<../web-admin/security/jwt\>],
    [NTLM \<../web-admin/security/ntlm\>],
    [OAuth \<../web-admin/security/oauth\>],
    [SSL/TLS \<../web-admin/security/tls/overview\>],
    [Vault \<../web-admin/security/vault\>],
    [WS-Sec \<../web-admin/security/ws-security\>]
    and
    [XPath \<../web-admin/security/xpath\>])
-   Permissions to services can be grouped into
    [RBAC \<../web-admin/security/rbac/overview\>] hierarchies (Role-based access control)
-   There are no default credentials - all secrets are always dynamically generated and set to very strong ones (UUID4 or stronger)

Data in transit
===============

-   Data in transit can be encrypted with TLS, including ability to require client certificates and certificate pinning

Data at rest
============

-   All secrets (e.g. connection passwords) are kept in an encrypted form
-   Keys needed for decryption of secrets can be read from safe storage such as Amazon CloudHSM
-   Arbitrary PII can be transparently stored in an encrypted form in databases and decrypted on the fly without
    a need for user programming

SSO and user management
=======================

-   Ships with a built-in [API \<../sso/index\>] for building Single Sign-On environments
-   Includes user management calls and workflows
-   Users can be described by arbitrary attributes, each possibly transparently encrypted and decrypted when needed
-   All access to PII is always reflected in an audit log, including information who carried out a given operation

Strong cryptography
===================

-   Zato includes safe and strong means for cryptograhical operations:
    [encryption, decryption \<../progguide/crypto/encrypt\>] and
    [hashing of secrets \<../progguide/crypto/hash\>]

Log processing
==============

-   Logs can be stored in files or remote processing facilities (e.g.
    [NewRelic](https://newrelic.com/), [Sentry](https://sentry.io/welcome/))
-   Data masking - to minimize the risk of attackers gaining access to PII, the secret parts of connection parameters
    are not stored in log files (e.g. instead of passwords a placeholder \*\*\*\*\*\* is stored)

Clustering
==========

-   To ensure business continuity, Zato servers are always part of a cluster and there are no limits to how many servers
    a cluster may hold

API testing
===========

-   Comes with built-in tools for [API testing \<../test/apitest/index\>] that allow for periodical assesments
    of API security measures
