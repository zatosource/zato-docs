---
title: Load-balancer\'s statistics
---

[HAProxy](http://haproxy.1wt.eu/), the underlying tool Zato\'s load-balancer is built on top of,
provides
[statistics](http://cbonte.github.io/haproxy-dconv/configuration-1.5.html#9)
regarding its current and historical state, which servers
are up, how many clients there are, what is the transfer rate and similar data.

Note that the link to statistics requires a username/password combination be set in
[the load-balancer\'s main config file \<admin-guide-config-lb-main\>].

![](/gfx/stats/lb-stats-link.png)

![](/gfx/stats/haproxy.png)

Please refer to
[HAProxy\'s docs](http://haproxy.1wt.eu/#docs) for more information regarding
how to use and interpret the stats.

Changelog
=========

  Version   Notes
  --------- -----------------
  1.0       Added initially
