---
title: Session.get_list - REST API
---

Overview
========

Returns a list of all sessions of the user identified by:

-   **ust** - current user\'s sessions will be returned
-   **target_ust** and **current_ust** - sessions of the user pointed to by target_ust will be returned

Either ust or both target_ust and current_ust are required on input. In the latter case, current_ust must belong to a super-user.

> -   HTTP method: GET
> -   URL path: /zato/sso/user/session/list

Request
=======

  Name          Datatype   Optional   Notes
  ------------- ---------- ---------- --------------------------------------------------------------------------------
  ust           string     Yes        Current session\'s identifier
  target_ust    string     Yes        UST of session to return details of
  current_ust   string     Yes        Current user\'s session token (UST) - if provided, must belong to a super-user
  current_app   string     \-\--      Name of application that the call is attempted from

Response
========

+----------------------+----------+----------+----------------------+
| Name                 | Datatype | Optional | Notes                |
+======================+==========+==========+======================+
| cid                  | string   | \-\--    | Correlation ID       |
|                      |          |          | assigned to request  |
+----------------------+----------+----------+----------------------+
| status               | string   | \-\--    | Overall [status code |
|                      |          |          | \<../../../status    |
|                      |          |          | -code\>] |
+----------------------+----------+----------+----------------------+
| sub_status           | list     | Yes      | Returned only if     |
|                      |          |          | status is not        |
|                      |          |          | \"ok\", a list of    |
|                      |          |          | [error or warning    |
|                      |          |          | codes                |
|                      |          |          | \<../../../status    |
|                      |          |          | -code\>] |
+----------------------+----------+----------+----------------------+
| result.auth_type     | string   | \-\--    | Using what           |
|                      |          |          | authentication       |
|                      |          |          | method the session   |
|                      |          |          | was opened; one of   |
|                      |          |          | \'default\',         |
|                      |          |          | \'basic_auth\' or    |
|                      |          |          | \'jwt\'              |
+----------------------+----------+----------+----------------------+
| r                    | string   | \-\--    | Human-readable       |
| esult.auth_principal |          |          | identifier of the    |
|                      |          |          | account or person    |
|                      |          |          | that the session was |
|                      |          |          | opened for,          |
|                      |          |          | e.g. the person\'s   |
|                      |          |          | username             |
+----------------------+----------+----------+----------------------+
| result.creation_time | datetime | \-\--    | When the session was |
|                      |          |          | created, in UTC      |
+----------------------+----------+----------+----------------------+
| re                   | datetime | \-\--    | When the session     |
| sult.expiration_time |          |          | will expire, in UTC  |
+----------------------+----------+----------+----------------------+
| result.remote_addr   | string   | Yes      | From what remote     |
|                      |          |          | address the session  |
|                      |          |          | was created          |
+----------------------+----------+----------+----------------------+
| result.user_agent    | string   | Yes      | Using what user      |
|                      |          |          | agent the session    |
|                      |          |          | was created          |
+----------------------+----------+----------+----------------------+
| result.sessi         | list     | Yes      | A list of            |
| on_state_change_list |          |          | dictionaries for     |
|                      |          |          | each major           |
|                      |          |          | interaction with the |
|                      |          |          | sessions - contains  |
|                      |          |          | metadata             |
|                      |          |          | about when each      |
|                      |          |          | session was created  |
|                      |          |          | and renewed. A new   |
|                      |          |          | entry is added to    |
|                      |          |          | this list            |
|                      |          |          | upon each such       |
|                      |          |          | interaction. The     |
|                      |          |          | list contains 100 of |
|                      |          |          | the latest entries.  |
|                      |          |          |                      |
|                      |          |          | The list is sorted   |
|                      |          |          | by timestamp_utc,    |
|                      |          |          | older entries are    |
|                      |          |          | earlier,             |
|                      |          |          | and each dictionary  |
|                      |          |          | has keys:            |
|                      |          |          |                      |
|                      |          |          | -   remote_addr -    |
|                      |          |          |     from what remote |
|                      |          |          |     address the      |
|                      |          |          |     event was        |
|                      |          |          |     triggered        |
|                      |          |          | -   user_agent -     |
|                      |          |          |     using what user  |
|                      |          |          |     agent the event  |
|                      |          |          |     was triggered    |
|                      |          |          |     with             |
|                      |          |          | -   timestamp_utc -  |
|                      |          |          |     when the event   |
|                      |          |          |     happened, in UTC |
|                      |          |          | -   ctx_source -     |
|                      |          |          |     event type, one  |
|                      |          |          |     of \'login\' or  |
|                      |          |          |     \'renew\'        |
|                      |          |          | -   idx - event      |
|                      |          |          |     number, will     |
|                      |          |          |     grow for each    |
|                      |          |          |     session          |
|                      |          |          |     separately.      |
|                      |          |          |     Starts from 1.   |
+----------------------+----------+----------+----------------------+

Usage
=====

``` 
$ curl -XGET localhost:17010/zato/sso/user/session/list -d '
  {
   "ust": "gAAAAABaqXJAenbkYyQt9CoWIvq...",
   "current_app": "CRM"
  }
  '

{
 "cid": "e0673f65704f74b2cd040fa6",
 "status": "ok",
 "auth_type": "default",
 "auth_principal": "joan.doe",
 "creation_time": "2019-05-19T19:19:40",
 "expiration_time": "2019-05-21T19:19:40",
 "remote_addr": "127.0.0.1",
 "user_agent": "Firefox 139.0",
 "session_state_change_list": [
   {"remote_addr":"127.0.0.1",
    "user_agent":"Firefox 139.0",
    "timestamp_utc":"2019-05-19T19:19:40",
    "ctx_source":"login",
    "idx":"1"
   },
   {"remote_addr":"127.0.0.1",
    "user_agent":"Firefox 139.0",
    "timestamp_utc":"2019-05-19T19:23:40",
    "ctx_source":"renew",
    "idx":"2"
   }
 ]
}
$
```
