---
title: "Then header \\\"{header}\\\" ends with {value}"
---

Usage example
=============

    Feature: zato-apitest docs

    Scenario: Then header "{header}" ends with {value}

        Given address "http://apitest-demo.zato.io"
        Given URL path "/demo/json"

        When the URL is invoked

        Then header "Date" ends with "GMT"

Discussion
==========

(None)
