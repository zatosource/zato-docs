---
title: Cryptography
---

Zato has APIs for safe, sound and strong cryptographical operations, including encryption, decryption,
hashing and generation of passwords or other secrets.

The functionality offers a productive approach, suitable for direct use in one\'s applications, without a need for choosing
low-level crypto primitives. Everything has sound defaults and is ready for immediate employment.

Note that in addition to crypto functions below, Zato also comes with a dedicated
Single Sign-On and user managemenent API, documented in its own [chapter \<../../sso/index\>].

+----------------------------------+----------------------------------+
| Topic                            | Sample usage and notes           |
+==================================+==================================+
| [Encryption and decryption       | ring se                          |
| \<./encrypt\>] \*    | nsitive information in databases |
| Sto                              |                                  |
|                                  | :   (PII, PCI, HIPAA, EU GDPR)   |
|                                  |                                  |
|                                  | -   Sharing of sensitive         |
|                                  |     information with untrusted   |
|                                  |     parties                      |
|                                  | -   If used for storing user     |
|                                  |     passwords, admins will be    |
|                                  |     able                         |
|                                  |     to reveal them - use         |
|                                  |     [hashing                     |
|                                  |     \<./hash\>]      |
|                                  |     instead                      |
+----------------------------------+----------------------------------+
| [Generation of passwords and     | orcement of strong passwords     |
| secrets                          | among users                      |
| \<./generate\>] \*   | \* Generation of strong random   |
| Enf                              | values, safe for use in URLs     |
|                                  | \* API tokens                    |
|                                  | \* Data to be used once only     |
|                                  | (e.g. account creation           |
|                                  | confirmation)                    |
+----------------------------------+----------------------------------+
| [Hashing \<./hash\>] | e storage and ver                |
| \* Saf                           | ification of one\'s knowledge of |
|                                  |                                  |
|                                  | :   previously stored secrets,   |
|                                  |     typically passwords or other |
|                                  |     access tokens                |
+----------------------------------+----------------------------------+
