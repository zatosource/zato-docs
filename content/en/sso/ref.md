---
title: API quick reference
---

```{=html}
<style type="text/css">

    td a[href="topic/user/super.html"] em,
    td a[href="topic/user/index.html"] em,
    td a[href="topic/user/session/index.html"] em,
    td a[href="topic/user/password/reset/index.html"] em,
    td a[href="topic/attr/index.html"] em
    {
        font-weight:bold;
    }

    td:nth-child(1) {
        width: 5%;
    }
    td:nth-child(2) {
        width: 90%;
        display: inline-block;
        white-space: nowrap;
    }
    td:nth-child(3) {
        width: 5%;
    }
</style>
```
Overview
========

The table below lists all available API calls and methods - the content is provided following a CRUD pattern or workflows involved,
and for each main block of functionality links to both relevant topics and to detailed API references are given.

Quick reference
===============

+----------------------+----------------------+----------------------+
| Topic                | REST                 | Python               |
+======================+======================+======================+
| [Users               |                      |                      |
| \<./topic/user/      |                      |                      |
| index\>] |                      |                      |
+----------------------+----------------------+----------------------+
| [User.create         | > [/zato/sso/user    | user.create          |
| \<./topic/user/c     | >                    | \<./api/py           |
| reate\>] |  \<./api/rest/user/c | thon/user/create\>\` |
| POST                 | reate\>] |                      |
|                      | > \`self.sso.        |                      |
+----------------------+----------------------+----------------------+
| [User.signup         | > [/                 | user.signup          |
| \<./topic/user/s     | zato/sso/user/signup | \<./api/py           |
| ignup\>] | >                    | thon/user/signup\>\` |
| POST                 |  \<./api/rest/user/s |                      |
|                      | ignup\>] |                      |
|                      | > \`self.sso.        |                      |
+----------------------+----------------------+----------------------+
| [User.confirm_signup | > [/                 | user.confirm_signup  |
| \<./topic/user/s     | zato/sso/user/signup | \<./api/python/use   |
| ignup\>] | > \<./api            | r/confirm-signup\>\` |
| PATCH                | /rest/user/confirm-s |                      |
|                      | ignup\>] |                      |
|                      | > \`self.sso.        |                      |
+----------------------+----------------------+----------------------+
| [User.approve        | > [/z                | user.approve         |
| \<./topic/user/s     | ato/sso/user/approve | \<./api/pyt          |
| ignup\>] | >                    | hon/user/approve\>\` |
| POST                 | \<./api/rest/user/ap |                      |
|                      | prove\>] |                      |
|                      | > \`self.sso.        |                      |
+----------------------+----------------------+----------------------+
| [User.reject         | > [/                 | user.reject          |
| \<./topic/user/s     | zato/sso/user/reject | \<./api/py           |
| ignup\>] | >                    | thon/user/reject\>\` |
| POST                 |  \<./api/rest/user/r |                      |
|                      | eject\>] |                      |
|                      | > \`self.sso.        |                      |
+----------------------+----------------------+----------------------+
| [User.login          | > [                  | user.login           |
| \<./topic/user/      | /zato/sso/user/login | \<./api/p            |
| login\>] | > \<./api/rest/user/ | ython/user/login\>\` |
| POST                 | login\>] |                      |
|                      | > \`self.sso.        |                      |
+----------------------+----------------------+----------------------+
| [User.logout         | > [/                 | user.logout          |
| \<./topic/user/l     | zato/sso/user/logout | \<./api/py           |
| ogout\>] | >                    | thon/user/logout\>\` |
| POST                 |  \<./api/rest/user/l |                      |
|                      | ogout\>] |                      |
|                      | > \`self.sso.        |                      |
+----------------------+----------------------+----------------------+
| [User.get            | > [/zato/sso/user    | [u                   |
| \<./topic/use        | > \<./api/rest/use   | ser.get_user_by]()\* |
| r/get\>] | r/get\>] | \<./api              |
| GET                  | > \`self.sso.        | /python/user/get\>\` |
+----------------------+----------------------+----------------------+
| [User.search         | > [/                 | user.search          |
| \<./topic/user/s     | zato/sso/user/search | \<./api/py           |
| earch\>] | >                    | thon/user/search\>\` |
| GET                  |  \<./api/rest/user/s |                      |
|                      | earch\>] |                      |
|                      | > \`self.sso.        |                      |
+----------------------+----------------------+----------------------+
| [User.update         | > [/zato/sso/user    | user.update          |
| \<./topic/user/u     | >                    | \<./api/py           |
| pdate\>] |  \<./api/rest/user/u | thon/user/update\>\` |
| PATCH                | pdate\>] |                      |
|                      | > \`self.sso.        |                      |
+----------------------+----------------------+----------------------+
| [User.delete         | E [/zato/sso/user    | user.delete          |
| \<./topic/user/d     | \<./api/rest/user/d  | \<./api/py           |
| elete\>] | elete\>] | thon/user/delete\>\` |
| DELET                | \`self.sso.          |                      |
+----------------------+----------------------+----------------------+
| [                    | > [/za               | user.change_password |
| User.change_password | to/sso/user/password | \<./api/python/user  |
| \<./topic/password/  | > \<./api/           | /change-password\>\` |
| index\>] | rest/user/change-pas |                      |
| PATCH                | sword\>] |                      |
|                      | > \`self.sso.        |                      |
+----------------------+----------------------+----------------------+
| [User.lock           | >                    | user.lock            |
| \<./topic/user/      | [/zato/sso/user/lock | \<./api/             |
| index\>] | > \<./api/rest/user  | python/user/lock\>\` |
| POST                 | /lock\>] |                      |
|                      | > \`self.sso.        |                      |
+----------------------+----------------------+----------------------+
| [User.unlock         | E                    | user.lock            |
| \<./topic/user/      | [/zato/sso/user/lock | \<./api/py           |
| index\>] | \<./api/rest/user/u  | thon/user/unlock\>\` |
| DELET                | nlock\>] |                      |
|                      | \`self.sso.          |                      |
+----------------------+----------------------+----------------------+
| [User.reset_totp_key | >                    | user.reset_totp_key  |
| \<./topic/user       | [/zato/sso/user/totp | \<./api/python       |
| /totp\>] | > \<.                | /user/reset-totp\>\` |
| PATCH                | /api/rest/user/reset |                      |
| [Super-users         | -totp\>] |                      |
| \<./topic/user/      | > \`self.sso.        |                      |
| super\>] |                      |                      |
+----------------------+----------------------+----------------------+
| SuperUser.create     | \-\--                | [self.sso.us         |
| [Linked accounts     |                      | er.create_super_user |
| \                    |                      | \<./api/pyth         |
| <./topic/user/linked |                      | on/user/create-super |
| -auth\>] |                      | -user\>] |
+----------------------+----------------------+----------------------+
| LinkedAuth.create    | POST                 | .sso.use             |
|                      | [/                   | r.create_linked_auth |
|                      | zato/sso/user/linked | \<./api/python/us    |
|                      | \<./ap               | er/linked/create\>\` |
|                      | i/rest/user/linked/c |                      |
|                      | reate\>] |                      |
|                      | \`self               |                      |
+----------------------+----------------------+----------------------+
| LinkedAuth.get       | GET                  | .sso.user.           |
|                      | [/                   | get_linked_auth_list |
|                      | zato/sso/user/linked | \<./api/python       |
|                      | \<.                  | /user/linked/get\>\` |
|                      | /api/rest/user/linke |                      |
|                      | d/get\>] |                      |
|                      | \`self               |                      |
+----------------------+----------------------+----------------------+
| LinkedAuth.delete    | DELETE               | .sso.use             |
| [Sessions            | [/                   | r.delete_linked_auth |
| \<./topic/session/   | zato/sso/user/linked | \<./api/python/us    |
| index\>] | \<./ap               | er/linked/delete\>\` |
|                      | i/rest/user/linked/d |                      |
|                      | elete\>] |                      |
|                      | \`self               |                      |
+----------------------+----------------------+----------------------+
| [Session.verify      | > [/z                | user.session.verify  |
| \<./topic/session/a  | ato/sso/user/session | \<./api/pytho        |
| ccess\>] | > \<                 | n/session/verify\>\` |
| POST                 | ./api/rest/session/v |                      |
|                      | erify\>] |                      |
|                      | > \`self.sso.        |                      |
+----------------------+----------------------+----------------------+
| [Session.renew       | > [/z                | user.session.renew   |
| \<./topic/session/a  | ato/sso/user/session | \<./api/pyth         |
| ccess\>] | > \                  | on/session/renew\>\` |
| PATCH                | <./api/rest/session/ |                      |
|                      | renew\>] |                      |
|                      | > \`self.sso.        |                      |
+----------------------+----------------------+----------------------+
| [Session.get         | > [/z                | user.session.get     |
| \<./topic/session/a  | ato/sso/user/session | \<./api/py           |
| ccess\>] | >                    | thon/session/get\>\` |
| GET                  |  \<./api/rest/sessio |                      |
|                      | n/get\>] |                      |
|                      | > \`self.sso.        |                      |
+----------------------+----------------------+----------------------+
| [Session.get_list    | > [/zato/s           | u                    |
| \<./topic/session/a  | so/user/session/list | ser.session.get_list |
| ccess\>] | > \<./               | \<./api/python/      |
| GET                  | api/rest/session/get | session/get-list\>\` |
| [User attributes     | -list\>] |                      |
| \<./topic/attr/      | > \`self.sso.        |                      |
| index\>] |                      |                      |
+----------------------+----------------------+----------------------+
| create/create_many   | POST                 | .                    |
|                      | [/zato/sso/user/attr | sso.user.session.att |
|                      | \<./                 | r.create/create_many |
|                      | api/rest/user/attr/c | \<./api/python/      |
|                      | reate\>] | user/attr/create\>\` |
|                      | \`self               |                      |
+----------------------+----------------------+----------------------+
| update/update_many   | PATCH                | .                    |
|                      | [/zato/sso/user/attr | sso.user.session.att |
|                      | \<./                 | r.update/update_many |
|                      | api/rest/user/attr/u | \<./api/python/      |
|                      | pdate\>] | user/attr/update\>\` |
|                      | \`self               |                      |
+----------------------+----------------------+----------------------+
| set/set_many         | PUT                  | .sso.user.sessi      |
|                      | [/zato/sso/user/attr | on.attr.set/set_many |
|                      | \                    | \<./api/pyth         |
|                      | <./api/rest/user/att | on/user/attr/set\>\` |
|                      | r/set\>] |                      |
|                      | \`self               |                      |
+----------------------+----------------------+----------------------+
| delete/delete_many   | DELETE               | .                    |
|                      | [/zato/sso/user/attr | sso.user.session.att |
|                      | \<./                 | r.delete/delete_many |
|                      | api/rest/user/attr/d | \<./api/python/      |
|                      | elete\>] | user/attr/delete\>\` |
|                      | \`self               |                      |
+----------------------+----------------------+----------------------+
| get/get_many         | GET                  | .sso.user.sessi      |
|                      | [/zato/sso/user/attr | on.attr.get/get_many |
|                      | \                    | \<./api/pyth         |
|                      | <./api/rest/user/att | on/user/attr/get\>\` |
|                      | r/get\>] |                      |
|                      | \`self               |                      |
+----------------------+----------------------+----------------------+
| exists/exists_many   | GET                  | .                    |
|                      | [/zato/              | sso.user.session.att |
|                      | sso/user/attr/exists | r.exists/exists_many |
|                      | \<./                 | \<./api/python/      |
|                      | api/rest/user/attr/e | user/attr/exists\>\` |
|                      | xists\>] |                      |
|                      | \`self               |                      |
+----------------------+----------------------+----------------------+
| names                | GET                  | .sso.use             |
| [Session attributes  | [/zato               | r.session.attr.names |
| \<./topic/attr/      | /sso/user/attr/names | \<./api/python       |
| index\>] | \<.                  | /user/attr/names\>\` |
|                      | /api/rest/user/attr/ |                      |
|                      | names\>] |                      |
|                      | \`self               |                      |
+----------------------+----------------------+----------------------+
| create/create_many   | POST                 | .                    |
|                      | [/z                  | sso.user.session.att |
|                      | ato/sso/session/attr | r.create/create_many |
|                      | \<./api              | \<./api/python/ses   |
|                      | /rest/session/attr/c | sion/attr/create\>\` |
|                      | reate\>] |                      |
|                      | \`self               |                      |
+----------------------+----------------------+----------------------+
| update/update_many   | PATCH                | .                    |
|                      | [/z                  | sso.user.session.att |
|                      | ato/sso/session/attr | r.update/update_many |
|                      | \<./api              | \<./api/python/ses   |
|                      | /rest/session/attr/u | sion/attr/update\>\` |
|                      | pdate\>] |                      |
|                      | \`self               |                      |
+----------------------+----------------------+----------------------+
| set/set_many         | PUT                  | .sso.user.sessi      |
|                      | [/z                  | on.attr.set/set_many |
|                      | ato/sso/session/attr | \<./api/python/      |
|                      | \<./                 | session/attr/set\>\` |
|                      | api/rest/session/att |                      |
|                      | r/set\>] |                      |
|                      | \`self               |                      |
+----------------------+----------------------+----------------------+
| delete/delete_many   | DELETE               | .                    |
|                      | [/z                  | sso.user.session.att |
|                      | ato/sso/session/attr | r.delete/delete_many |
|                      | \<./api              | \<./api/python/ses   |
|                      | /rest/session/attr/d | sion/attr/delete\>\` |
|                      | elete\>] |                      |
|                      | \`self               |                      |
+----------------------+----------------------+----------------------+
| get/get_many         | GET                  | .sso.user.sessi      |
|                      | [/z                  | on.attr.get/get_many |
|                      | ato/sso/session/attr | \<./api/python/      |
|                      | \<./                 | session/attr/get\>\` |
|                      | api/rest/session/att |                      |
|                      | r/get\>] |                      |
|                      | \`self               |                      |
+----------------------+----------------------+----------------------+
| exists/exists_many   | GET                  | .                    |
|                      | [/zato/sso           | sso.user.session.att |
|                      | /session/attr/exists | r.exists/exists_many |
|                      | \<./api              | \<./api/python/ses   |
|                      | /rest/session/attr/e | sion/attr/exists\>\` |
|                      | xists\>] |                      |
|                      | \`self               |                      |
+----------------------+----------------------+----------------------+
| names                | GET                  | .sso.use             |
|                      | [/zato/ss            | r.session.attr.names |
|                      | o/session/attr/names | \<./api/python/se    |
|                      | \<./ap               | ssion/attr/names\>\` |
|                      | i/rest/session/attr/ |                      |
|                      | names\>] |                      |
|                      | \`self               |                      |
+----------------------+----------------------+----------------------+

More information
================

-   Topic guides go into specific parts in depth: [Users \<../sso/topic/user/index\>] \|
    [Sessions \<./topic/session/index\>] \|
    [Passwords \<./topic/password/index\>] \|
    [Configuration \<./config/index\>] \|
    [Audit \<./audit/index\>]
-   The [command line interface \<../admin/cli/sso\>] provides additional options for administrators
-   All [warning and error codes \<./status-code\>] explained
