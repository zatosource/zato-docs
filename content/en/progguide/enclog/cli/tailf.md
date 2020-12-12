---
title: enclog tailf
---

Opens a file with encrypted logs, waits for new log entries to be decrypted using
[a Fernet key](https://cryptography.io/en/latest/fernet/) provided on input and outputs them on screen as they arrive.

The command simulates *tailf -f* with decryption on fly.

If no key was provided, a prompt will be shown to specify it. The key will not be echoed.

Note that there is a companion command, [enclog open \<./open\>], which opens a log file and outputs its contents
on screen without waiting for new log entries to decrypt.

Usage
=====

    $ enclog tailf /path/to.log --key tfUWq8KpSJ6XHaYCGdX3Idf0m00hX4f_

    2015-12-08 19:18:12,914 - INFO - 7195:Dummy-112 - enclog:22 - Encrypted data
    2015-12-08 19:18:13,840 - INFO - 7194:Dummy-627 - enclog:22 - Encrypted data
    2015-12-08 19:18:14,691 - INFO - 7195:Dummy-113 - enclog:22 - Encrypted data
    2015-12-08 19:18:15,472 - INFO - 7195:Dummy-114 - enclog:22 - Encrypted data
    2015-12-08 19:18:33,089 - INFO - 7195:Dummy-116 - enclog:22 - Encrypted data
    2015-12-08 19:18:34,649 - INFO - 7194:Dummy-638 - enclog:22 - Encrypted data
    2015-12-08 19:19:04,222 - INFO - 7195:Dummy-118 - enclog:22 - Encrypted data

:

    $ enclog tailf ~/env/qs-1/server1/logs/encrypted.log
    Crypto key: 

    2015-12-08 19:18:12,914 - INFO - 7195:Dummy-112 - enclog:22 - Encrypted data
    2015-12-08 19:18:13,840 - INFO - 7194:Dummy-627 - enclog:22 - Encrypted data
    2015-12-08 19:18:14,691 - INFO - 7195:Dummy-113 - enclog:22 - Encrypted data
    2015-12-08 19:18:15,472 - INFO - 7195:Dummy-114 - enclog:22 - Encrypted data
    2015-12-08 19:18:33,089 - INFO - 7195:Dummy-116 - enclog:22 - Encrypted data
    2015-12-08 19:18:34,649 - INFO - 7194:Dummy-638 - enclog:22 - Encrypted data
    2015-12-08 19:19:04,222 - INFO - 7195:Dummy-118 - enclog:22 - Encrypted data
