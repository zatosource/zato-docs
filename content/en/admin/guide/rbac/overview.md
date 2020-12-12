---
title: RBAC (Role-based access control)
---

RBAC allows one to group related client credentials accessing [HTTP channels ](../../../web-admin/channels/plain-http)
into roles and assign permissions -Create, Read, Update, Delete - to roles instead of clients directly.

Using roles lets one cleanly separate access rights granted for individual services without an overhead of maintaining permissions
for each client individually.

Roles can be grouped into hierarchies, with inheritance, and most commonly used HTTP verbs - POST, GET, UPDATE, DELETE -map to permissions for services.

For instance - in run-time, client accessing an HTTP channel with GET will be validated against having Read permission for the service
mounted on that channel.

Clients belonging to one role may all use different security mechanism - e.g. some may use
[HTTP Basic Auth ](../../../web-admin/security/basic-auth)
whereas the rest will be using
[client SSL/TLS certificates ](../../../web-admin/security/tls/overview).

Details
=======

+----------------------------------+----------------------------------+
| Name                             | Notes                            |
+==================================+==================================+
| [Role                            | > group client credentials       |
| \<../../../web-admin/se          | > performing similar activities. |
| curity/rbac/roles\>] |                                  |
| Roles                            | For example, in a system storing |
|                                  | business                         |
|                                  | statistics and offering          |
|                                  | dashboards to browse them, there |
|                                  | could exist *Stats Submitter*    |
|                                  | and *Stats Reader*               |
|                                  | roles, each assigned to          |
|                                  | different client applications so |
|                                  | that one application can only    |
|                                  | save statistics                  |
|                                  | but can not view them, possibly  |
|                                  | because that would allow it to   |
|                                  | view statistics related to other |
|                                  | applications as well.            |
|                                  |                                  |
|                                  | Roles form hierarchies, all      |
|                                  | branching from the top-level     |
|                                  | *Root* role that can\'t be       |
|                                  | deleted nor renamed.             |
|                                  |                                  |
|                                  | Roles inherit permissions        |
|                                  | granted to their predecessors.   |
|                                  |                                  |
|                                  | *Root* role is not allowed to    |
|                                  | access anything, only user       |
|                                  | defined roles can be granted any |
|                                  | rights.                          |
+----------------------------------+----------------------------------+
| [Client roles                    | ping from client credentials to  |
| \<../../../web-admin/security/   | a role. One set of credentials   |
| rbac/client-roles\>] | may be assigned more than one    |
| A map                            | role.                            |
+----------------------------------+----------------------------------+
| [Permissions                     | ns client applications can       |
| \<../../../web-admin/security    | perform with HTTP channels. In   |
| /rbac/permissions\>] | Zato 2.0, the set of actions is  |
| Actio                            | fixed                            |
|                                  | and cannot be changed by users - |
|                                  | future versions will allow it.   |
|                                  |                                  |
|                                  | CRUD permissions are obtained    |
|                                  | from HTTP verbs as below:        |
|                                  |                                  |
|                                  | +                                |
|                                  | -------------+-----------------+ |
|                                  | |                                |
|                                  |  Permission  | HTTP verb(s)    | |
|                                  | +                                |
|                                  | =============+=================+ |
|                                  | |                                |
|                                  |  **C** reate | > POST          | |
|                                  | +                                |
|                                  | -------------+-----------------+ |
|                                  | |                                |
|                                  |  **R** ead   | > GET           | |
|                                  | +                                |
|                                  | -------------+-----------------+ |
|                                  | |                                |
|                                  |  **U** pdate | > PATCH and PUT | |
|                                  | +                                |
|                                  | -------------+-----------------+ |
|                                  | |                                |
|                                  |  **D** elete | > DELETE        | |
|                                  | +                                |
|                                  | -------------+-----------------+ |
+----------------------------------+----------------------------------+
| [Permissions for roles           | t of mappings telling Zato which |
| \<                               | roles have which permissions     |
| ../../../web-admin/security/rbac | against which services.          |
| /role-permissions\>] |                                  |
| A lis                            |                                  |
+----------------------------------+----------------------------------+
