---
title: Then header \"{header}\" isn\'t empty
---

Usage example
=============

    Feature: zato-apitest docs

    Scenario: Then header "{header}" isn't empty

        Given address "http://apitest-demo.zato.io"
        Given URL path "/demo/json"

        When the URL is invoked

        Then header "Content-Type" isn't empty

Discussion
==========

(None)
