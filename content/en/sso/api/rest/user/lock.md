---
title: User.lock - REST API
---

Overview
========

Lock a user specified by user_id. A locked user cannot log in to the system. Input UST must belong to a logged in super-user.

Use [User.unlock \<./unlock\>] to unlock an already locked user.

> -   HTTP method: POST
> -   URL path: /zato/sso/user/lock

Request
=======

  Name          Datatype   Optional   Notes
  ------------- ---------- ---------- -----------------------------------------------------
  ust           string     \-\--      Current user\'s session token (UST)
  current_app   string     \-\--      Name of application that the call is attempted from
  user_id       string     \-\--      ID of the user to lock

Response
========

  Name         Datatype   Optional   Notes
  ------------ ---------- ---------- ----------------------------------------------------------------------------------------------------------------
  cid          string     \-\--      Correlation ID assigned to request
  status       string     \-\--      Overall [status code \<../../../status-code\>]
  sub_status   list       Yes        Returned only if status is not \"ok\", a list of [error or warning codes \<../../../status-code\>]

Usage
=====

``` 
$ curl -XPOST localhost:17010/zato/sso/user/lock -d '
  {
   "ust": "gAAAAABaluMOuV63skky-6ZZzlaPs...",
   "current_app": "CRM",
   "user_id": "zusr20ksc6vzb29fvbg8zympcnqdm9"
  }
  '

  {
      "cid": "de00deb0471188dcdd9913a8",
      "status": "ok"
  }
```
