---
title: User.reset_totp_key - Python API
---

Changes a user\'s TOTP key and its accompanying label. If key is not given on input, one is generated and returned on output.

Regular users may change their own keys only. Super-users may change any other user\'s keys.

API
===

self.sso.user.reset_totp_key
----------------------------

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class ResetUserTOTPKey(Service):

    def handle(self):

        # Data obtained from request and/or WSGI environment
        ust = 'gAAAAABalFycY50Budi...'
        current_app = 'CRM'
        remote_addr = '127.0.0.1'

        # We are changing another user's key
        user_id = 'zusrpdjpsqjqa8jdv533zh0pv8tcm'

        # No key to be provided on input = Zato will generate one
        key = None

        # A label is provided though
        key_label = 'My SSO key'

        # Change the key and label now
        totp_key = self.sso.user.reset_totp_key(self.cid, ust,
           user_id, key, key_label, current_app, remote_addr)
        self.logger.info('New key: %s', totp_key)
```
