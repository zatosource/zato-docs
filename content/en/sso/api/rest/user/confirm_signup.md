---
title: User.confirm_signup - REST API
---

Lets users confirm their intent to sign up with the SSO system. On input, a [confirmation token \<./signup\>] must be sent.

> -   HTTP method: POST
> -   URL path: /zato/sso/user/signup/confirm

Request
=======

  Name            Datatype   Optional?   Notes
  --------------- ---------- ----------- ---------------------------------------------------------------------------------
  confirm_token   string     \-\--       Confirmation token previously obtained during [signup \<./signup\>]
  current_app     string     \-\--       Name of the application the user is calling the API from

Response
========

  Name         Datatype   Optional   Notes
  ------------ ---------- ---------- -------------------------------------------------------------------------
  cid          string     \-\--      Correlation ID assigned to request
  status       string     \-\--      Overall [status code \<../../../status-code\>]
  sub_status   list       Yes        Returned only if status is not \"ok\",
                                     a list of [error or warning codes \<../../../status-code\>]

Usage
=====

``` 
$ curl -XPOST "localhost:17010/zato/sso/user/signup/confirm" -d '
{
 "confirm_token":"3x1gr0uXmM95wW7QsWuq7-VmPU1ueXLn",
 "current_app":"CRM"
}'


{
 "cid": "259529171ff77ce4c8b26e11",
 "status": "ok"
}
```
