---
title: LinkedAuth.get - REST API
---

Overview
========

Returns a list of [linked accounts \<../../../../topic/user/linked-auth\>] for input SSO user. Regular users may look up
their own linked accounts only. Super-users may list linked accounts of any user.

> -   HTTP method: GET
> -   URL path: /zato/sso/user/linked

Request
=======

  Name          Datatype   Optional   Notes
  ------------- ---------- ---------- ------------------------------------------------------------------------
  ust           string     \-\--      Current user\'s session token (UST). If user_id is not given on input,
                                      linked accounts will be returned for the user pointed to by UST.
  current_app   string     \-\--      Name of application that the call is attempted from
  user_id       string     Yes        ID of the SSO user to return linked definitions for.
                                      If provided, input UST must belong to a super-user.

Response
========

  Name                   Datatype   Optional   Notes
  ---------------------- ---------- ---------- --------------------------------------------------------------------------
  cid                    string     \-\--      Correlation ID assigned to request
  status                 string     \-\--      Overall [status code \<../../../../status-code\>]
  sub_status             list       Yes        Returned only if status is not \"ok\", a list of [error or warning codes
                                               \<../../../../status-code\>]
  result.auth_type       string     \-\--      Type of the definition the SSO user is linked to, will be \'basic_auth\'
                                               \'jwt\'
  result.auth_username   string     \-\--      Basic Auth or JWT username of the linked account
  result.creation_time   datetime   \-\--      When the link was created, in UTC
  result.is_active       bool       \-\--      A flag to indicate if the link is active

Usage
=====

``` 
$ curl -XGET localhost:17010/zato/sso/user/linked -d '
  {
   "current_ust": "gAAAAABavk-65BuvKI0JFPeuJ9Tp3pHtNMeFWhVUEBVKExua...",
   "current_app": "CRM",
  }
  '

  {
   "status": "ok",
   "cid": "01513a304ef4409ed2a6caf3",
   "result": [
     {
       "auth_type": "basic_auth",
       "auth_username": "my.username",
       "creation_time": "2019-06-03T08:32:34.151267",
       "is_active": true
     }
   ]
  }
```
