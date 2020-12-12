---
title: Then header \"{header}\" doesn\'t exist
---

Usage example
=============

    Feature: zato-apitest docs

    Scenario: Then header "{header}" doesn't exist

        Given address "http://apitest-demo.zato.io"
        Given URL path "/demo/json"

        When the URL is invoked

        Then header "X-Invalid" doesn't exist

Discussion
==========

(None)
