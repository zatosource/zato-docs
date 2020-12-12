---
title: Given JSON Pointer \"{path}\" in request is a random date before \"{date_end}\" \"{format}\"
---

Usage example
=============

    Feature: zato-apitest docs

    Scenario: Given JSON Pointer "{path}" in request is a random date before "{date_end}" "{format}"

        Given address "http://apitest-demo.zato.io"
        Given URL path "/demo/json"
        Given format "JSON"
        Given request is "{}"
        Given JSON Pointer "/a" in request is a random date before "2019-11-27" "default"

        When the URL is invoked

        Then status is "200"

Discussion
==========

-   The format \"default\" is always available. Its value is
    \"YYYY-MM-DDTHH:mm:ss\".
-   Use format \"YYYY-MM-DD\" to specify \"{date_end}\".