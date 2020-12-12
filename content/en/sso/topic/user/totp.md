---
title: Two-factor authentication
---

Each user canenabled or disable [TOTP-based](https://en.wikipedia.org/wiki/Time-based_One-time_Password_Algorithm)
two-factor authentication for his or her account, in this way making their login process depend not only on the knowledge
of the password but on a time-based random string too.

A TOTP key is a secret specific to each user and must never be shared or logged anywhere. Each key is accompanied by a label,
which is a free-text field that allows users to recall which of possibly many other keys this particular is for.

Regular users have access to their own TOTP keys only whereas super-users may access any other user\'s TOTP keys.

Keys and labels may be updated via
[REST \<../../api/rest/user/update\>]
or
[Python \<../../api/python/user/update\>]
which requires for a new key to be given on input.
It is also possible to have Zato generate a new key and assign it for user - from
[REST \<../../api/rest/user/reset-totp\>]
or
[Python \<../../api/python/user/reset-totp\>]
as well.

TOTP keys and labels are always encrypted when at rest in the database.

Note that TOTP is always enabled or disabled for main SSO credentials rather for any
[linked ones \<./linked-auth\>],
which are not covered by the functionality.
