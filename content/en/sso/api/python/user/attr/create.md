---
title: UserAttr.create - Python API
---

Creates a new user attribute, optionally encrypting it before it is saved in the database. It is also possible to set expiry
for an attribute, upon reaching of which the attribute will be no longer available.

An exception is raised if an attribute of a given name already exists - use [set \<./set\>] if an
update should be issued instead of reporting an exception.

Unlike [session attributes \<../../../../topic/attr/index\>], user attributes persist across multiple sessions, multiple logins,
of the person they belong to.

Attribute names and other metadata may be stored in server logs. Values are never saved to logs.

There are two versions of the call - .create is used with a single attribute and .create_many is used with multiple attributes.
Performance-wise, it is more efficient to use .create_many if more than one attribute should be created for a user.

create
======

Usage
-----

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class UserAttrCreate(Service):
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
```

create_many
===========

Usage
-----

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class UserAttrCreateMany(Service):
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
            {'name':'my-attr1', 'value':'my-value1'},
            {'name':'my-attr2', 'value':'my-value2', 'encrypt':True},
            {'name':'my-attr3', 'value':'my-value3', 'expiration':3600},
        ]

        # Create new attributes
        user.attr.create_many(data)
```