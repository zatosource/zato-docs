---
title: Passwords
---

Password strength and safety
============================

-   Each user has an associated password which is a secret that should be known to that user alone
-   Each password is stored in a hashed form in the SSO database using the PBKDF2-SHA512 algorithm. The default number of rounds
    is 100000 (100k) but it should be set accordingly from [command line \<../../../../admin/cli/hash-get-rounds\>]
    for each environment separately. Default salt is 64 bytes (512 bits) and it is unique for each password.
-   In addition to hashing, passwords are by default encrypted using [Fernet keys](https://cryptography.io/en/latest/fernet/)
    (AES-128) but if needed, this can be
    [turned off \<../../config/index\>]
-   It is not possible to turn off passwords hashing
-   Super-users may
    [change \<../../../../admin/cli/sso-change-user-password\>]
    passwords or
    [reset \<../../../../admin/cli/sso-reset-user-password\>]
    them but no one is able to reveal any other person\'s password

Enforcement
===========

-   The knowledge of one\'s password is checked each time a given person [logs in \<../user/login\>]

-   Additionally, during each API call passwords are checked for their expiry - if a person logged in previously but in the meantime
    the password has expired, all new API calls will be rejected

-   It is possible to specify a period upon entering which a password will be treated as one to expire soon - in this case, depending on
    [configuration \<../../config/index\>], new login requests will be either rejected with an error or warning to indicate
    that a user cannot log in because of the approaching password expiry.

    For instance, a password expiry may be set to 180 days and the last 15 days may be considered approaching expiry,
    meaning users will be required to change it before logging in. If they don\'t, the password will expire.

-   Passwords will be rejected if they contain strings that are among the most popular passwords and passphrases in the world.
    The list of such forbidden strings may be [customized \<../../config/index\>] as needed.

-   Passwords must be of a specific length, by default between 8-255 characters. Whitespace is accepted.

Changing passwords
==================

-   Each user may change his or her password if a new one is sent along with the old one
-   Additionaly, super-users may change any other person\'s password though if they change their own password, the same principle
    applies in that they need to send the old one
-   Passwords can be changed through
    [REST \<../../api/rest/user/change-password\>],
    [Python \<../../api/python/user/change-password\>]
    and from
    [command line \<../../../../admin/cli/sso-change-user-password\>]
-   Furthermore, it is possible to
    [reset \<../../../../admin/cli/sso-reset-user-password\>]
    one\'s password from command line - a new strong one (192 bits) will be generated and printed
    to stdout
