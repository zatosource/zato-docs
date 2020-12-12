---
title: Logging in
---

This chapter explains how users may log into applications. While logging users in, Zato provides:

-   Authentication - credentials must be valid
-   Authorization - it must be possible to log in to the application that is requested on input

Information below is presented in a task-oriented manner - consult the
reference chapters for full
[REST \<../../api/rest/user/login\>]
and
[Python \<../../api/python/user/login\>]
APIs.

Authentication
==============

To authenticate with Zato, users send an API request as below, providing their username, password and name of the application
that they want to log in from.

``` {.bash}
$ curl -XPOST localhost:11223/zato/sso/user/login -d '
  {
    "username":    "user1",
    "password":    "VrF57-H31 7!HIj%fSAz :L9",
    "current_app": "CRM"
  }
'

{
  "status": "ok",
  "ust": "gAAAAABakWKBtUQATWUOQLsQRTZ_fijYbv...",
  "cid": "c92c7a6e772749c0c2f646fc"
}
```

If the call is successful, a session object is created and stored in database while a user session token (UST) is returned
to the caller.

For the call to be considered a success, all of the below must be fulfilled:

-   It must be possible to log into the application requested (CRM above)
-   User must not have been locked out of the authentication system by a super-user
-   If applicable, user must be fully signed up, including account creation\'s confirmation
-   If applicable, user must be approved by a super-user
-   If applicable, password may not be about to expire
-   If applicable, requests must originate in a white-listed IP address
-   Password must not have expired
-   If password is marked as requiring a change upon next login, it must be given on input
-   Credentials must be valid

Each UST return is valid during subsequent API calls in all applications that Zato is aware of, without a need for the user
to log in again in each of them. A single user may be logged in multiple times independently of other sessions.

A UST has a number of attributes, such as time-to-live - some of them may be read by user while others are readable
to super-users only. Regular users cannot look up another regular user\'s session information.

Note that the value of UST returned to API callers is always encrypted using a server\'s secret key (AES-128). It is not possible
to decrypt it on client side without the knowledge of secret key.

Authorizing login to applications
=================================

Not all applications can be logged into - some can only be accessed after a user logs into a different one and already has
a valid UST. Only applications explicitly listed in [configuration \<../../config/index\>]
can be used for logging in.

Login metadata
==============

For login requests made through HTTP, Zato will extract remote IP address and user agent from HTTP headers, honouring headers
set by intermediate proxy servers. However, at times, it may be required for the client application to send over these
meta-attributes in JSON.

For instance, if the API client itself is a server-side application that uses WebSockets to connect to Zato,
it may have only a handful of WebSocket connections to Zato yet it may serve many times more users connecting
to it from browsers.

In such cases, applications may send additional information, like below:

``` {.bash}
$ curl -XPOST localhost:11223/zato/sso/user/login -d '
  {
    "username":    "user1",
    "password":    "VrF57-H31 7!HIj%fSAz :L9",
    "current_app": "CRM",
    "remote_addr": "10.271.38.19",
    "user_agent":  "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:58.0) Firefox/58.0"
  }
'

{
  "status": "ok",
  "ust": "gAAAAABakWKp5b2-zz4dHRa8...",
  "cid": "df51cd3b0e56bf32c4c64f37"
}
```

The ability to send login metadata needs to be enabled in
[configuration \<../../config/index\>], otherwise requests will be rejected
with error code E006001.

``` {.bash}
{
  "status": "error",
  "sub_status": "E006001",
  "cid": "cb9d48bb4d95726ba18665ea"
}
```

Password expiry
===============

Each password has an expiration attached, a period during which it may be used. By default it is 2 years.

If an expired password is given on input, login is rejected and, optionally, error code E003004 is returned
to let the caller know that this password is expired.

The error code is not returned unless turned on in [configuration file \<../../config/index\>]. This is to prevent disclosure
of information about user accounts that are no longer in use. Instead a generic \'Invalid username or password\' message
is returned. In either case, an audit log entry is made to let administrators know that an expired password was sent.

Approaching password expiry notification
========================================

It is possible to [configure \<../../config/index\>] authentication so as to warn about and reject requests
if they fall into a window of approaching expiration time.

For instance, if the password expiration is set to 200 days and about_to_expire_threshold in configuration is set to 30 then
if login attempts are made within the last 30 days from the time the password was last changed, the authentication will
succeed but a warning code W003005 will be returned to the API caller to point out the approaching expiration.

Moreover, log_in_if_about_to_expire controls whether users may log in during that period. It defaults to True, but if it is set
to False, all login attempts will be rejected with the error code E003006 - this can be used to implement
workflows where users are required to change their passwords before they expire, using JSON data as below, with a new password
on input.

``` {.bash}
$ curl -XPOST localhost:11223/zato/sso/user/login -d '
  {
    "username":     "user1",
    "password":     "VrF57-H31 7!HIj%fSAz :L9",
    "new_password": "KV`39t9Um_ONTHXF":46C8bE2",
    "current_app":  "CRM"
  }
'

{
  "status": "ok",
  "ust": "gAAAAABakWLBfYbL0mBREn1LmTCNYm...",
  "cid": "6e0264fe5ca1bfe8d3634616"
}
```

Password change enforcement
===========================

Super-users may trigger an API call, as below, which will set a flag that will require the user to change password the next
time the person logs in.

``` {.bash}
$ curl -XPATCH localhost:11223/zato/sso/user -d '
  {
    "ust":     "gAAAAABakWLKRCWYhG9JJuyth...",
    "user_id": "zusr23dq0bazrg8yjvpsarsjqrenbk",
    "password_must_change": true,
  }
'

{
  "status": "ok",
  "cid": "fad1da4a7bb1fd850a83e5af"
}
```

Now, the user pointed to by user_id above, will need to send both correct credentials and a new password to log in:

``` {.bash}
$ curl -XPOST localhost:11223/zato/sso/user/login -d '
  {
    "username":     "user1",
    "password":     "VrF57-H31 7!HIj%fSAz :L9",
    "new_password": "KYDi8-otmY1+5KuiT-096x0M",
    "current_app":  "CRM"
  }
'

{
  "status": "ok",
  "ust": "gAAAAABakWLc9gqe1JqHNpp...",
  "cid": "f56a7eda1809d08508953d10"
}
```

If credentials are correct but the new password is not sent, error code E003007 is returned:

``` {.bash}
$ curl -XPOST localhost:11223/zato/sso/user/login -d '
  {
    "username":     "user1",
    "password":     "VrF57-H31 7!HIj%fSAz :L9",
    "current_app":  "CRM"
  }
'

{
  "status": "error",
  "sub_status": "E003007",
  "cid": "e608cee5d5ccc326c55e3db8"
}
```

Limiting access to specific users and IP addresses {#sso-topic-user-login-list}
==================================================

By default, all users may access REST APIs from all addresses, but access can be restricted to specific users and, additionally,
to specific remote addresses.

Stanza user_address_list in [configuration \<../../config/index\>] specifies what users may invoke APIs and from what
IP addresses the requests must be coming from - otherwise, they will be rejected with error code E005001.
Note that the list may contain both regular and super-users.

If user sends multiple IP addresses, for instance, they may be added by proxies, then each of the addresses must match
at least one of corresponding entries in user_address_list.

A related key is reject_if_not_listed which decides how to treat a request if user is not provided in the list.
By default, users that are not listed are allowed to log in but setting this key to False will let log in only users that
are on list.

Use an asterisk to let a user log in from any address.

If a username is listed but there is no IP address given for that user, the user will be rejected regardless of
reject_if_not_listed.

This lets one construct several interesting scenarios of both whitelisting and blacklisting kind.

-   Let all users in, no matter their IP address - this is the default configuration:

    ``` {.bash}
    [login]
    reject_if_not_listed=False

    [user_address_list]
    # Nothing here
    ```

-   Do not let anyone to log in

    ``` {.bash}
    [login]
    reject_if_not_listed=True

    [user_address_list]
    # Nothing here
    ```

-   Let everyone to log in but users admin and root must come from specific addresses - note that complete addresses
    and address ranges can be used:

    ``` {.bash}
    [login]
    reject_if_not_listed=False

    [user_address_list]
    admin=10.23.172.3, 10.23.172.4, 10.23.172.5, 172.16.0.0/12
    root=172.16.0.0/12
    ```

-   Users admin and root must come from specific addresses, and so does user1, while user2\'s requests may originate anywhere.
    Any other user will be rejected because *reject_if_not_listed* is True:

    ``` {.bash}
    [login]
    reject_if_not_listed=True

    [user_address_list]
    admin=10.23.172.3, 10.23.172.4, 10.23.172.5, 172.16.0.0/12
    root=172.16.0.0/12
    user1=10.64.12.97
    user2=*
    ```

-   In principle, all users may log in from any address but, additionallly, admin1 has a specific IP whitelisted whereas
    admin2 and admin3 may not log from anywhere because there are no remote addresses enabled for them:

    ``` {.bash}
    [login]
    reject_if_not_listed=False

    [user_address_list]
    admin1=10.23.172.3
    admin2=
    admin3=
    ```
