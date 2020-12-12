---
title: UserAttr.update - Python API
---

Updates an already existing attribute, optionally encrypting it before it is saved in the database. It is also possible to set expiry
for an attribute, upon reaching of which the attribute will be no longer available.

An exception is raised if an attribute of a given name does not already exists - use [set \<./set\>] if an
attribute should be created in such a case instead of raising an exception.

There are two versions of the call - .update is used with a single attribute and .update_many is used with multiple attributes.
Performance-wise, it is more efficient to use .update_many if more than one attribute should be updated for a user.

update
======

Usage
-----

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class UserAttrUpdate(Service):
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

        # Information about the attribute to be created and then updated
        name = 'my-attribute-abc'
        value1 = 'my-value1'
        value2 = 'my-value2'

        # Create a new attribute
        user.attr.create(name, value1)

        # Update the newly created attribute
        user.attr.update(name, value2)
```

update_many
===========

Usage
-----

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class UserAttrUpdateMany(Service):
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

        # Now, prepare new values for the attributes
        data = [
            {'name':'my-attr1', 'value':'my-value1-abc'},
            {'name':'my-attr2', 'value':'my-value2-abc'},
            {'name':'my-attr3', 'value':'my-value3-abc'},
        ]

        # Update all of them
        user.attr.update_many(data)
```