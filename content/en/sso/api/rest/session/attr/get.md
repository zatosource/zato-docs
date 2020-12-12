---
title: SessionAttr.get - REST API
---

Overview
========

Returns data and metadata about a session attribute or attributes. There is no difference if input parameters are sent in
query string or request\'s body.

If only the very existence of attributes needs to be checked, it is faster and less resource-extensive to invoke
[exists \<./exists\>] instead of using this endpoint.

While the call\'s [Python equivalent \<../../../python/session/attr/get\>] has two versions, one for individual and the
other for multiple attributes, with REST there is a single endpoint to cover both cases. Yet, just like in the Python
call, it is more efficient to get multiple attributes in one REST call instead of repeatedly reading in individual ones.

> -   HTTP method: GET
> -   URL path: /zato/sso/session/attr

Request
=======

  Name          Datatype   Optional   Notes
  ------------- ---------- ---------- ------------------------------------------------------------------------------------------
  current_ust   string     \-\--      Current user\'s session token (UST)
  target_ust    string     \-\--      Target session\'s UST, the one that is being accessed (may be the same as current_ust)
  current_app   string     \-\--      Name of application that the call is attempted from
  name          string     Yes        If a single attribute is to be returned, the attribute\'s name
  decrypt       bool       Yes        Should the attribute\'s value be decrypted if it is in an encrypted form in the database
  data          list       Yes        If multiple attributes are to be returned, this is a list of their names

Response
========

  Name              Datatype   Optional   Notes
  ----------------- ---------- ---------- -------------------------------------------------------------------------------------
  cid               string     \-\--      Correlation ID assigned to request
  status            string     \-\--      Overall [status code \<../../../../status-code\>]
  sub_status        list       Yes        Returned only if status is not \"ok\", a list of [error or warning codes
                                          \<../../../../status-code\>]
  found             bool       Yes        If a single attribute was requested, indicates if it was found or not
  name              string     Yes        (Returned only if found is \"true\") Attribute\'s name rewritten from input
  value             string     Yes        (Returned only if found is \"true\") Attribute\'s value
  creation_time     datetime   Yes        (Returned only if found is \"true\") When was the attribute created
  last_modified     datetime   Yes        (Returned only if found is \"true\") When was the attribute last modified
  expiration_time   datetime   Yes        (Returned only if found is \"true\") When will the attribute expire
  is_encrypted      string     Yes        (Returned only if found is \"true\") True if attribute\'s value is stored encrypted
                                          in the database, else otherwise

Usage
=====

``` 
$ curl -XGET localhost:17010/zato/sso/session/attr -d '
  {
   "current_ust": "gAAAAABavmAV3rw6fQUS-HgREvWBQTmivO7gZ89LZ5u3RwUeO-xmVMn8FsLJ4LnN3mN49IHWMXh9GqcLg4P73Zavb5sIdSdOUt0MjT53G1ps8PM_sGVQhbQ=",
   "target_ust": "gAAAAABavk-65BuvKI0JFPeuJ9Tp3pHtNMeFWhVUEBVKExuaVE9KDLFpik4loT7kGHtb4GR2CZbfZL1o0yFeDNyoo2tDqBD8M5h-_JHfw8qlDy7B5ea9O4k=",
   "current_app": "CRM",
   "name": "my-attribute"
  }
  '

  {
   "status": "ok",
   "cid": "b67f4fd8a86c529e92be1e60",
   "found": true,
   "name": "my-attribute",
   "value": "my-value",
   "creation_time": "2018-03-27T16:42:45",
   "last_modified": "2018-03-27T16:42:45",
   "expiration_time": "9999-12-31T00:00:00",
   "is_encrypted": false
  }
```
