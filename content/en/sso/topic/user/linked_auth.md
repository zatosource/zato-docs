---
title: Linked accounts
---

A single SSO user may be linked to one or more
[Basic Auth \<../../../web-admin/security/basic-auth\>]
or
[JWT \<../../../web-admin/security/jwt\>]
accounts.

Logging in with one of the linked accounts opens a new SSO session associated with the SSO user the credentials
used for logging in are associated with.

For instance, if user \'Joan Doe\' has a linked Basic Auth account \'joan.doe\' and that account is used for logging
in to a system, a new SSO session will be opened for \'Joan Doe\' in addition to any other existing session
already opened, which lets an SSO user have additional credentials that can be treated as API keys.

From the SSO\'s perspective, a linked account is merely a different set of credentials that a particular SSO user
may employ, there is no further functional difference in logging as the SSO user directly or if it is done via Basic Auth
or JWT.

Linked accounts fully participate in
[rate-limiting and IP white-listing \<../../../guide/rate-limit\>] which makes it possible to express scenarios such as
the sample one below:

-   The main SSO user has a limit of 1,000 requests/day, no matter how many per hour
-   User\'s linked accounts have a limit of 100 requests/hour, no matter how many per day

REST API
========

-   [LinkedAuth.Create \<../../api/rest/user/linked/create\>]
-   [LinkedAuth.Get \<../../api/rest/user/linked/get\>]
-   [LinkedAuth.Delete \<../../api/rest/user/linked/delete\>]

Python API
==========

-   [create_linked_auth \<../../api/python/user/linked/create\>]
-   [get_linked_auth_list \<../../api/python/user/linked/get\>]
-   [delete_linked_auth \<../../api/python/user/linked/delete\>]
