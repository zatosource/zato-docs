---
title: Session.get_list - Python API
---

Consult documentation of the [corresponding REST endpoint \<../../rest/session/get-list\>] for overview.

API
===

self.sso.user.session.get_list
------------------------------

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class GetSessionList(Service):
    def handle(self):

        username = 'admin1'
        password = 'hQ9nl93UDqGus'
        current_app = 'CRM'
        remote_addr = '127.0.0.1'
        user_agent = 'Firefox 139.0'

        # Log current user
        session = self.sso.user.login(self.cid, username, password, current_app,
            remote_addr, user_agent)

        # Get UST
        ust = session.ust

        # Get current user's session
        session_list = self.sso.user.session.get_list(self.cid, ust, None, None,
            current_app, remote_addr, user_agent)

        # Log information about each of the sessions found
        for item in session_list:
            self.logger.info('Auth type / principal / remote address: %s %s %s',
                item['auth_type'], item['auth_principal'], item['remote_addr'])
```

``` {.python}
INFO - Auth type / principal / remote address: default admin1 192.168.1.242
INFO - Auth type / principal / remote address: default admin1 172.17.0.1
INFO - Auth type / principal / remote address: default admin1 10.174.183.1
```
