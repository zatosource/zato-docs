---
title: zato check-config
---

Overview
========

Performs sanity checks against a Zato component. Currently limited to servers only.

The command checks whether:

-   SQL ODB connection is configured properly
-   Redis connection is configured properly

Subcommands
===========

-   (None)

Command-specific parameters
===========================

  Name   Description                Example value
  ------ -------------------------- -------------------
  path   Path to a Zato component   \~/zato1/server1/

Usage
=====

    $ zato check-config [-h] [--store-log] [--verbose] [--store-config]
        path

    $ zato check-config ~/zato1/server1/
    SQL ODB connection OK
    Redis connection OK
    $

Changelog
=========

  Version   Notes
  --------- -----------------
  1.0       Added initially
