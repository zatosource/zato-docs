---
title: User.get - Python API
---

Both regular and super-users can access information about their own accounts using self.sso.user.get_current_user,
which accepts current session\'s UST on input. Further, super-users may query for other users by the latter\'s ID
with self.sso.user.get_user_by_id.

On out, a zato.sso.User object is returned which describes a given user with a range of attributes.
Further, the object\'s .to_dict() method will serialize all the data to a Python dictionary.

Passwords are never returned regardless of user type.

API
===

self.sso.user.get_current_user
------------------------------

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class GetCurrentUser(Service):

    def handle(self):

        # Data obtained from request and/or WSGI environment
        ust = 'gAAAAABalFycY50Budi...'
        current_app = 'CRM'
        remote_addr = '127.0.0.1'

        # Get user by UST
        user_info = self.sso.user.get_current_user(self.cid, ust, current_app, remote_addr)

        # Log output for confirmation
        self.logger.info(user_info.to_dict())
```

``` {.python}
INFO - {
  'user_id': 'zusrx2efj1q1h98n9q00tgx8scefv',
  'username': 'regular1',
  'display_name': 'John Doe',
  'email': 'hello@example.com'
  }
```

self.sso.user.get_user_by_id
----------------------------
