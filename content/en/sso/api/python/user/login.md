---
title: User.login - Python API
---

Logs a user into the system. On success, returns session info, including a UST (user session token) that represents
a particular session of that user with the SSO environment.

On invalid input raises zato.sso.api.ValidationError which contains details in the form of
[status and sub-status codes \<../../../status-code\>]
pointing to specific erroneous conditions.

Note that only users whose approval_status is \"approved\" will be able to log in, otherwise an error will be raised.

API
===

self.sso.user.login
-------------------

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class Login(Service):
    def handle(self):

        username = 'regular1'
        password = '0Z-XQCZ8sK1oeP9Ft8YeQgKxUDhM34HE'
        current_app = 'CRM'
        remote_addr = '127.0.0.1'
        user_agent = 'Firefox 139.0'

        session_info = self.sso.user.login(self.cid,
            username, password, current_app, remote_addr, user_agent)

        self.logger.info('UST %s', session_info.ust)
        self.logger.info('Created %s', session_info.creation_time.isoformat())
        self.logger.info('Expires %s', session_info.expiration_time.isoformat())
```

``` {.python}
INFO - UST gAAAAABaktuYYlg00..
INFO - Created 2018-02-25T15:51:52.081767
INFO - Expires 2018-02-25T16:51:52.081767
```
