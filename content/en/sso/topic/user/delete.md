---
title: Deleting users
---

A logged in super-user can delete other users using
[REST \<../../api/rest/user/delete\>],
[Python \<../../api/python/user/delete\>]
or from
[command line \<../../../admin/cli/sso-delete-user\>]. Regular users cannot delete any kind of users.

It is not possible even for super-users to delete their own accounts, i.e. super-users need to be deleted
either by other super-users or using a CLI command.

Deletion is irrevocable - there is no undo and all data about the user, related session or attributes is deleted.
