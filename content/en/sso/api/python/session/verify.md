---
title: Session.verify - Python API
---

Verifies that a session pointed to by a UST from target_ust exists and has not expired.
Only super-users are allowed to invoke this API.

The call never fails and if any exception is encountered, it is logged and False is returned on output.

API
===

self.sso.user.session.verify
----------------------------

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class VerifySession(Service):
    def handle(self):

        # Current user's data
        username = 'admin1'
        password = 'abxqDJpXMVXYEO8NOGx9nVZvv4xSew9-'
        current_app = 'CRM'
        remote_addr = '127.0.0.1'
        user_agent = 'Firefox 139.0'

        # Log in current user
        session = self.sso.user.login(username, password, current_app, remote_addr, user_agent)

        # Get current UST
        ust = session.ust

        # Another UST to check
        target_ust = 'gAAAAABaqSjEHUpNOhz9EO2GB_tYTjhG...'

        # Check if target UST exists
        exists = self.sso.user.session.verify(self.cid, target_ust, ust, current_app, remote_addr)

        # Log result
        self.logger.info('Exists: %s', exists)
```

``` {.python}
INFO - Exists: False
```
