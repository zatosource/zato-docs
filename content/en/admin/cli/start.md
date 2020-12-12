---
title: zato start
---

Overview
========

Starts a Zato component.

If the component is a server and it\'s the first time it\'s started,
a Zato administrator will have to make the server known to the load-balancer before
the server will be able to accept HTTP connections.

A server that is the first one in a cluster to have been started will automatically
start scheduler and outgoing connectors, if any have been configured for the cluster.

If the component is a scheduler, it must be started only after at least one of servers in the cluster is already running.

Subcommands
===========

-   (None)

Command-specific parameters
===========================

  Name      Description                         Example value
  ------ -- ----------------------------------- -------------------
  path      Path to a Zato component to start   \~/dev3/web-admin

Usage
=====

    $ zato start [-h] [--store-log] [--verbose] [--store-config] path

    $ zato start ~/dev3/web-admin
    OK
    $

Changelog
=========

  Version   Notes
  --------- -----------------
  1.0       Added initially