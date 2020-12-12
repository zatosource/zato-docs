---
title: SessionAttr.set - REST API
---

Overview
========

Creates a new [session attribute \<../../../../topic/attr/index\>] or updates an existing one,
optionally encrypting it before it is saved in the database. It is also possible to set expiry
for an attribute, upon reaching of which the attribute will be no longer available.

While the call\'s [Python equivalent \<../../../python/session/attr/set\>] has two versions, one for individual and the
other for multiple attributes, with REST there is a single endpoint to cover both cases. Yet, just like in the Python
call, it is more efficient to set multiple attributes in one REST call instead of repeatedly setting individual ones.

> -   HTTP method: PUT
> -   URL path: /zato/sso/session/attr

Request
=======

  Name          Datatype   Optional   Notes
  ------------- ---------- ---------- -------------------------------------------------------------------------------------------
  current_ust   string     \-\--      Current user\'s session token (UST)
  target_ust    string     \-\--      Target session\'s UST, the one that is being manipulated (may be the same as current_ust)
  current_app   string     \-\--      Name of application that the call is attempted from
  name          string     Yes        If a single attribute is to be set, the attribute\'s name
  value         string     Yes        If a single attribute is to be set, the attribute\'s value
  data          list       Yes        If multiple attributes are to be set, a list of dictionaries,
                                      each describing an individual attribute,
                                      like in the set_many [Python API \<../../../python/session/attr/set\>]
  encrypt       bool       Yes        Should the attribute\'s new value be encrypted before it is saved to the database.
                                      Defaults to False.
  expiration    int        Yes        After how many seconds from current time the attribute should expire.
                                      By default it will never expire.

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
$ curl -XPUT localhost:17010/zato/sso/session/attr -d '
  {
   "current_ust": "gAAAAABavk-65BuvKI0JFPeuJ9Tp3pHtNMeFWhVUEBVKExuaVE9KDLFpik4loT7kGHtb4GR2CZbfZL1o0yFeDNyoo2tDqBD8M5h-_JHfw8qlDy7B5ea9O4k=",
   "target_ust": "gAAAAABavk-65BuvKI0JFPeuJ9Tp3pHtNMeFWhVUEBVKExuaVE9KDLFpik4loT7kGHtb4GR2CZbfZL1o0yFeDNyoo2tDqBD8M5h-_JHfw8qlDy7B5ea9O4k=",
   "current_app": "CRM",
   "name": "my-new-rest-attribute",
   "value": "my-new-rest-value",
   "encrypt": true,
   "expiration": 3600
  }
  '

  {
   "status": "ok",
   "cid": "e07c2f8fa0bb5d3b17dcf181"
  }
```
