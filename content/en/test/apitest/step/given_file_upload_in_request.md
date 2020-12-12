---
title: Given Request file \"{name}\" is \"{value}\"
---

Usage example
=============

    Feature: zato-apitest docs

    Scenario: Given Request file "{name}" is "{value}"

        Given address "http://apitest-demo.zato.io"
        Given URL path "/demo/post"
        Given HTTP method "POST"
        Given format "FORM"
        Given Request file "report" is "report.xls"

        When the URL is invoked

        Then status is "200"

Discussion
==========

Specifies the path to a file upload, relative to the
./features/form/request directory. This will send the request with http
header Content-Type: multipart/form-data; boundary=XXX
