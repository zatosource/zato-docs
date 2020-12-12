---
title: Logging out
---

-   Once [logged in \<./login\>], each user is given a UST - user session token, which uniquely identifies each session,
    similarly to how cookies identify HTTP-based sessions in web applications
-   To log a user out, invoke either a
    [REST \<../../api/rest/user/logout\>]
    or
    [Python \<../../api/python/user/logout\>]
    API providing the UST on input
-   The logout action makes the user log out of all applications - it is not possible to log out from a single application only
