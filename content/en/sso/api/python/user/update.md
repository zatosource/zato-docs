---
title: User.update - Python API
---

Both regular and super-users can update information about their own accounts using self.sso.user.update_current_user,
which accepts current session\'s UST on input.

Further, super-users may update other users by their ID with self.sso.user.update_user_by_id.

When sending input \'data\' dictionary, there is a distinction between sending a key with a value of None and not sending it altogether.
If None is sent, a given attribute will be set to NULL on SQL level whereas not sending a particular key will not update it at all
and any current value will be left as it is.

Passwords can be changed using [a separate call \<./change-password\>].

API
===

self.sso.user.update_current_user
---------------------------------

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class UpdateCurrentUser(Service):
    def handle(self):

        # Request metadata
        current_ust = 'gAAAAABamSuDF8-TOEjl43GxoMSS86RD_cquqEr...'
        current_app = 'CRM'
        remote_addr = '127.0.0.1'

        # New data to update the user with
        data = {
            'display_name': 'New Display Name',
            'email': 'myuser@example.com'
        }

        self.sso.user.update_current_user(self.cid, data, current_ust, current_app, remote_addr)
```

self.sso.user.update_user_by_id
-------------------------------

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# stdlib
from datetime import datetime, timedelta

# Zato
from zato.server.service import Service

class UpdateUserByID(Service):
    def handle(self):

        # Request metadata
        current_ust = 'gAAAAABamSuDF8-TOEjl43GxoMSS86RD_cquqEr...'
        current_app = 'CRM'
        remote_addr = '127.0.0.1'

        # User to change
        user_id = 'zusr4q51jwtsdh9s298315h4at6t1n'

        # New data to update the user with
        data = {
            'display_name': 'My Display Name',
            'is_locked': False,
            'password_expiry': datetime.utcnow() + timedelta(days=90)
        }

        self.sso.user.update_user_by_id(self.cid, user_id, data, current_ust, current_app, remote_addr)
```
