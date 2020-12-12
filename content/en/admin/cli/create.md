---
title: zato create
---

Overview
========

Creates a Zato object, such as a server or user.

Load balancers, servers and web-admin instances are components created as a set of files and directories.
For each such component, a marker file, .zato-info, is created and contains a JSON
document describing some basic metadata regarding the given component.

Sample .zato-info:

    {
     "created_user_host": "admin1@prod17",
     "version": "1.1",
     "component": "SERVER",
     "created_ts": "2013-06-13T22:32:23.697300"
     }

  Key                 Description
  ------------------- --------------------------------------------------------------
  created_user_host   Username/hostname pair pointing to who created the component
                      and what system it was on
  version             Zato version the component was created with
  component           One of: CA, LOAD_BALANCER, SERVER or WEB_ADMIN.
                      CA is a Certificate Authority created by
                      [quickstart clusters ](./quickstart-create).
  created_ts          When the component was created, in UTC

Subcommands
===========

-   [zato create cluster](./create-cluster)
-   [zato create load_balancer](./create-load-balancer)
-   [zato create odb](./create-odb)
-   [zato create server](./create-server)
-   [zato create user](./create-user)
-   [zato create web_admin](./create-web-admin)
