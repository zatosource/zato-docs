---
title: Session.get - Python API
---

Returns details of a user session from target_ust, provided that the session exists, has not expired,
and that its user\'s password has not expired. Only super-users are allowed to invoke this API.

API
===

self.sso.user.session.get
-------------------------

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class GetSession(Service):
    def handle(self):

      username = 'admin1'
      password = 'abxqDJpXMVXYEO8NOGx9nVZvv4xSew9-'
      current_app = 'CRM'
      remote_addr = '127.0.0.1'
      user_agent = 'Firefox 139.0'

      # Log current user
      session = self.sso.user.login(username, password, current_app, remote_addr, user_agent)

      # Get UST
      ust = session.ust

      # Get current user's session
      session = self.sso.user.session.get(self.cid, ust, ust, current_app, remote_addr)

      # Log result
      for key, value in sorted(session.to_dict().items()):
          self.logger.info('%s %s', key.ljust(15), value)
```

``` {.python}
INFO - creation_time   2018-03-14 16:27:55
INFO - expiration_time 2018-03-14 17:27:55
INFO - remote_addr     127.0.0.1
INFO - user_agent      Firefox 139.0
```
