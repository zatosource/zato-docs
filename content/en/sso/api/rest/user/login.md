---
title: User.login - REST API
---

Overview
========

Logs a user into the system. On success, returns a UST (user session token) that represents a particular session of
that user with the SSO environment.

On failure, a list of warning or error codes is returned. Note that the server log may contain additional details on top
of what is returned to API clients.

Note that only users whose approval_status is \"approved\" will be able to log in, otherwise an error will be raised.

> -   HTTP method: POST
> -   URL path: /zato/sso/user/login

Request
=======

  Name           Datatype   Optional   Notes
  -------------- ---------- ---------- -------------------------------------------------------------------------------------------------------------------------
  username       string     \-\--      Username to log in with
  password       string     \-\--      Password for username
  current_app    string     \-\--      Name of application that the call is attempted from
  totp_code      string     \-\--      Optional TOTP code if user has two-factor authentication enabled
  new_password   string     Yes        Required only if current password has already expired or user needs to set a new one
  remote_addr    string     Yes        Remote address (IP) of the API client, accepted only if [configuration \<../../../config/index\>] allows it
  user_agent     string     Yes        User agent string of the API client, accepted only if [configuration \<../../../config/index\>] allows it

Response
========

  Name         Datatype   Optional   Notes
  ------------ ---------- ---------- ----------------------------------------------------------------------------------------------------------------
  cid          string     \-\--      Correlation ID assigned to request
  status       string     \-\--      Overall [status code \<../../../status-code\>]
  sub_status   list       Yes        Returned only if status is not \"ok\", a list of [error or warning codes \<../../../status-code\>]
  ust          string     Yes        User session token to use in subsequent calls that require an authenticated user.
                                     Returned only if status is \"ok\".

Usage
=====

-   Everything is OK

``` 
$ curl -XPOST localhost:17010/zato/sso/user/login -d '
  {
  "username":     "user1",
  "password":     "SD:n25a9-?Z8e-49bQ  D%",
  "current_app":  "CRM"
  }'

{
  "status": "ok",
  "cid": "7bc5ffdf15ff1baa90693a9a",
  "ust": "gAAAAABakZBSHNBCLn4pPk9DqJ_byC6zdSv..."
}
$
```

-   Invalid username or password

``` 
$ curl -XPOST localhost:17010/zato/sso/user/login -d '
  {
  "username":     "user1",
  "password":     "SD:n25a9-?Z8e-49bQ  D%",
  "current_app":  "CRM"
  }'

{
  "status": "error",
  "cid": "30e22dfde268b7ba0b56ad0d",
  "sub_status": ["E005001"]
}
```
