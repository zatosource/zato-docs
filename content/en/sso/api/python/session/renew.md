---
title: Session.renew - Python API
---

Renews current session, returning its new expiration time on output (in UTC).

Note that the call will raise an exception if:

-   The session has already expired
-   The underlying user\'s password has already expired

API
===

self.sso.user.session.renew
---------------------------

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class RenewSession(Service):
    def handle(self):

        username = 'admin1'
        password = 'abxqDJpXMVXYEO8NOGx9nVZvv4xSew9-'
        current_app = 'CRM'
        remote_addr = '127.0.0.1'
        user_agent = 'Firefox 139.0'

        # Log current user
        session = self.sso.user.login(username, password, current_app, remote_addr, user_agent)

        # Renew the session
        expiration = self.sso.user.session.renew(self.cid, session.ust, current_app, remote_addr)

        # Log result (in UTC)
        self.logger.info('Expiration: %s, %s', expiration, type(expiration))
```

``` {.python}
INFO - Expiration: 2018-03-14 15:24:39.361223, <type 'datetime.datetime'>
```
