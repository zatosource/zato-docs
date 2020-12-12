---
title: Session.verify - REST API
---

Overview
========

Returns a boolean flag to indicate whether a session from target_ust exists or not, without renewing it.
Must be called by a logged in super-user.

Note that False will be returned if the session already expired or if its user\'s password expired.

> -   HTTP method: POST
> -   URL path: /zato/sso/user/session

Request
=======

  Name          Datatype   Optional   Notes
  ------------- ---------- ---------- -------------------------------------------------------------------
  target_ust    string     \-\--      UST of session to verify
  current_ust   string     \-\--      Current user\'s session token (UST) - must belong to a super-user
  current_app   string     \-\--      Name of application that the call is attempted from

Response
========

  Name         Datatype   Optional   Notes
  ------------ ---------- ---------- ----------------------------------------------------------------------------------------------------------------
  cid          string     \-\--      Correlation ID assigned to request
  status       string     \-\--      Overall [status code \<../../../status-code\>]
  sub_status   list       Yes        Returned only if status is not \"ok\", a list of [error or warning codes \<../../../status-code\>]
  is_valid     bool       Yes        True if target_ust points to an existing session, False otherwise

Usage
=====

``` 
$ curl -XGET localhost:17010/zato/sso/user/session -d '
  {
   "target_ust": "gAAAAABaqXJAenbkYyQt9CoWIvq...",
   "current_ust": "gAAAAABanYJQziYsPwDYOFJSR5...",
   "current_app": "CRM"
  }
  '

{
 "cid": "e0673f65704f74b2cd040fa6",
 "status": "ok",
 "is_valid": true
}
$
```
