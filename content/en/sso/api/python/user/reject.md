---
title: User.reject - Python API
---

Changes a user\'s approval_status to \'rejected\'. A rejected user may not log in until he or she is [approved \<./approve\>].
It is not an error to reject an already rejected user.

Only super-users may [approve \<./approve\>] or reject other users.

API
===

self.sso.user.reject_user
-------------------------

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class RejectUser(Service):
    def handle(self):

        # Request metadata
        current_ust = 'gAAAAABanYYUAaBcsIn6OKhpW9ia6CdflCG7AE_m7...'
        current_app = 'CRM'
        remote_addr = '127.0.0.1'

        # User to approve
        user_id = 'zusrzw764rvcr84vtcb3ctyha5cbe'

        self.sso.user.approve_user(self.cid, data, current_ust, current_app, remote_addr)
```
