---
title: User.logout - Python API
---

Logs a user out of an existing SSO session - this makes the user no longer logged into any of the SSO-based applications.

There is no response on success. A ValidationError is raised if input is invalid, for instance, if UST does not exist.

API
===

self.sso.user.logout
--------------------

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class Logout(Service):
    def handle(self):

      ust = 'gAAAAABak9qaHvm9RCGc6WWpvjl9cT...'
      current_app = 'CRM'
      remote_addr = '127.0.0.1'

      self.sso.user.logout(self.cid, ust, current_app, remote_addr)
```
