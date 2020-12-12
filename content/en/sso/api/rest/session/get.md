---
title: Session.get - REST API
---

Overview
========

Returns details of a session indicated by target_ust, without renewing it. Must be called by a logged in super-user.

> -   HTTP method: GET
> -   URL path: /zato/sso/user/session

Request
=======

  Name          Datatype   Optional   Notes
  ------------- ---------- ---------- -------------------------------------------------------------------
  target_ust    string     \-\--      UST of session to return details of
  current_ust   string     \-\--      Current user\'s session token (UST) - must belong to a super-user
  current_app   string     \-\--      Name of application that the call is attempted from

Response
========

  Name              Datatype   Optional   Notes
  ----------------- ---------- ---------- ----------------------------------------------------------------------------------------------------------------
  cid               string     \-\--      Correlation ID assigned to request
  status            string     \-\--      Overall [status code \<../../../status-code\>]
  sub_status        list       Yes        Returned only if status is not \"ok\", a list of [error or warning codes \<../../../status-code\>]
  creation_time     datetime   Yes        When the session was created, in UTC
  expiration_time   datetime   Yes        When the session will expire, in UTC
  remote_addr       string     Yes        From what remote address the session was created
  user_agent        string     Yes        Using what user agent the session was created

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
 "creation_time": "2018-03-14T19:04:32",
 "expiration_time": "2018-03-14T20:04:32",
 "remote_addr": "127.0.0.1",
 "user_agent": "Firefox 139.0"
}
$
```
