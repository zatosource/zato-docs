---
title: zato sso reset-user-password
---

Overview
========

Changes a user\'s password to an automatically generated one which is printed to stdout. Use
[zato sso change-user-password \<./sso-change-user-password\>] if you would like to control what password
will be set for user.

The auto-generated password is 192-bit strong. Data comes from a cryprographic source using Python\'s
[os.urandom](https://docs.python.org/2/library/os.html#os.urandom).

The password is printed to stdout once only and it is not possible to retrieve it afterwards.

The user must already exist. Optionally, sets a non-default expiry for password or a flag to force the user to change
the password on next login.

The absence of \--must-change means that its existing value will not be changed - for instance, if the flag is
already true in the database and it was not given on input, it will continue to be true.

Subcommands
===========

-   (None)

Command-specific parameters
===========================

+----------------+-------------------------+------------------------+
| Name           | Description             | Example value          |
+================+=========================+========================+
| path           | Path to a Zato server,  | /home/zato/env/server1 |
|                | may be running or not   |                        |
+----------------+-------------------------+------------------------+
| username       | Username of the account | user1                  |
| \--expiry      | to reset the password   |                        |
|                | of                      | 2                      |
|                | Password expiry in      |                        |
|                | days,                   |                        |
|                | if not given and if not |                        |
|                | overridden in server\'s |                        |
|                | configuration,          |                        |
|                | the default value of    |                        |
|                | 760 days will be used   |                        |
|                | (2 years)               |                        |
+----------------+-------------------------+------------------------+
| \--must-change | Whether the user must   | true                   |
|                | change the password on  |                        |
|                | next login.             |                        |
+----------------+-------------------------+------------------------+

Usage
=====

    $ zato sso reset-user-password [-h] [--store-log] [--verbose]
                                    [--store-config] [--expiry EXPIRY]
                                    [--must-change MUST_CHANGE]
                                    path username

    $ zato sso reset-user-password ~/env/qs-ps2/server1/ user1
    Password for user `user1` reset to `WKOB1JnrqkNpZKe8OVGuXC6WfgN8Kxv3`
    $

Changelog
=========

  Version   Notes
  --------- -----------------
  3.0       Added initially
