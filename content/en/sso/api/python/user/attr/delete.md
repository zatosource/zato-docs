---
title: UserAttr.delete - Python API
---

Deletes an existing user attribute or attributes. The operation cannot be undone. It is not an error to delete an attribute
that does not exist.

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

class UserAttrDelete(Service):
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

        # Get UST
        ust = session.ust

        # Get user object
        user = self.sso.user.get_user_by_id(self.cid, session.user_id, ust, current_app, remote_addr)

        # Information about the attribute to be created
        name = 'my-attribute'
        value = 'my-value'

        # Create a new attribute
        user.attr.create(name, value)

        # Delete the attribute
        user.attr.delete(name)
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

class UserAttrDeleteMany(Service):
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

        # Get UST
        ust = session.ust

        # Get user object
        user = self.sso.user.get_user_by_id(self.cid, session.user_id, ust, current_app, remote_addr)

        # Prepare a list of dictionaries with attributes to create
        data = [
            {'name':'my-attr1-zxc', 'value':''},
            {'name':'my-attr2-zxc', 'value':''},
            {'name':'my-attr3-zxc', 'value':''},
        ]

        # Create new attributes
        user.attr.create_many(data)

        # Delete all the attributes
        user.attr.delete_many(['my-attr1-zxc', 'my-attr2-zxc', 'my-attr3-zxc'])
```