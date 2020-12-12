---
title: LinkedAuth.delete - Python API
---

Deletes an existing [link \<../../../../topic/user/linked-auth\>] between a security definition and an SSO user.

API
===

self.sso.user.delete_linked_auth
--------------------------------

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato

from zato.server.service import Service

class DeleteLink(Service):
    def handle(self):

        # Request metadata
        current_ust = 'gAAAAABc9YDOwa4it_lLu3tHDjdKGdjHHzLTddA_qVIxjT...'
        current_app = 'CRM'
        remote_addr = '127.0.0.1'

        # ID of the user to create a link for
        user_id = 'zusr3tm8jhgqjd9smtdt7erb427s9x'

        # Account to link to the user
        auth_type = 'basic_auth'
        auth_username = 'pubapi'

        # The link shall be active
        is_active = True

        # Create the link
        self.sso.user.delete_linked_auth(self.cid, current_ust, user_id, auth_type,
          auth_username, current_app, remote_addr)
```
