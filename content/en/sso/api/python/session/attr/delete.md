---
title: SessionAttr.delete - Python API
---

Deletes an existing session attribute. The operation cannot be undone.

There are two versions of the call - .delete is used with a single attribute and .delete_many is used with multiple attributes.
Performance-wise, it is more efficient to use .delete_many if more than one attribute should be deleted.

delete
======

Usage
-----

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class SessionAttrDelete(Service):
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

        # Information about the attribute to be created
        name = 'my-attribute'
        value = 'my-value'

        # Create a new attribute
        session.attr.create(name, value)

        # Delete the attribute
        session.attr.delete(name)
```

delete_many
===========

Usage
-----

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class SessionAttrDeleteMany(Service):
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
            {'name':'my-attr1-zxc', 'value':''},
            {'name':'my-attr2-zxc', 'value':''},
            {'name':'my-attr3-zxc', 'value':''},
        ]

        # Create new attributes
        session.attr.create_many(data)

        # Delete all the attributes
        session.attr.delete_many(['my-attr1-zxc', 'my-attr2-zxc', 'my-attr3-zxc'])
```
