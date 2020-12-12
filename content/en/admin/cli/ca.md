---
title: zato ca
---

Overview
========

Manages a basic Certificate Authority (CA). Note that this is mostly used
to support the [zato quickstart\<./quickstart\>] command; it\'s not a full-blown CA and
there are no plans to make it a substitute for projects that actually provide
full CA environments.

Think of the Zato\'s CA as an aid in the development phase only. While technically possible,
it shouldn\'t really be used during tests and in production.

The CA works by running the [openssl](https://openssl.org/) command
in subprocesses against a configuration directory.

Subcommands
===========

-   [zato ca create ca\<./ca-create-ca\>]
-   [zato ca create lb_agent\<./ca-create-lb-agent\>]
-   [zato ca create server\<./ca-create-server\>]
-   [zato ca create web_admin\<./ca-create-web-admin\>]
