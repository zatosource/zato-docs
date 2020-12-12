---
title: UserAttr.names - REST API
---

Overview
========

Returns a list of all attribute names defined for a user.

> -   HTTP method: GET
> -   URL path: /zato/sso/user/attr/names

Request
=======

  Name          Datatype   Optional   Notes
  ------------- ---------- ---------- -----------------------------------------------------
  ust           string     \-\--      Current user\'s session token (UST)
  current_app   string     \-\--      Name of application that the call is attempted from
  user_id       string     Yes        ID of the user to return a list of attributes of

Response
========

  Name         Datatype   Optional   Notes
  ------------ ---------- ---------- --------------------------------------------------------------------------
  cid          string     \-\--      Correlation ID assigned to request
  status       string     \-\--      Overall [status code \<../../../../status-code\>]
  sub_status   list       Yes        Returned only if status is not \"ok\", a list of [error or warning codes
                                     \<../../../../status-code\>]
  result       list       \-\--      Names of all attributes, if any, defined for a user

Usage
=====

``` 
$ curl -XGET localhost:17010/zato/sso/user/attr/names -d '
  {
   "current_ust": "gAAAAABavmAV3rw6fQUS-HgREvWBQTmivO7gZ89LZ5u3RwUeO-xmVMn8FsLJ4LnN3mN49IHWMXh9GqcLg4P73Zavb5sIdSdOUt0MjT53G1ps8PM_sGVQhbQ=",
   "current_app": "CRM",
   "user_id": "zusr6fh6fdgd4997ksjkpx7qnk659q"
  }
  '

  {
   "status": "ok",
   "cid": "22fdd109d125f302d3c862db",
   "result": ["my-attribute", "my-attribute2", "my-attribute3"]
  }
```
