---
title: UserAttr.set - Python API
---

Creates a new user attribute or updates an already existing one, optionally encrypting it before it is saved in the database.
It is also possible to set expiry for an attribute, upon reaching of which the attribute will be no longer available.

If an attribute of the input name does not exist, it will be created. If it does exist, it will be updated. This is akin
to the MERGE statement in SQL (also known as upsert).

There are two versions of the call - .set is used with a single attribute and .set_many is used with multiple attributes.
Performance-wise, it is more efficient to use .set_many if more than one attribute should be created or updated for a user.

set
===

Usage
-----

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class UserAttrSet(Service):
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

        # Information about the attribute to be set
        name = 'my-attribute'
        value = 'my-value'

        # Create a new attribute
        user.attr.set(name, value)
```

set_many
========

Usage
-----

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class UserAttrSetMany(Service):
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

        # Prepare a list of dictionaries with attributes to set
        data = [
            {'name':'my-attr1', 'value':'my-value1'},
            {'name':'my-attr2', 'value':'my-value2', 'encrypt':True},
            {'name':'my-attr3', 'value':'my-value3', 'expiration':3600},
        ]

        # Create new attributes
        user.attr.set_many(data)
```
