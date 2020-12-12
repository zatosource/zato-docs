---
title: zato encrypt
---

Overview
========

Encrypts secrets using a Zato component\'s secret key. The secret can then be
used in Zato config files. For instance, a server\'s main config file will have
the database password encrypted in such a fashion.

Subcommands
===========

-   (None)

Command-specific parameters
===========================

+-----------+----------------------------+
| Name      | Description                |
+===========+============================+
| \--secret | > A secret to be encrypted |
+-----------+----------------------------+
| path      | > Path to a Zato component |
+-----------+----------------------------+

Usage
=====

    $ zato encrypt [-h] [--store-log] [--verbose] [--store-config]
        [--secret SECRET] path

    $ zato encrypt --secret 123 ~/env/server1
    Encrypted value: `gAAAAABdKH_3qNJynvNI_hvFSvNe24P5kigbRk924yDxkFLZQ1weu_5pwSoZGwzQ==`
    $

Changelog
=========

  Version   Notes
  --------- --------------------------------------------------------------------
  3.1       The path parameter needs to point to a component\'s main directory
            rather than to its private key because keys are optional
            starting in Zato 3.1
  1.0       Added initially
