---
title: Exposing service definitions to third parties
---

Using the public API specification service in Zato 3.0, it is possible to
expose your service definitions to a third party (non-administrative) users
in order to simplify their ability to develop against those services.

After creating or upgrading a Zato 3.0 cluster, several plain HTTP channels
are automatically created to enable easy access to API documentation via the
cluster\'s public network endpoint.

The service will be exposed by the cluster\'s load balancer at
`http://loadbalancer:11223/zato/apispec`.

Authentication
==============

The service is configured to use [Role-based Access Control
\</admin/guide/rbac/overview\>], allowing many sets of user credentials to be
granted access, simply by associating new credentials with a predefined RBAC
role.

For convenience, a single `apispec` credential is created by default with a
randomly assigned password. The most straightforward way to access the service
is by resetting the password for this credential using the web interface.

Restricting what the service exposes {#restricting_apispec}
====================================

The list of documented services can be restricted by updating the
`[apispec_services_allowed]` stanza in `server.conf`. By default, only
Zato-internal services are exposed.

Granting third party access
===========================

To grant a third party access to the service, a
[HTTP Basic Auth credential \</web-admin/security/basic-auth\>] must be
created for the third party, and that credential must be associated with the
API specification service\'s [RBAC role \</admin/guide/rbac/overview\>].

Update the cluster configuration
--------------------------------

Prior to granting a third party access to the API specification service,
ensure that you have first [exposed the desired services
\<restricting_apispec\>].

Create a HTTP Basic Auth credential
-----------------------------------

Use the [HTTP Basic Auth \</web-admin/security/basic-auth\>] section in
the Zato web administration tool to create a new credential for the user:

![image](/gfx/progguide-apispec-create-cred.png)

Reset the credential\'s password
--------------------------------

Assign a password to the new credential by selecting the **Change Password**
option:

![image](/gfx/progguide-apispec-reset-password.png)

Associate the credential with the RBAC role
-------------------------------------------

Use the [RBAC Client Roles \</web-admin/security/basic-auth\>] section in
the Zato web administration tool to associate the credential with the **API
Specification Readers** RBAC role:

![image](/gfx/progguide-apispec-rbac-role.png)
