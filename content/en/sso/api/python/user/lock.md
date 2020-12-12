---
title: User.lock - Python API
---

Locks a user account. Current user must be a super-user.

Use [User.unlock \<./unlock\>] to unlock an already locked user.

API
===

self.sso.user.lock_user
-----------------------

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# stdlib
from random import randint

# Zato
from zato.server.service import Service

class LockUser(Service):
    def handle(self):

        # Request metadata
        current_ust = 'gAAAAABalo6MX7z62Pyo416OFfDJ-4MuTMmSpIqAmvOXWc..'
        current_app = 'CRM'
        remote_addr = '127.0.0.1'

        # User to lock
        user_id = 'zusr6htgg7hhdj8zrvvatbyfawxfsw'

        # Lock the user
        self.sso.user.lock_user(self.cid, user_id, current_ust, current_app, remote_addr)
```
