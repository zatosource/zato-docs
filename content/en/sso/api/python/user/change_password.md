---
title: User.change_password - Python API
---

Changes a user\'s password. Regular users may only change their own passwords and super-users may change any other person\'s
password. No matter who is changing the password, the new one must confirm to the [configuration \<../../../config/index\>].

Super-users may also set password expiry and a flag indicating that the referenced user change his or her password the next
time this person logs in.

API
===

self.sso.user.change_password
-----------------------------

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class ChangePasswordCurrentUser(Service):

    def handle(self):

        # Data obtained from request and/or WSGI environment
        ust = 'gAAAAABalFycY50Budi...'
        current_app = 'CRM'
        remote_addr = '127.0.0.1'

        # Since this is a password change for current user,
        # both old and new password are needed on input
        data = {
            'old_password': 'mCryhVlCePjuyCkV1blieB2gJIIZNiO3',
            'new_password': 'Q9mr70M8hKshqbCK6uLArAFVCdqcTdEh',
        }

        # Change the password now, no exception = success
        self.sso.user.change_password(self.cid, data, current_ust, current_app, remote_addr)
```

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class ChangePasswordAnotherUser(Service):

    def handle(self):

        # Data obtained from request and/or WSGI environment
        ust = 'gAAAAABalFycY50Budi...'
        current_app = 'CRM'
        remote_addr = '127.0.0.1'

        # This time around, a super-user changes another person's password
        # so the old password is not needed. On top of it, the other user
        # will need to change the password the next time he or she logs in.
        data = {
            'user_id':      'zusr6pxpqqg4j09t5vhw1ehtmebshy',
            'new_password': '5c5Apw67534s55ukRkEZSVyH3DKr2ajN',
            'must_change':   True,
        }

        # Change the password now, no exception = success
        self.sso.user.change_password(self.cid, data, current_ust, current_app, remote_addr)
```
