---
title: Custom attributes
---

In addition to [standard \<../user/index\>] attributes describing SSO users, such as username, password or email,
it is also possible to create and manage additional arbitrary attributes holding any kind of information required.

Custom user attributes exist either for as long as their user exists or, optionally, can be configured to expire after some time.
They will persist across multiple login sessions but a related feature,
session attributes, lets one set attributes for each session, each login, separately.

Name of an attribute is its identifier, there is no separate ID field. The name is unique independently for user and session attributes,
i.e. there can be a user attribute of a given name and a distinct session attribute of the same name but there cannot be multiple
user, nor session, attributes with the same name.

Each attribute can be optionally stored in the database in an encrypted form - this can be used, for instance,
with Social Security Numbers or other Personally Identifiable information (PII). Encryption and decryption is performed on the fly,
no programming is needed.

Regular users may access only their own attributes while super-users can manage attributes of any user.

The API is available for Python code and REST clients.

User attributes API
===================

+----------------------+----------------------+----------------------+
| REST                 | Python               | Description          |
+======================+======================+======================+
| POST                 | .                    | new named attribute  |
| [/zato/sso/user/attr | sso.user.attr.create |                      |
| \<../../             | \<../../api/python/  |                      |
| api/rest/user/attr/c | user/attr/create\>\` |                      |
| reate\>] | Creates a            |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
| POST                 | .sso.u               | ut can create        |
| [/zato/sso/user/attr | ser.attr.create_many | multiple attributes  |
| \<../../             | \<../../api/python/  | at a time            |
| api/rest/user/attr/c | user/attr/create\>\` |                      |
| reate\>] | As above b           |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
| PATCH                | .                    | > already existing   |
| [/zato/sso/user/attr | sso.user.attr.update | > attribute          |
| \<../../             | \<../../api/python/  |                      |
| api/rest/user/attr/u | user/attr/update\>\` |                      |
| pdate\>] | Updates an           |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
| PATCH                | .sso.u               | ut can update        |
| [/zato/sso/user/attr | ser.attr.update_many | multiple attributes  |
| \<../../             | \<../../api/python/  | at a time            |
| api/rest/user/attr/u | user/attr/update\>\` |                      |
| pdate\>] | As above b           |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
| PUT                  | .sso.user.attr.set   | new named attribute  |
| [/zato/sso/user/attr | \<../../api/pyth     | if it doesn\'t       |
| \<../                | on/user/attr/set\>\` | already exist or     |
| ../api/rest/user/att | Creates a            | updates it if it     |
| r/set\>] |                      | does                 |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
| PUT                  | .ss                  | ut can set multiple  |
| [/zato/sso/user/attr | o.user.attr.set_many | attributes at a time |
| \<../                | \<../../api/pyth     |                      |
| ../api/rest/user/att | on/user/attr/set\>\` |                      |
| r/set\>] | As above b           |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
| DELETE               | .                    | > attribute          |
| [/zato/sso/user/attr | sso.user.attr.delete |                      |
| \<../../             | \<../../api/python/  |                      |
| api/rest/user/attr/d | user/attr/delete\>\` |                      |
| elete\>] | Deletes an           |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
| DELETE               | .sso.u               | ut can delete        |
| [/zato/sso/user/attr | ser.attr.delete_many | multiple attributes  |
| \<../../             | \<../../api/python/  | at a time            |
| api/rest/user/attr/d | user/attr/delete\>\` |                      |
| elete\>] | As above b           |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
| GET                  | .sso.user.attr.get   | > attribute\'s       |
| [/zato/sso/user/attr | \<../../api/pyth     | > value, possibly    |
| \<../                | on/user/attr/get\>\` | > with its metadata  |
| ../api/rest/user/att | Returns an           |                      |
| r/get\>] |                      |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
| GET                  | .ss                  | ut can return        |
| [/zato/sso/user/attr | o.user.attr.get_many | multiple attributes  |
| \<../                | \<../../api/pyth     | at a time            |
| ../api/rest/user/att | on/user/attr/get\>\` |                      |
| r/get\>] | As above b           |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
| GET                  | .                    | an attribute exists  |
| [/zato/              | sso.user.attr.exists |                      |
| sso/user/attr/exists | \<../../api/python/  |                      |
| \<../../             | user/attr/exists\>\` |                      |
| api/rest/user/attr/e | Checks if            |                      |
| xists\>] |                      |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
| GET                  | .sso.u               | ut can check         |
| [/zato/              | ser.attr.exists_many | multiple attributes  |
| sso/user/attr/exists | \<../../api/python/  | at a time            |
| \<../../             | user/attr/exists\>\` |                      |
| api/rest/user/attr/e | As above b           |                      |
| xists\>] |                      |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
| GET                  | .sso.user.attr.names | mes of all           |
| [/zato               | \<../../api/python   | attributes defined   |
| /sso/user/attr/names | /user/attr/names\>\` | for a user (only     |
| \<../../             | Returns na           | names, without       |
| api/rest/user/attr/e |                      | values)              |
| xists\>] |                      |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+

Session attributes API
======================

+----------------------+----------------------+----------------------+
| REST                 | Python               | Description          |
+======================+======================+======================+
| POST                 | .sso                 | new named attribute  |
| [/z                  | .session.attr.create |                      |
| ato/sso/session/attr | \<                   |                      |
| \<../../api          | ../../api/python/ses |                      |
| /rest/session/attr/c | sion/attr/create\>\` |                      |
| reate\>] | Creates a            |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
| POST                 | .sso.sess            | ut can create        |
| [/z                  | ion.attr.create_many | multiple attributes  |
| ato/sso/session/attr | \<                   | at a time            |
| \<../../api          | ../../api/python/ses |                      |
| /rest/session/attr/c | sion/attr/create\>\` |                      |
| reate\>] | As above b           |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
| PATCH                | .sso                 | > already existing   |
| [/z                  | .session.attr.update | > attribute          |
| ato/sso/session/attr | \<                   |                      |
| \<../../api          | ../../api/python/ses |                      |
| /rest/session/attr/u | sion/attr/update\>\` |                      |
| pdate\>] | Updates an           |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
| PATCH                | .sso.sess            | ut can update        |
| [/z                  | ion.attr.update_many | multiple attributes  |
| ato/sso/session/attr | \<                   | at a time            |
| \<../../api          | ../../api/python/ses |                      |
| /rest/session/attr/u | sion/attr/update\>\` |                      |
| pdate\>] | As above b           |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
| PUT                  | .                    | new named attribute  |
| [/z                  | sso.session.attr.set | if it doesn\'t       |
| ato/sso/session/attr | \<../../api/python/  | already exist or     |
| \<../../             | session/attr/set\>\` | updates it if it     |
| api/rest/session/att | Creates a            | does                 |
| r/set\>] |                      |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
| PUT                  | .sso.s               | ut can set multiple  |
| [/z                  | ession.attr.set_many | attributes at a time |
| ato/sso/session/attr | \<../../api/python/  |                      |
| \<../../             | session/attr/set\>\` |                      |
| api/rest/session/att | As above b           |                      |
| r/set\>] |                      |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
| DELETE               | .sso                 | > attribute          |
| [/z                  | .session.attr.delete |                      |
| ato/sso/session/attr | \<                   |                      |
| \<../../api          | ../../api/python/ses |                      |
| /rest/session/attr/d | sion/attr/delete\>\` |                      |
| elete\>] | Deletes an           |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
| DELETE               | .sso.sess            | ut can delete        |
| [/z                  | ion.attr.delete_many | multiple attributes  |
| ato/sso/session/attr | \<                   | at a time            |
| \<../../api          | ../../api/python/ses |                      |
| /rest/session/attr/d | sion/attr/delete\>\` |                      |
| elete\>] | As above b           |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
| GET                  | .                    | > attribute\'s       |
| [/z                  | sso.session.attr.get | > value, possibly    |
| ato/sso/session/attr | \<../../api/python/  | > with its metadata  |
| \<../../             | session/attr/get\>\` |                      |
| api/rest/session/att | Returns an           |                      |
| r/get\>] |                      |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
| GET                  | .sso.s               | ut can return        |
| [/z                  | ession.attr.get_many | multiple attributes  |
| ato/sso/session/attr | \<../../api/python/  | at a time            |
| \<../../             | session/attr/get\>\` |                      |
| api/rest/session/att | As above b           |                      |
| r/get\>] |                      |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
| GET                  | .sso                 | an attribute exists  |
| [/zato/sso           | .session.attr.exists |                      |
| /session/attr/exists | \<                   |                      |
| \<../../api          | ../../api/python/ses |                      |
| /rest/session/attr/e | sion/attr/exists\>\` |                      |
| xists\>] | Checks if            |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
| GET                  | .sso.sess            | ut can check         |
| [/zato/sso           | ion.attr.exists_many | multiple attributes  |
| /session/attr/exists | \<                   | at a time            |
| \<../../api          | ../../api/python/ses |                      |
| /rest/session/attr/e | sion/attr/exists\>\` |                      |
| xists\>] | As above b           |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
| GET                  | .ss                  | mes of all           |
| [/zato/ss            | o.session.attr.names | attributes defined   |
| o/session/attr/names | \                    | for a session (only  |
| \<../../api          | <../../api/python/se | names, without       |
| /rest/session/attr/e | ssion/attr/names\>\` | values)              |
| xists\>] | Returns na           |                      |
| \`self               |                      |                      |
+----------------------+----------------------+----------------------+
