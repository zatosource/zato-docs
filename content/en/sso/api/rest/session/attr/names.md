---
title: SessionAttr.names - REST API
---

Overview
========

Returns a list of all attribute names defined for a session.

> -   HTTP method: GET
> -   URL path: /zato/sso/session/attr/names

Request
=======

  Name          Datatype   Optional   Notes
  ------------- ---------- ---------- ----------------------------------------------------------------------------------------
  current_ust   string     \-\--      Current user\'s session token (UST)
  target_ust    string     \-\--      Target session\'s UST, the one that is being accessed (may be the same as current_ust)
  current_app   string     \-\--      Name of application that the call is attempted from

Response
========

  Name         Datatype   Optional   Notes
  ------------ ---------- ---------- --------------------------------------------------------------------------
  cid          string     \-\--      Correlation ID assigned to request
  status       string     \-\--      Overall [status code \<../../../../status-code\>]
  sub_status   list       Yes        Returned only if status is not \"ok\", a list of [error or warning codes
                                     \<../../../../status-code\>]
  result       list       \-\--      Names of all attributes, if any, defined for a session

Usage
=====

``` 
$ curl -XGET localhost:17010/zato/sso/session/attr/names -d '
  {
   "current_ust": "gAAAAABavmAV3rw6fQUS-HgREvWBQTmivO7gZ89LZ5u3RwUeO-xmVMn8FsLJ4LnN3mN49IHWMXh9GqcLg4P73Zavb5sIdSdOUt0MjT53G1ps8PM_sGVQhbQ=",
   "target_ust": "gAAAAABavk-65BuvKI0JFPeuJ9Tp3pHtNMeFWhVUEBVKExuaVE9KDLFpik4loT7kGHtb4GR2CZbfZL1o0yFeDNyoo2tDqBD8M5h-_JHfw8qlDy7B5ea9O4k=",
   "current_app": "CRM"
  }
  '

  {
   "status": "ok",
   "cid": "22fdd109d125f302d3c862db",
   "result": ["my-attribute", "my-attribute2", "my-attribute3"]
  }
```
