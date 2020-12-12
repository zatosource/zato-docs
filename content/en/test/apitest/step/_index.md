---
title: Default test steps and assertions
---

+---------+-------+----------------+----------------+----------------+
| Section | Part  | Pattern        | Notes          | Details        |
+=========+=======+================+================+================+
| HTTP    | Given | address        | An address of  | [Details       |
| HTTP    | Given | \"{address}\"  | the API to     | \<./           |
|         |       | Basic Auth     | invoke         | given_address\ |
|         |       | \"{username}\" |                | >] |
|         |       | \"{password}\" |                | [Details       |
|         |       |                |                | \<./giv        |
|         |       |                |                | en_basic_auth\ |
|         |       |                |                | >] |
+---------+-------+----------------+----------------+----------------+
| HTTP    | Given | URL path       | URL path to    | [Details       |
|         |       | \"{url_path}\" | invoke         | \<./g          |
|         |       |                |                | iven_url_path\ |
|         |       |                |                | >] |
+---------+-------+----------------+----------------+----------------+
| HTTP    | Given | HTTP method    | HTTP method to | [Details       |
|         |       | \"{method}\"   | use for        | \<./give       |
|         |       |                | invoking       | n_http_method\ |
|         |       |                |                | >] |
+---------+-------+----------------+----------------+----------------+
| HTTP    | Given | Request file   | Specifies the  | [Details       |
|         |       | \"{name}\" is  | path to a file | \<./g          |
|         |       | \"{value}\"    | upload,        | iven_file_uplo |
|         |       |                | relative to    | ad_in_request\ |
|         |       |                | the            | >] |
|         |       |                | ./feature      |                |
|         |       |                | s/form/request |                |
|         |       |                | directory.     |                |
|         |       |                | This will send |                |
|         |       |                | the request    |                |
|         |       |                | with http      |                |
|         |       |                | header         |                |
|         |       |                | Content-Type:  |                |
|         |       |                | multip         |                |
|         |       |                | art/form-data; |                |
|         |       |                | boundary=XXX   |                |
+---------+-------+----------------+----------------+----------------+
| HTTP    | Given | Request param  | This will send | [Details       |
|         |       | \"{name}\" is  | the request    | \<./given_f    |
|         |       | \"{value}\"    | with HTTP      | orm_encoded_da |
|         |       |                | header         | ta_in_request\ |
|         |       |                | Content-Type:  | >] |
|         |       |                | appli          |                |
|         |       |                | cation/x-www-f |                |
|         |       |                | orm-urlencoded |                |
+---------+-------+----------------+----------------+----------------+
| HTTP    | Given | format         | Either         | [Details       |
|         |       | \"{format}\"   | \'JSON\' or    | \<.            |
|         |       |                | \'XML\'        | /given_format\ |
|         |       |                |                | >] |
+---------+-------+----------------+----------------+----------------+
| HTTP    | Given | user agent is  | User-Agent     | [Details       |
|         |       | \"{value}\"    | string to use  | \<./given_     |
|         |       |                |                | user_agent_is\ |
|         |       |                |                | >] |
+---------+-------+----------------+----------------+----------------+
| HTTP    | Given | header         | Arbitrary HTTP | [Details       |
| HTTP    | Given | \"{header}\"   | header to      | \<.            |
|         |       | \"{value}\"    | provide to the | /given_header\ |
|         |       | request        | API            | >] |
|         |       | \"{r           | Name of a file |                |
|         |       | equest_path}\" | the request is | [Details       |
|         |       |                | kept in.       | \<./           |
|         |       |                | Depending on   | given_request\ |
|         |       |                | format,        | >] |
|         |       |                | either         |                |
|         |       |                | `./features    |                |
|         |       |                | /json/request` |                |
|         |       |                | or             |                |
|         |       |                | `./feature     |                |
|         |       |                | s/xml/request` |                |
|         |       |                | will be        |                |
|         |       |                | prepended      |                |
|         |       |                | automatically. |                |
+---------+-------+----------------+----------------+----------------+
| HTTP    | Given | request is     | Request to     | [Details       |
| HTTP    | Given | \"{data}\"     | use, inlined.  | \<./giv        |
|         |       | query string   | Query string   | en_request_is\ |
| Common  | Given | \"{q           | parameters in  | >] |
|         |       | uery_string}\" | format of      |                |
| Common  | Given |                | ?a=1&b=2,      | [Details       |
|         |       | date format    | including the  | \<./given      |
|         |       | \"{name}\"     | question mark  | _query_string\ |
|         |       | \"{format}\"   | Stores a date  | >] |
|         |       |                | format         |                |
|         |       | I store        | `format` under | [Details       |
|         |       | \"{value}\"    | a label        | \<./give       |
|         |       | under          | `name` for use | n_date_format\ |
|         |       | \"{name}\"     | in later       | >] |
|         |       |                | assertions     |                |
|         |       |                | Stores an      | [Details       |
|         |       |                | arbitrary      | \<./give       |
|         |       |                | `value` under  | n_i\_store_val |
|         |       |                | a `name`       | ue_under_name\ |
|         |       |                | for use in     | >] |
|         |       |                | later          |                |
|         |       |                | assertions     |                |
+---------+-------+----------------+----------------+----------------+
| JSON    | Given | JSON Pointer   | Sets `path` to | [Details       |
|         |       | \"{path}\" in  | a string       | \<./given      |
|         |       | request is     | `value` in the | _json_pointer_ |
|         |       | \"{value}\"    | request        | in_request_is\ |
|         |       |                |                | >] |
+---------+-------+----------------+----------------+----------------+
| JSON    | Given | JSON Pointer   | Sets `path` to | [Details       |
|         |       | \"{path}\" in  | an integer     | \<./gi         |
|         |       | request is an  | `value` in the | ven_json_point |
|         |       | integer        | request        | er_in_request_ |
|         |       | \"{value}\"    |                | is_an_integer\ |
|         |       |                |                | >] |
+---------+-------+----------------+----------------+----------------+
| JSON    | Given | JSON Pointer   | Sets `path` to | [Details       |
|         |       | \"{path}\" in  | a float        | \<./           |
|         |       | request is a   | `value` in the | given_json_poi |
|         |       | float          | request        | nter_in_reques |
|         |       | \"{value}\"    |                | t_is_a\_float\ |
|         |       |                |                | >] |
+---------+-------+----------------+----------------+----------------+
| JSON    | Given | JSON Pointer   | Sets `path` to | [Details       |
|         |       | \"{path}\" in  | a list `value` | \<.            |
|         |       | request is a   | in the request | /given_json_po |
|         |       | list           |                | inter_in_reque |
|         |       | \"{value}\"    |                | st_is_a\_list\ |
|         |       |                |                | >] |
+---------+-------+----------------+----------------+----------------+
| JSON    | Given | JSON Pointer   | Sets `path` to | [Details       |
|         |       | \"{path}\" in  | a randomly     | \<./given_js   |
|         |       | request is a   | generated      | on_pointer_in_ |
|         |       | random string  | string in the  | request_is_a\_ |
|         |       |                | request        | random_string\ |
|         |       |                |                | >] |
+---------+-------+----------------+----------------+----------------+
| JSON    | Given | JSON Pointer   | Sets `path` to | [Details       |
|         |       | \"{path}\" in  | a randomly     | \<./given_jso  |
|         |       | request is a   | generated      | n_pointer_in_r |
|         |       | random integer | integer in the | equest_is_a\_r |
|         |       |                | request        | andom_integer\ |
|         |       |                |                | >] |
+---------+-------+----------------+----------------+----------------+
| JSON    | Given | JSON Pointer   | Sets `path` to | [Details       |
| JSON    | Given | \"{path}\" in  | a randomly     | \<./given_j    |
|         |       | request is a   | generated      | son_pointer_in |
| JSON    | Given | random float   | float in the   | _request_is_a\ |
|         |       | JSON Pointer   | request        | _random_float\ |
| JSON    | Given | \"{path}\" in  | Sets `path` to | >] |
|         |       | request is one | a randomly     |                |
| JSON    | Given | of \"{value}\" | chosen string  | [Details       |
|         |       |                | out of `value` | \<             |
| JSON    | Given | JSON Pointer   | in the request | ./given_json_p |
|         |       | \"{path}\" in  | Sets `path` to | ointer_in_requ |
|         |       | request is a   | a randomly     | est_is_one_of\ |
|         |       | random date    | generated date | >] |
|         |       | \"{format}\"   | using format   |                |
|         |       |                | `format`       | [Details       |
|         |       | JSON Pointer   |                | \<./give       |
|         |       | \"{path}\" in  | Sets `path` to | n_json_pointer |
|         |       | request is a   | now in local   | _is_rand_date\ |
|         |       | random date    | timezone,      | >] |
|         |       | after          | using format   | [Details       |
|         |       | \"             | `format`       | \<./given_json |
|         |       | {date_start}\" |                | _pointer_is_ra |
|         |       | \"{format}\"   |                | nd_date_after\ |
|         |       | JSON Pointer   |                | >] |
|         |       | \"{path}\" in  |                |                |
|         |       | request is a   |                | [Details       |
|         |       | random date    |                | \              |
|         |       | before         |                | <./given_json_ |
|         |       | \"{date_end}\" |                | pointer_is_ran |
|         |       | \"{format}\"   |                | d_date_before\ |
|         |       | JSON Pointer   |                | >] |
|         |       | \"{path}\" in  |                |                |
|         |       | request is now |                | [Details       |
|         |       | \"{format}\"   |                | \<             |
|         |       |                |                | ./given_json_p |
|         |       |                |                | ointer_is_now\ |
|         |       |                |                | >] |
+---------+-------+----------------+----------------+----------------+
| JSON    | Given | JSON Pointer   | Sets `path` to | [Details       |
| JSON    | Given | \"{path}\" in  | now in UTC,    | \<./gi         |
|         |       | request is UTC | using format   | ven_json_point |
| XML     | Given | now            | `format`       | er_is_utc_now\ |
|         |       | \"{format}\"   | Sets `path` to | >] |
|         |       | JSON Pointer   | a randomly     |                |
|         |       | \"{path}\" in  | generated date | [Details       |
|         |       | request is a   | between        | \<             |
|         |       | random date    | `date_start`   | ./given_json_p |
|         |       | between        | and            | ointer_is_rand |
|         |       | \"             | `date_end`,    | _date_between\ |
|         |       | {date_start}\" | using format   | >] |
|         |       | and            | `format`       |                |
|         |       | \"{date_end}\" | For the        | [Details       |
|         |       | \"{format}\"   | duration of    | \<./given_nam  |
|         |       |                | the test,      | espace_prefix\ |
|         |       | namespace      | stores         | >] |
|         |       | prefix         | `prefix`       |                |
|         |       | \"{prefix}\"   | of a           |                |
|         |       | of             | `namespace` to |                |
|         |       | \              | be used in     |                |
|         |       | "{namespace}\" | XPath          |                |
|         |       |                | expressions    |                |
+---------+-------+----------------+----------------+----------------+
| XML     | Given | SOAP action    | Sets a         | [Details       |
|         |       | \"{value}\"    | request\'s     | \<./give       |
|         |       |                | SOAPaction     | n_soap_action\ |
|         |       |                | header, if     | >] |
|         |       |                | needed         |                |
+---------+-------+----------------+----------------+----------------+
| XML     | Given | XPath          | Sets `xpath`   | [Details       |
|         |       | \"{xpath}\" in | to a string    | \<             |
|         |       | request is     | `value` in the | ./given_xpath_ |
|         |       | \"{value}\"    | request        | in_request_is\ |
|         |       |                |                | >] |
+---------+-------+----------------+----------------+----------------+
| XML     | Given | XPath          | Sets `xpath`   | [Details       |
|         |       | \"{xpath}\" in | to a randomly  | \<./giv        |
|         |       | request is a   | generated      | en_xpath_set_t |
|         |       | random string  | string in the  | o_rand_string\ |
|         |       |                | request        | >] |
+---------+-------+----------------+----------------+----------------+
| XML     | Given | XPath          | Sets `xpath`   | [Details       |
|         |       | \"{xpath}\" in | to a randomly  | \<./           |
|         |       | request is a   | generated      | given_xpath_se |
|         |       | random integer | integer in the | t_to_rand_int\ |
|         |       |                | request        | >] |
+---------+-------+----------------+----------------+----------------+
| XML     | Given | XPath          | Sets `xpath`   | [Details       |
| XML     | Given | \"{xpath}\" in | to a randomly  | \<./gi         |
|         |       | request is a   | generated      | ven_xpath_set_ |
| XML     | Given | random float   | float in the   | to_rand_float\ |
|         |       | XPath          | request        | >] |
|         |       | \"{xpath}\" in | Sets `xpath`   |                |
|         |       | request is a   | to a randomly  | [Details       |
|         |       | random date    | generated date | \              |
|         |       | \"{format}\"   | using format   | <./given_xpath |
|         |       |                | `format`       | _is_rand_date\ |
|         |       | XPath          | Sets `xpath`   | >] |
|         |       | \"{xpath}\" in | to now in      |                |
|         |       | request is now | local          | [Details       |
|         |       | \"{format}\"   | timezone,      | \<./given      |
|         |       |                | using format   | _xpath_is_now\ |
|         |       |                | `format`       | >] |
+---------+-------+----------------+----------------+----------------+
| XML     | Given | XPath          | Sets `xpath`   | [Details       |
| XML     | Given | \"{xpath}\" in | to now in UTC, | \<./given_xpa  |
|         |       | request is UTC | using format   | th_is_utc_now\ |
| XML     | Given | now            | `format`       | >] |
|         |       | \"{format}\"   |                |                |
| XML     | Given | XPath          | Sets `xpath`   | [Details       |
|         |       | \"{xpath}\" in | to a randomly  | \<./giv        |
| XML     | Given | request is a   | generated date | en_xpath_is_ra |
|         |       | random date    | after          | nd_date_after\ |
|         |       | after          | `date_start`,  | >] |
|         |       | \"             | using format   | [Details       |
|         |       | {date_start}\" | `format`       | \<./give       |
|         |       | \"{format}\"   |                | n_xpath_is_ran |
|         |       |                | Sets `xpath`   | d_date_before\ |
|         |       | XPath          | to a randomly  | >] |
|         |       | \"{xpath}\" in | generated date |                |
|         |       | request is a   | between        | [Details       |
|         |       | random date    | `date_start`   | \<./given      |
|         |       | before         | and            | _xpath_is_rand |
|         |       | \"{date_end}\" | `date_end`,    | _date_between\ |
|         |       | \"{format}\"   | using format   | >] |
|         |       | XPath          | `format`       |                |
|         |       | \"{xpath}\" in | Sets `xpath`   | [Details       |
|         |       | request is a   | to a randomly  | \<             |
|         |       | random date    | chosen string  | ./given_xpath_ |
|         |       | between        | out of `value` | set_to_one_of\ |
|         |       | \"             | in the request | >] |
|         |       | {date_start}\" |                |                |
|         |       | and            |                |                |
|         |       | \"{date_end}\" |                |                |
|         |       | \"{format}\"   |                |                |
|         |       |                |                |                |
|         |       | XPath          |                |                |
|         |       | \"{xpath}\" in |                |                |
|         |       | request is one |                |                |
|         |       | of \"{value}\" |                |                |
+---------+-------+----------------+----------------+----------------+
| HTTP    | When  | the URL is     | Invokes the    | [Details       |
|         |       | invoked        | HTTP-based API | \<./when_the_u |
|         |       |                | under test     | rl_is_invoked\ |
|         |       |                |                | >] |
+---------+-------+----------------+----------------+----------------+
| HTTP    | Then  | status is      | Asserts that   | [Details       |
| HTTP    | Then  | \"{status}\"   | the HTTP       | \<./t          |
|         |       | context is     | status code in | hen_status_is\ |
|         |       | cleaned up     | response is    | >] |
|         |       |                | `status`       | [Details       |
|         |       |                |                | \<.            |
|         |       |                | Cleans up any  | /then_context_ |
|         |       |                | sce            | is_cleaned_up\ |
|         |       |                | nario-specific | >] |
|         |       |                | data, such as  |                |
|         |       |                | namespaces or  |                |
|         |       |                | date formats.  |                |
|         |       |                | Without it,    |                |
|         |       |                | they are       |                |
|         |       |                | carried over   |                |
|         |       |                | to             |                |
|         |       |                | subsequent     |                |
|         |       |                | scenarios      |                |
+---------+-------+----------------+----------------+----------------+
| HTTP    | Then  | header         | Asserts that a | [Details       |
| HTTP    | Then  | \"{header}\"   | `header`       | \<./t          |
|         |       | is \"{value}\" | exists and has | hen_header_is\ |
| HTTP    | Then  | header         | value `value`  | >] |
|         |       | \"{header}\"   | Asserts that a |                |
| HTTP    | Then  | isn\'t         | `header`       | [Details       |
|         |       | \"{value}\"    | exists and     | \<./the        |
|         |       |                | doesn\'t have  | n_header_isnt\ |
|         |       | header         | value `value`  | >] |
|         |       | \"{header}\"   | Asserts that a |                |
|         |       | contains       | `header`       | [Details       |
|         |       | \"{value}\"    | exists and     | \<./then_he    |
|         |       |                | contains       | ader_contains\ |
|         |       | header         | substring      | >] |
|         |       | \"{header}\"   | `value`        |                |
|         |       | doesn\'t       | Asserts that a | [Details       |
|         |       | contain        | `header`       | \<.            |
|         |       | {value}\"      | exists and     | /then_header_d |
|         |       |                | doesn\'t       | oesnt_contain\ |
|         |       |                | contain        | >] |
|         |       |                | substring      |                |
|         |       |                | `value`        |                |
+---------+-------+----------------+----------------+----------------+
| HTTP    | Then  | header         | Asserts that a | [Details       |
|         |       | \"{header}\"   | `header`       | \<./then_      |
|         |       | exists         | exists,        | header_exists\ |
|         |       |                | regardless of  | >] |
|         |       |                | its value      |                |
+---------+-------+----------------+----------------+----------------+
| HTTP    | Then  | header         | Asserts that a | [Details       |
|         |       | \"{header}\"   | `header`       | \              |
|         |       | doesn\'t exist | doesn\'t exist | <./then_header |
|         |       |                |                | _doesnt_exist\ |
|         |       |                |                | >] |
+---------+-------+----------------+----------------+----------------+
| HTTP    | Then  | header         | Asserts that a | [Details       |
|         |       | \"{header}\"   | `header`       | \<./then_he    |
|         |       | is empty       | exists and is  | ader_is_empty\ |
|         |       |                | an empty       | >] |
|         |       |                | string         |                |
+---------+-------+----------------+----------------+----------------+
| HTTP    | Then  | header         | Asserts that a | [Details       |
| HTTP    | Then  | \"{header}\"   | `header`       | \<./then_head  |
|         |       | isn\'t empty   | exists and is  | er_isnt_empty\ |
| HTTP    | Then  | header         | any non-empty  | >] |
|         |       | \"{header}\"   | string         |                |
| HTTP    | Then  | starts with    | Asserts that a | [Details       |
|         |       | \"{value}\"    | `header`       | \<./then_heade |
| HTTP    | Then  |                | exists and     | r_starts_with\ |
|         |       | header         | starts         | >] |
| TODO    | Then  | \"{header}\"   | with substring |                |
|         |       | doesn\'t start | `value`        | [Details       |
| TODO    | Then  | with {value}\" | Asserts that a | \<./th         |
|         |       |                | `header`       | en_header_does |
| JSON    | Then  | header         | exists and     | nt_start_with\ |
| JSON    | Then  | \"{header}\"   | doesn\'t start | >] |
| JSON    | Then  | ends with      | with substring |                |
| JSON    | Then  | \"{value}\"    | `value`        | [Details       |
| JSON    | Then  |                | Asserts that a | \<./then_hea   |
| JSON    | Then  | header         | `header`       | der_ends_with\ |
| JSON    | Then  | \"{header}\"   | exists and     | >] |
| JSON    | Then  | doesn\'t end   | ends           |                |
| JSON    | Then  | with           | with substring | [Details       |
| JSON    | Then  | \"{value}\"    | `value`        | \<./           |
| HTTP    | Then  |                | Asserts that a | then_header_do |
| HTTP    | Then  | I store        | `header`       | esnt_end_with\ |
| XML     | Then  | \"{path}\"     | exists and     | >] |
| XML     | Then  | from response  | doesn\'t end   |                |
| XML     | Then  | under          | with substring | [Details       |
| XML     | Then  | \"{name}\"     | `value`        | \<./th         |
| XML     | Then  |                |                | en_i\_store_pa |
| XML     | Then  | I store        | Stores values  | th_under_name\ |
| XML     | Then  | \"{path}\"     | of paths,      | >] |
|         |       | from response  | either JSON    |                |
|         |       | under          | Pointers or    | [Details       |
|         |       | \"{name}\",    | XPath, under   | \<./t          |
|         |       | default        | labels, for    | hen_i\_store_p |
|         |       | \"{default}\"  | the duration   | ath_under_name |
|         |       |                | of a single    | _with_default\ |
|         |       | JSON Pointer   | test case      | >] |
|         |       | \"{path}\"     | (feature)      | [Details       |
|         |       | contains       |                | \<.            |
|         |       | \"{value}\"    | Stores values  | /then_json_poi |
|         |       | JSON Pointer   | of paths,      | nter_contains\ |
|         |       | \"{path}\"     | either JSON    | >] |
|         |       | contains data  | Pointers or    | [Details       |
|         |       | from           | XPath, under   | \<./then_json  |
|         |       | \"{path}\"     | labels, for    | _pointer_conta |
|         |       | JSON Pointer   | the duration   | ins_data_from\ |
|         |       | \"{path}\" is  | of a single    | >] |
|         |       | \"{value}\"    | test case      | [Details       |
|         |       | JSON Pointer   | (feature). A   | \<./then_js    |
|         |       | \"{path}\" is  | default value  | on_pointer_is\ |
|         |       | a float        | will be used   | >] |
|         |       | \"{value}\"    | if the         | [Details       |
|         |       | JSON Pointer   | response       | \<./th         |
|         |       | \"{path}\" is  | doesn\'t       | en_json_pointe |
|         |       | a list         | contain        | r_is_a\_float\ |
|         |       | \"{value}\"    | a path         | >] |
|         |       | JSON Pointer   | provided       | [Details       |
|         |       | \"{path}\" is  |                | \<./t          |
|         |       | an integer     |                | hen_json_point |
|         |       | \"{value}\"    |                | er_is_a\_list\ |
|         |       | JSON Pointer   |                | >] |
|         |       | \"{path}\" is  |                | [Details       |
|         |       | empty          |                | \<./then       |
|         |       | JSON Pointer   |                | _json_pointer_ |
|         |       | \"{path}\" is  |                | is_an_integer\ |
|         |       | one of         |                | >] |
|         |       | \"{value}\"    |                | [Details       |
|         |       | JSON Pointer   |                | \<.            |
|         |       | \"{path}\"     |                | /then_json_poi |
|         |       | isn\'t empty   |                | nter_is_empty\ |
|         |       | JSON Pointer   |                | >] |
|         |       | \"{path}\"     |                | [Details       |
|         |       | isn\'t one of  |                | \<./           |
|         |       | \"{value}\"    |                | then_json_poin |
|         |       | response is    |                | ter_is_one_of\ |
|         |       | equal to       |                | >] |
|         |       | \"{expected}\" |                | [Details       |
|         |       | response is    |                | \<./t          |
|         |       | equal to that  |                | hen_json_point |
|         |       | from           |                | er_isnt_empty\ |
|         |       | \"{path}\"     |                | >] |
|         |       | XPath          |                | [Details       |
|         |       | \"{xpath}\" is |                | \<./th         |
|         |       | \"{value}\"    |                | en_json_pointe |
|         |       | XPath          |                | r_isnt_one_of\ |
|         |       | \"{xpath}\" is |                | >] |
|         |       | a float        |                | [Details       |
|         |       | \"{value}\"    |                | \<             |
|         |       | XPath          |                | ./then_respons |
|         |       | \"{xpath}\" is |                | e_is_equal_to\ |
|         |       | an integer     |                | >] |
|         |       | \"{value}\"    |                | [Details       |
|         |       | XPath          |                | \<./then_res   |
|         |       | \"{xpath}\" is |                | ponse_is_equal |
|         |       | empty          |                | _to_that_from\ |
|         |       | XPath          |                | >] |
|         |       | \"{xpath}\" is |                | [Details       |
|         |       | not empty      |                | \<./           |
|         |       | XPath          |                | then_xpath_is\ |
|         |       | \"{xpath}\"    |                | >] |
|         |       | isn\'t one of  |                | [Details       |
|         |       | \"{value}\"    |                | \<./then_xpat  |
|         |       | XPath          |                | h_is_a\_float\ |
|         |       | \"{xpath}\" is |                | >] |
|         |       | one of         |                | [Details       |
|         |       | \"{value}\"    |                | \              |
|         |       |                |                | <./then_xpath_ |
|         |       |                |                | is_an_integer\ |
|         |       |                |                | >] |
|         |       |                |                | [Details       |
|         |       |                |                | \<./then_x     |
|         |       |                |                | path_is_empty\ |
|         |       |                |                | >] |
|         |       |                |                | [Details       |
|         |       |                |                | \<./then_xpath |
|         |       |                |                | _is_not_empty\ |
|         |       |                |                | >] |
|         |       |                |                | [Details       |
|         |       |                |                | \              |
|         |       |                |                | <./then_xpath_ |
|         |       |                |                | is_not_one_of\ |
|         |       |                |                | >] |
|         |       |                |                | [Details       |
|         |       |                |                | \<./then_xp    |
|         |       |                |                | ath_is_one_of\ |
|         |       |                |                | >] |
+---------+-------+----------------+----------------+----------------+
