---
title: User.confirm_signup - Python API
---

Lets users confirm their intent to sign up with the SSO system. On input, a [confirmation token \<./signup\>]
must be sent. There is no response if the call succeeds, otherwise an SSOException may be raised.

API
===

self.sso.user.confirm_signup
----------------------------

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class ConfirmSignup(Service):
    def handle(self):

        # Read in from request
        confirm_token = 'MpPAHsQAc6_x2GlddSLfNE_mlFWqoS59'

        # Confirm signup; no exception = success
        self.sso.user.confirm_signup(self.cid, confirm_token, 'CRM', '127.0.0.1')
```
