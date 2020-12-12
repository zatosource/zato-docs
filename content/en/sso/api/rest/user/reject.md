---
title: User.reject - REST API
---

Overview
========

Changes a user\'s approval_status to \'rejected\'. A rejected user may not log in until he or she is [approved \<./approve\>].
It is not an error to reject an already rejected user.

Only super-users may [approve \<./approve\>] or reject other users.

> -   HTTP method: POST
> -   URL path: /zato/sso/user/reject

Request
=======

  Name          Datatype   Optional   Notes
  ------------- ---------- ---------- -------------------------------------------------------------------
  ust           string     \-\--      Current user\'s session token (UST) - must belong to a super-user
  current_app   string     \-\--      Name of application that the call is attempted from
  user_id       string     \-\--      ID of the user to reject

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
$ curl -XPOST localhost:17010/zato/sso/user/reject -d '
  {
   "ust": "gAAAAABanYJQziYsPwDYOFJSR5...",
   "user_id": "zusr73fzk8ncns8vd98dhpt0zjbese",
   "current_app": "CRM"
  }
  '

 {
  "cid": "50766febc45ea49373dcedc2",
  "status": "ok"
 }
$
```
