---
title: User.delete - Python API
---

Deletes a user by ID - may be a regular one or super-super. Current user must be a super-user.
It is not possible to delete one\'s own account - another super-user must do it.

API
===

self.sso.user.delete_user_by_id
-------------------------------

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# stdlib
from random import randint

# Zato
from zato.server.service import Service

class DeleteUser(Service):
    def handle(self):

        # Request metadata
        current_ust = 'gAAAAABalo6MX7z62Pyo416OFfDJ-4MuTMmSpIqAmvOXWc..'
        current_app = 'CRM'
        remote_addr = '127.0.0.1'

        # User to delete
        user_id = 'zusr4datdm5k5m8fbb8fttx5d65avm'

        # Delete the user
        self.sso.user.delete_user_by_id(self.cid, user_id, current_ust, current_app, remote_addr)
```
