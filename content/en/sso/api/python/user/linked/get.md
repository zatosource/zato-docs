---
title: LinkedAuth.get - Python API
---

Returns a link of security definitions [linked \<../../../../topic/user/linked-auth\>] to the input SSO user.

Regular users may look up their own linked accounts whereas super-users may provide a user_id to return accounts for.

API
===

self.sso.user.get_linked_auth_list
----------------------------------

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato

from zato.server.service import Service

class GetLinks(Service):
    def handle(self):

        # Request metadata
        current_ust = 'gAAAAABc9lm75ETkIfF2Wi8YvRU4szBg_2LGFFg3Fs...'
        current_app = 'CRM'
        remote_addr = '127.0.0.1'

        # ID of the user to return links for
        user_id = 'zusr3tm8jhgqjd9smtdt7erb427s9x'

        # Get user's links
        response = self.sso.user.get_linked_auth_list(self.cid, current_ust,
          current_app, remote_addr, user_id)

        self.logger.info(response)
```

``` {.python}
INFO - [
 {
  'user_id': 'zusr3tm8jhgqjd9smtdt7erb427s9x',
  'auth_type': 'basic_auth',
  'auth_username': 'my.username',
  'auth_id': 2,
  'creation_time': datetime.datetime(2019, 6, 4, 11, 44, 59, 109637),
  'is_active': True,
  'is_internal': False,
  'auth_source': 'reserved',
  'auth_principal': 'reserved',
  'has_ext_principal': False
  }
]
```
