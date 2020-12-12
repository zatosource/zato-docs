---
title: User.approve - Python API
---

Changes a user\'s approval_status to \'approved\', thus making it possible for that user to log in, provided that other conditions
are fulfilled, e.g. user connects from an allowed IP address. It is not an error to approve an already approved user.

Only super-users may approve or [reject \<./reject\>] other users.

API
===

self.sso.user.approve_user
--------------------------

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class ApproveUser(Service):
    def handle(self):

        # Request metadata
        current_ust = 'gAAAAABanYUOu2NAMqTVXihxl3gLsdYcbkIJI72WZIIX...'
        current_app = 'CRM'
        remote_addr = '127.0.0.1'

        # User to approve
        user_id = 'zusr17k3x6wgp4839t30d9knrpvsah'

        self.sso.user.approve_user(self.cid, data, current_ust, current_app, remote_addr)
```
