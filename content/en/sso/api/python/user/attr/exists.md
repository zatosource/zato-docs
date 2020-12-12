---
title: UserAttr.exists - Python API
---

Returns True if a given attribute exists or False otherwise.

There are two versions of the call - .exists is used with a single attribute and .exists_many (rather than .exist) is used
with multiple attributes. Performance-wise, it is more efficient to use .exists_many if more than one attribute should be checked.

exists
======

Usage
-----

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class UserAttrExists(Service):
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

        # Check if the attribute exists
        exists = user.attr.exists(name)

        self.logger.info('Exists -> %s', exists)
```

``` {.bash}
INFO - True
```

exists_many
===========

Usage
-----

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class UserAttrExistsMany(Service):
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
            {'name':'my-attr1-zxc-11', 'value':'11'},
            {'name':'my-attr2-zxc-22', 'value':'22'},
            {'name':'my-attr3-zxc-33', 'value':'33'},
        ]

        # Create new attributes
        user.attr.create_many(data)

        # Check if all the attributes just created actually exist
        result = user.attr.exists_many(['my-attr1-zxc-11', 'my-attr2-zxc-22', 'my-attr3-zxc-33'])

        self.logger.info('Result -> %s', result)
```

``` {.bash}
INFO - Result -> {u'my-attr2-zxc-22': True, u'my-attr3-zxc-33': True, u'my-attr1-zxc-11': True}
```
