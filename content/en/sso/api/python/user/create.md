---
title: User.create - Python API
---

Creates a new regular user. Current user\'s UST must belong to a super-user.

API
===

self.sso.user.create_user
-------------------------

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato

from zato.server.service import Service

class CreateUser(Service):
    def handle(self):

        # Request metadata
        current_ust = 'gAAAAABalo6MX7z62Pyo416OFfDJ-4MuTMmSpIqAmvOXWckG...'
        current_app = 'CRM'
        remote_addr = '127.0.0.1'

        # Creation data
        data = {
          'username': 'user1',
          'password': 'Zp=VZMdZ2-!S6EJ5~sh5cfMiZ7--,aD3Nbya ^8j',
          'password_must_change': True,
          'display_name': 'My User'
        }

        # Create user
        self.sso.user.create_user(self.cid, data, current_ust, current_app, remote_addr)

        # The input dictionary will have been updated in place
        self.logger.info(data)
```

``` {.python}
INFO {
  'display_name': 'My User',
  'is_active': True,
  'is_internal': False,
  'is_super_user': True,
  'is_approval_needed': True,
  'approval_status': 'before_decision',
  'approval_status_mod_by': 'zusr3qnafn39208krbt0vt2nypx2ta',
  'approval_status_mod_time': datetime.datetime(2020, 2, 28, 11, 33, 13, 359733),
  'is_locked': False,
  'password_expiry': datetime.datetime(2020, 2, 28, 11, 33, 13, 359733),
  'password_must_change': True,
  'password_last_set': datetime.datetime(2018, 2, 28, 11, 33, 13, 359733),
  'sign_up_time': datetime.datetime(2018, 2, 28, 11, 33, 13, 359733),
  'sign_up_status': 'final',
  'username': 'user1',
  'user_id': 'zusr1e2xwnk9p89ty8y0skcpy795c9'
}
```
