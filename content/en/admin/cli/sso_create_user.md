---
title: zato sso create-user
---

Overview
========

Creates a new regular user. Use [zato sso create-super-user ](./sso-create-super-user) to create new super-users.

If password is not given on input, a prompt will be shown. In either case, password will be validated against configuration
of the server pointed to by path.

In case of any errors, an error code will be returned, consult the [list of all error codes ](../../sso/status-code)
for details.

Note that only username is a required field - in particular, all name-related attributes are optional.

Subcommands
===========

-   (None)

Command-specific parameters
===========================

  Name              Description                                         Example value
  ----------------- --------------------------------------------------- ------------------------
  path              Path to a Zato server, may be running or not        /home/zato/env/server1
  username          Username of the account to create, must be unique   user1
  \--email          User\'s email                                       <user1@example.com>
  \--display-name   Name of user for presentation purposes              John Doe
  \--first-name     User\'s first name                                  John
  \--middle-name    User\'s middle name                                 Patrick
  \--last-name      User\'s last name                                   Doe
  \--password       User\'s password                                    Z.PmAc7k05G\^322d9Cy86

Usage
=====

    usage: zato sso create-user [-h] [--store-log] [--verbose] [--store-config]
                            [--email EMAIL] [--display-name DISPLAY_NAME]
                            [--first-name FIRST_NAME]
                            [--middle-name MIDDLE_NAME]
                            [--last-name LAST_NAME] [--password PASSWORD]
                            path username

    $ zato sso create-user /home/zato/env/server1 user1 --password Z.PmAc7k05G^322d9Cy86
    Created user `user1`
    $

    $ zato sso create-user /home/zato/env/server1 user1
    Password (will not echo):
    Password again (will not echo):
    Created user `user1`
    $

Changelog
=========

  Version   Notes
  --------- -----------------
  3.0       Added initially
