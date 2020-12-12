---
title: zato sso unlock-user
---

Overview
========

Unlocks a user account, thus allowing a user to log into it.

Note that the command does not check if the account was previously [locked ](./sso-lock-user) or not,
i.e. it is not an error to run it with a user that is not currently locked.

Subcommands
===========

-   (None)

Command-specific parameters
===========================

  Name       Description                                    Example value
  ---------- ---------------------------------------------- ------------------------
  path       Path to a Zato server, may be running or not   /home/zato/env/server1
  username   Username of the account to unlock              user1

Usage
=====

    $ zato sso unlock-user [-h] [--store-log] [--verbose] [--store-config]
                           path username

    $ zato sso lock-user /home/zato/env/server1 regular1
    Unlocked user account `user1`
    $

Changelog
=========

  Version   Notes
  --------- -----------------
  3.0       Added initially
