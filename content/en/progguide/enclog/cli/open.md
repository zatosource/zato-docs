---
title: enclog open
---

Opens a file with encrypted logs and outputs it in its entirety on screen with log entries decrypted using
[a Fernet key](https://cryptography.io/en/latest/fernet/)
provided on input.

If no key was provided, a prompt will be shown to specify it. The key will not be echoed.

Note that there is a companion command, [enclog tailf \<./tailf\>], which opens a log file and displays new entries decrypted
as they are being added.

Usage
=====

    $ enclog open /path/to.log --key tfUWq8KpSJ6XHaYCGdX3Idf0m00hX4f_

    2015-12-08 19:18:12,914 - INFO - 7195:Dummy-112 - enclog:22 - Encrypted data
    2015-12-08 19:18:13,840 - INFO - 7194:Dummy-627 - enclog:22 - Encrypted data
    2015-12-08 19:18:14,691 - INFO - 7195:Dummy-113 - enclog:22 - Encrypted data
    2015-12-08 19:18:15,472 - INFO - 7195:Dummy-114 - enclog:22 - Encrypted data
    2015-12-08 19:18:33,089 - INFO - 7195:Dummy-116 - enclog:22 - Encrypted data
    2015-12-08 19:18:34,649 - INFO - 7194:Dummy-638 - enclog:22 - Encrypted data
    2015-12-08 19:19:04,222 - INFO - 7195:Dummy-118 - enclog:22 - Encrypted data

:

    $ enclog open ~/env/qs-1/server1/logs/encrypted.log
    Crypto key: 

    2015-12-08 19:18:12,914 - INFO - 7195:Dummy-112 - enclog:22 - Encrypted data
    2015-12-08 19:18:13,840 - INFO - 7194:Dummy-627 - enclog:22 - Encrypted data
    2015-12-08 19:18:14,691 - INFO - 7195:Dummy-113 - enclog:22 - Encrypted data
    2015-12-08 19:18:15,472 - INFO - 7195:Dummy-114 - enclog:22 - Encrypted data
    2015-12-08 19:18:33,089 - INFO - 7195:Dummy-116 - enclog:22 - Encrypted data
    2015-12-08 19:18:34,649 - INFO - 7194:Dummy-638 - enclog:22 - Encrypted data
    2015-12-08 19:19:04,222 - INFO - 7195:Dummy-118 - enclog:22 - Encrypted data
