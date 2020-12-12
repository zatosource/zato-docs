---
title: Status codes
---

Overview
========

All API calls, be it REST or Python ones, return status codes that may be additionally broken down into sub-statuses.

HTTP-level status codes are used only to signal 200 OK, 400 Bad request and 403 Forbidden - other HTTP status codes
are not used because SSO functionality, through its Python API, can be exposed via protocols that may not have
an intrinsic notion of status codes, e.g. ZeroMQ or WebSockets.

Note that in certain cases the publicly returned sub-status may be followed by more specific information in server logs.
For instance, a generic E005001 \'You are not allowed to access this resource\' may be accompanied by
E001001 \'Invalid username\' yet this message is not returned to the caller so as not to reveal too much information to
potential adversaries.

Each sub-status starts with a prefix, \'E\' indicates an error and \'W\' stands for a warning.

In Python, all of status codes can be access through \'from zato.sso import status_code\'.

Status codes {#status-codes-1}
============

  Name      Notes
  --------- ----------------------------------------------------------------------------------------------------------
  ok        Operation completed successfully, there is no error nor warning to report
  warning   Operation may have completed successfully but there was an issue to report, check sub-status for details
  error     Operation failed, check sub-status for details

Sub-status codes
================

  Code      Label                        Notes
  --------- ---------------------------- -------------------------------------------------------------------------------------------------
  E001001   username.invalid             Such a username does not exist in database
  E001002   username.exists              This username already exists - for instance, during user creation
  E001003   username.too_long            Username is longer than [configuration \<./config/index\>] allows it
  E001004   username.has_whitespace      Username contains whitespace
  E001100   user_id.invalid              Such a user ID does not exist in database
  E002001   email.invalid                Such an email does not exist in database
  E002002   email.exists                 This email already exists - for instance,
                                         during user creation if emails are required to be unique
  E002003   email.too_long               Email address is longer than [configuration \<./config/index\>] allows it
  E002004   email.has_whitespace         Email address contains whitespace
  E002005   email.missing                There was no email given on input yet one is required
  E003001   password.invalid             Password is invalid per rules defined in [configuration \<./config/index\>]
  E003002   password.too_short           Password is too short
  E003003   password.too_long            Password is too long
  E003004   password.expired             A call was issued using an account whose password has expired
                                         (e.g. in between login and this call)
  W003005   password.w_about_to_exp      A warning to indicate that the password is about to expire
  E003006   password.e_about_to_exp      Exactly as W003005 but returned as an error, per [configuration \<./config/index\>]
  E003007   password.must_send_new       Request was rejected, user must send a new password to set in place of current one
  E004001   app_list.invalid             Application name given on input was not found in [configuration \<./config/index\>]
  E004002   app_list.no_signup           Application name on input exists but it is not possible to log in from it,
                                         i.e. user must use another application to log in
  E005001   auth.not_allowed             A generic \'You are not allowed to access this resource\' message, may be supplemented by
                                         details in server log
  E005002   auth.locked                  Account is locked, cannot be used until unlocked
  E005003   auth.invalid_signup_status   Account cannot be used to log into because the signup process is not complete yet,
                                         e.g. the user has not confirmed it yet
  E005004   auth.not_approved            Account waits for approval from a super-admin, it is not possible to log in until
                                         it is approved
  E005005   auth.super_user_required     Super-user\'s privileges are required to carry out a given action but current user is not one
  E005006   auth.no_such_sign_up_token   Signup token given on input does not exist
  E005007   auth.sign_up_confirmed       An attempt to confirm a signup process was made using a token that has been already used once
  E006001   metadata.not_allowed         Current application that the user is logging in from is not allowed to send login metadata,
                                         such as remote_addr and user_agent
  E007001   session.no_such_session      Input user session token UST was invalid - either does not exist or the session expired
  E007002   session.expired              The session pointed to by input UST exists but has already expired
  E008001   common.invalid_operation     The requested operation is invalid, e.g. a user attempts to delete his or her own account
  E008002   common.invalid_input         At least one of values given on input was not valid
  E008003   common.missing_input         A value was expected on input but it was not provided by the caller
  E008004   common.internal_error        An internal error has occurred, check server logs for details
  E009001   attr.already_exists          An attempt was made to create an attribute of a name that already exists
  E009002   attr.no_such_attr            An attempt was made to access an attribute of a name that does not exist
                                         (applies to all of .get, .update and .delete)
