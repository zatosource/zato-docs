---
title: SessionAttr.names - Python API
---

Returns names of all attributes defined for a given session. The list is not sorted in any way.

names
=====

Usage
-----

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class SessionAttrNames(Service):
    def handle(self):

        # Current user's data
        username = 'admin1'
        password = 'abxqDJpXMVXYEO8NOGx9nVZvv4xSew9'
        current_app = 'CRM'
        remote_addr = '127.0.0.1'
        user_agent = 'Firefox 139.0'

        # Log in current user
        session = self.sso.user.login(self.cid, username, password,
            current_app, remote_addr, user_agent)

        # Get current UST
        ust = session.ust

        # Get session object
        session = self.sso.user.session.get(self.cid, ust, ust, current_app, remote_addr)

        # Prepare a list of dictionaries with attributes to create
        data = [
            {'name':'my-attr1-zxc-11', 'value':'11'},
            {'name':'my-attr2-zxc-22', 'value':'22'},
            {'name':'my-attr3-zxc-33', 'value':'33'},
        ]

        # Create new attributes
        session.attr.create_many(data)

        # Get names of all attributes for that session
        result = session.attr.names()

        self.logger.info('Result -> %s', result)
```

``` {.bash}
INFO - Result -> ['my-attr1-zxc-11', 'my-attr2-zxc-22', 'my-attr3-zxc-33']
```
