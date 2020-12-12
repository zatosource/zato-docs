---
title: When the URL is invoked
---

Usage example
=============

    Feature: zato-apitest docs

    Scenario: Given address "{address}"

        Given address "http://apitest-demo.zato.io"
        Given URL path "/demo/json"
        Given format "JSON"

        When the URL is invoked

        Then status is "200"

Discussion
==========

-   The only `When` step
-   Should be placed between `Given` and `Then/And` steps
