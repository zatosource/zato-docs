---
title: LinkedAuth.delete - REST API
---

Overview
========

Deletes a previously
[created \<./create\>]
[link \<../../../../topic/user/linked-auth\>]
between an SSO user and a security definition.

> -   HTTP method: DELETE
> -   URL path: /zato/sso/user/linked

Request
=======

  Name            Datatype   Optional   Notes
  --------------- ---------- ---------- -------------------------------------------------------------------------
  ust             string     \-\--      Current user\'s session token (UST)
  current_app     string     \-\--      Name of application that the call is attempted from
  user_id         string     \-\--      ID of the SSO user to delete the link from
  auth_type       string     \-\--      Type of the definition the link uses, must be \'basic_auth\' or \'jwt\'
  auth_username   string     \-\--      Username from the definition linked to the SSO user

Response
========

  Name         Datatype   Optional   Notes
  ------------ ---------- ---------- --------------------------------------------------------------------------
  cid          string     \-\--      Correlation ID assigned to request
  status       string     \-\--      Overall [status code \<../../../../status-code\>]
  sub_status   list       Yes        Returned only if status is not \"ok\", a list of [error or warning codes
                                     \<../../../../status-code\>]

Usage
=====

``` 
$ curl -XDELETE localhost:17010/zato/sso/user/linked -d '
  {
   "current_ust": "gAAAAABavk-65BuvKI0JFPeuJ9Tp3pHtNMe...",
   "current_app": "CRM",
   "user_id": "zusr6fh6fdgd4997ksjkpx7qnk659q",
   "auth_type": "basic_auth",
   "auth_username": "my.user"
   "is_active": true
  }
  '

  {
   "status": "ok",
   "cid": "01513a304ef4409ed2a6caf3"
  }
```
