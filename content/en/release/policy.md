---
title: Zato release life-cycle policy
---

[Zato Source](https://zato.io) offers a predictable release model designed to ensure both frequent delivery of new functionality
as well as minimization of change between major releases.

Each major Zato release is published at the end of June, each year. June was chosen to make sure that Zato is compatible with
latest LTS April Ubuntu releases.

Each major release receives 1 year of free support and at least 2 years of [commercial support](https://zato.io/support.html).

A major release is distributed as a binary package or image for Docker, RHEL/CentOS, Ubuntu and Debian.

As long as a given major release is supported, it periodically [receives \<../admin/guide/install/update\>] stability
or security fixes and new enhancements to functionality. All such changes are always backwards-compatible within
the same major release and are supported until the end of support for their major release.

Upgrades between major releases may be potentially backwards-incompatible.

Support for a particular operating system may be dropped at any time if the system\'s vendor no longer supports it or if Python
developers no longer support core packaging tools on such a system (pip and related).

Note that commercial support contracts can always tailor the life-cycle policy for specific needs, including
creation of packages at any time or support extending to as many years as required
- contact <support@zato.io> for more information.

Key dates for Zato 3.1:

  Release date   Free support until   Commercial support until
  -------------- -------------------- --------------------------
  2019-06-18     2020-06-18           2021-06-18 (at least)
