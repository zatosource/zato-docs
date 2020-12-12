---
title: Given header \"{header}\" \"{value}\"
---

Usage example
=============

    Feature: zato-apitest docs

    Scenario: Given header "{header}" "{value}"

        Given address "http://apitest-demo.zato.io"
        Given URL path "/demo/json"
        Given format "JSON"
        Given header "X-My-Header" "MyValue"

        When the URL is invoked

        Then status is "200"

Discussion
==========

(None)
