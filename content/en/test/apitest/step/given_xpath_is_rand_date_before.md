---
title: Given XPath \"{xpath}\" in request is a random date before \"{date_end}\" \"{format}\"
---

Usage example
=============

    Feature: zato-apitest docs

    Scenario: Given XPath "{xpath}" in request is a random date before "{date_start}" "{format}"

        Given address "http://apitest-demo.zato.io"
        Given URL path "/demo/xml"
        Given format "XML"
        Given request is "<req><howdy>foo</howdy></req>"
        Given XPath "//howdy" in request is a random date before "2019-07-25" "default"

        When the URL is invoked

        Then status is "200"

Discussion
==========

-   The format \"default\" is always available. Its value is
    \"YYYY-MM-DDTHH:mm:ss\".
-   Use format \"YYYY-MM-DD\" to specify \"{date_end}\".
