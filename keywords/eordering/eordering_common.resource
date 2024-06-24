*** Keywords ***
Close cookie popup
    BuiltIn.Run keyword and ignore error    common.Click element when ready    ${EORDERING_COMMON.LOGIN.BUTTON}

Connect to SCG-Ordering database via SSH
    [Arguments]     ${db_api_module_name}=${DATABASES['DB_API_MODULE_NAME']}
    ...         ${db_name}=${DATABASES['DB_NAME']}
    ...         ${db_user}=${DATABASES['DB_USER']}
    ...         ${db_pass}=${DATABASES['DB_PASS']}
    ...         ${db_host}=${DATABASES['DB_HOST']}
    ...         ${db_port}=${DATABASES['DB_PORT']}
    ...         ${ssh_host}=${DATABASES['SSH_HOST']}
    ...         ${ssh_local_host}=${DATABASES['SSH_LOCAL_HOST']}
    ...         ${ssh_local_port}=${DATABASES['SSH_LOCAL_PORT']}
    ...         ${ssh_username}=${DATABASES['SSH_USERNAME']}
    ...         ${ssh_key_file}=${CURDIR}${/}..${/}..${/}resources${/}db${/}${DATABASES['SSH_KEY_FILE']}
    ...         ${retry}=3x
    ...         ${retry_interval}=5s

    SSHLibrary.Open Connection    ${ssh_host}
    SSHLibrary.Login with public key     username=${ssh_username}   keyfile=${ssh_key_file}    delay=1
    ${is_port_opened}=  BuiltIn.Run keyword and return status    SSHLibrary.Create local SSH tunnel    ${ssh_local_port}    ${db_host}    ${db_port}
    IF  not(${is_port_opened})
        BuiltIn.Wait Until Keyword Succeeds     ${retry}    ${retry_interval}    SSHLibrary.Create local SSH tunnel    ${ssh_local_port}    ${db_host}    ${db_port}
    END

    DatabaseLibrary.Connect to database        dbapiModuleName=${db_api_module_name}
    ...         dbName=${db_name}
    ...         dbUsername=${db_user}
    ...         dbPassword=${db_pass}
    ...         dbHost=${ssh_local_host}
    ...         dbPort=${ssh_local_port}

    BuiltIn.Log      Database connected
    BuiltIn.Log      SSH connected

Disconnect SCG-Ordering database
    DatabaseLibrary.Disconnect from database
    SSHLibrary.Close all connections
    BuiltIn.Log      Database disconnect
    BuiltIn.Log      SSH disconnect

Click today on calendar
    common.Click element when ready    ${EORDERING_COMMON.CALENDAR.TODAY.BUTTON}
    BuiltIn.Sleep    ${TIME_SLEEP['M']}

Verify calendar is display
    SeleniumLibrary.Wait until element is visible           ${EORDERING_COMMON.CALENDAR.SLIDE_LEFT.BUTTON}     ${GLOBAL_TIMEOUT}

Get month and year from calendar
    ${month_year}=    common.Get text when ready     ${EORDERING_COMMON.CALENDAR.MONTH_YEAR.TEXT}
    ${temp}=    String.Split string    ${month_year}
    ${month}=   BuiltIn.Set variable    ${temp[0]}
    ${year}=   BuiltIn.Set variable    ${temp[1]}
    [Return]    ${month}    ${year}

Click button left slide month calendar
    common.Click element when ready              ${EORDERING_COMMON.CALENDAR.SLIDE_LEFT.BUTTON}
    BuiltIn.Sleep                                ${TIME_SLEEP['S']}

Click button right slide month calendar
    common.Click element when ready              ${EORDERING_COMMON.CALENDAR.SLIDE_RIGHT.BUTTON}
    BuiltIn.Sleep                                ${TIME_SLEEP['S']}

Close calendar
    SeleniumLibrary.Press keys      None    ESC
    BuiltIn.Sleep                   2s

Close popup
    SeleniumLibrary.Press keys      None    ESC
    BuiltIn.Sleep                   2s

Select date for calendar
    [Arguments]    ${day}    ${month}    ${year}
    ${day}=    BuiltIn.Convert to integer    ${day}
    ${month}=    BuiltIn.Convert to integer    ${month}
    ${year}=    BuiltIn.Convert to integer    ${year}
    &{month_config}=    BuiltIn.Create Dictionary    January=1
    ...     February=2
    ...     March=3
    ...     April=4
    ...     May=5
    ...     June=6
    ...     July=7
    ...     August=8
    ...     September=9
    ...     October=10
    ...     November=11
    ...     December=12

    ${month_initial}    ${year_initial}=    eordering_common.Get month and year from calendar
    ${year_initial}=    BuiltIn.Convert to integer    ${year_initial}

    ${difference_year}=    BuiltIn.Evaluate     ${year}-${year_initial}
    IF  ${difference_year} < ${0}
        ${difference_year}=    BuiltIn.Evaluate     ${difference_year}*-1
    END

    ${number_for_slide_right}=      BuiltIn.Set variable    ${0}
    ${number_for_slide_left}=       BuiltIn.Set variable    ${0}

    IF  ${year_initial} < ${year}
        ${number_for_slide_right}=    BuiltIn.Evaluate    ${number_for_slide_right}+${difference_year}*12
    ELSE
        ${number_for_slide_left}=    BuiltIn.Evaluate    ${number_for_slide_left}+${difference_year}*12
    END

    ${difference_month}=    BuiltIn.Evaluate     (${month}-${month_config['${month_initial}']})
    IF  ${difference_month} < ${0}
        ${difference_month}=    BuiltIn.Evaluate     ${difference_month}*-1
    END

    IF  ${month_config['${month_initial}']} < ${month}
        ${number_for_slide_right}=    BuiltIn.Evaluate    ${number_for_slide_right}+${difference_month}
    ELSE
        ${number_for_slide_left}=    BuiltIn.Evaluate    ${number_for_slide_left}+${difference_month}
    END

    ${difference_slide}=    BuiltIn.Evaluate    ${number_for_slide_right}-${number_for_slide_left}
    IF  ${difference_slide} < ${0}
        ${difference_slide}=    BuiltIn.Evaluate     ${difference_slide}*-1
    END

    IF  ${number_for_slide_right} < ${number_for_slide_left}
        FOR    ${i}    IN RANGE    ${difference_slide}
            ${month_year_before_slide}=    common.Get text when ready     ${EORDERING_COMMON.CALENDAR.MONTH_YEAR.TEXT}
            eordering_common.Click button left slide month calendar
            ${locator.process_animation}=    String.Replace string    ${EORDERING_COMMON.CALENDAR.MONTH_YEAR_PROCESS.TEXT}    {month_year}    ${month_year_before_slide}
            SeleniumLibrary.Wait until element is not visible       ${locator.process_animation}
        END
    ELSE
        FOR    ${i}    IN RANGE    ${difference_slide}
            ${month_year_before_slide}=    common.Get text when ready     ${EORDERING_COMMON.CALENDAR.MONTH_YEAR.TEXT}
            eordering_common.Click button right slide month calendar
            ${locator.process_animation}=    String.Replace string    ${EORDERING_COMMON.CALENDAR.MONTH_YEAR_PROCESS.TEXT}    {month_year}    ${month_year_before_slide}
            SeleniumLibrary.Wait until element is not visible       ${locator.process_animation}
        END
    END

    ${target_month_year}=    BuiltIn.Set variable    ${0}

    FOR    ${key}    IN    @{month_config.keys()}
        IF  '${month_config['${key}']}' == '${month}'
            ${target_month_year}=    BuiltIn.Set variable    ${key} ${year}
        END
    END

    ${locator.process}=    String.Replace string    ${EORDERING_COMMON.CALENDAR.MONTH_YEAR_PROCESS.TEXT}    {month_year}    ${target_month_year}
    SeleniumLibrary.Wait until element is visible       ${locator.process}
    ${day}=    BuiltIn.Convert to string    ${day}
    ${locator.day}=     String.Replace string       ${EORDERING_COMMON.CALENDAR.DATE.BUTTON}    {day}   ${day}
    common.Click element when ready      ${locator.day}    ${TIME_SLEEP['S']}
    BuiltIn.Sleep      3s

Wait until popup system is processing visible
    common.Wait until element is visible with handle stale element   ${EORDERING_COMMON.POPUP.SYSTEM_IS_PROCESSING.TEXT}    ${TIME_SLEEP['XXXL']}

Wait until popup system is processing not visible
    common.Wait until element is visible with handle stale element   ${EORDERING_COMMON.POPUP.SYSTEM_IS_PROCESSING.TEXT}    ${TIME_SLEEP['XXXL']}

Wait until page not contains popup system is processing
    SeleniumLibrary.Wait until page does not contain element   ${EORDERING_COMMON.POPUP.SYSTEM_IS_PROCESSING.TEXT}    ${TIME_SLEEP['XXXL']}

Wait until popup system is processing process finish
    eordering_common.Wait until popup system is processing visible
    eordering_common.Wait until popup system is processing not visible

Get date lastdate of next 2 month from current
    ${today}=           BuiltIn.Get time    day,month,year
    ${month}=           BuiltIn.Set variable    ${today}[1]
    ${year}=            BuiltIn.Set variable    ${today}[0]

    ${lastdate_of_2_month}=         helper.Get lastdate of next 2 month         ${month}    ${year}
    ${lastdate_of_2_month}=         String.Split string     ${lastdate_of_2_month}    /
    ${lastdate_2_month_day}=        BuiltIn.Set variable    ${lastdate_of_2_month[0]}
    ${lastdate_2_month_month}=      BuiltIn.Set variable    ${lastdate_of_2_month[1]}
    ${lastdate_2_month_year}=       BuiltIn.Set variable    ${lastdate_of_2_month[2]}

    [Return]        ${lastdate_2_month_day}     ${lastdate_2_month_month}     ${lastdate_2_month_year}

Click close message popup if exist
    Builtin.Run keyword and ignore error    common.Click element when ready         ${EORDERING_COMMON.POPUP_MESSAGE.CLOSE.BUTTON}   ${TIME_SLEEP['S']}

Click apply all button in calendar
    common.Click element when ready         ${EORDERING_COMMON.CALENDAR.APPLY_ALL.BUTTON}

Query customer block by sold to code
    [Arguments]    ${sold_to_code}
    ${query}        BuiltIn.Catenate
    ...    SELECT
    ...        smds.sold_to_code ,
    ...        smds2.name1 ,
    ...        smds.customer_block
    ...    FROM
    ...        sap_master_data_soldtomaster smds
    ...    JOIN
    ...        sap_master_data_soldtopartneraddressmaster smds2
    ...    ON
    ...        smds.sold_to_code = smds2.partner_code
    ...    WHERE
    ...        smds.sold_to_code = '${sold_to_code}'
    ${query_result}=      DatabaseLibrary.Query         ${query}
    ${customer_block}=    BuiltIn.Set variable          ${query_result}[0][2]
    [Return]      ${customer_block}

Query when db is ready
    [Arguments]     ${query}
    ${is_db_ready}=     BuiltIn.Run keyword and return status       DatabaseLibrary.Query   ${query}
    IF  not(${is_db_ready})
        eordering_common.Connect to SCG-Ordering database via SSH
    END
    ${result}=      DatabaseLibrary.Query   ${query}
    [Return]    ${result}

Verify that customer block equal to block_status on database
    [Arguments]    ${customer_block}    ${block_status}
    BuiltIn.Should Be Equal        ${customer_block}        ${block_status}

Verify that create order error pop up display on the page
    SeleniumLibrary.Wait until element is visible           ${EORDERING_COMMON.CREATE_ORDER_ERROR.MESSAGE.TEXT}        ${GLOBAL_TIMEOUT}

Verify that source of system display on create order error pop up
    [Arguments]    ${source_of_system}
    ${locator.source_of_system}=        String.Replace string        ${EORDERING_COMMON.CREATE_ORDER_ERROR.SOURCE_OF_SYSTEM.TEXT}         {source_of_system}      ${source_of_system}
    SeleniumLibrary.Wait until element is visible                    ${locator.source_of_system}                       ${GLOBAL_TIMEOUT}

Verify that item no display on create order error pop up
    [Arguments]     ${item_no}
    ${locator.item_no}=                 String.Replace string        ${EORDERING_COMMON.CREATE_ORDER_ERROR.ITEM_NO.TEXT}                  {item_no}               ${item_no}
    SeleniumLibrary.Wait until element is visible                    ${locator.item_no}                                ${GLOBAL_TIMEOUT}

Verify that error code display on create order error pop up by item no
    [Arguments]     ${item_no}          ${error_code}
    ${locator.item_no}=                 String.Replace string        ${EORDERING_COMMON.CREATE_ORDER_ERROR.ERROR_CODE.TEXT}               {item_no}               ${item_no}
    ${locator.error_code}=              String.Replace string        ${locator.item_no}         {error_code}           ${error_code}
    SeleniumLibrary.Wait until element is visible                    ${locator.error_code}                             ${GLOBAL_TIMEOUT}

Verify that error description display on create order error pop up by item no
    [Arguments]     ${item_no}          ${error_description}
    ${locator.item_no}=                 String.Replace string        ${EORDERING_COMMON.CREATE_ORDER_ERROR.ERROR_DESCRIPTION.TEXT}        {item_no}               ${item_no}
    ${locator.error_description}=       String.Replace string        ${locator.item_no}         {error_description}    ${error_description}
    SeleniumLibrary.Wait until element is visible                    ${locator.error_description}                      ${GLOBAL_TIMEOUT}

Click close button on create order error pop up
    common.Click element when ready     ${EORDERING_COMMON.CREATE_ORDER_ERROR.CLOSE_BUTTON.BUTTON}     ${GLOBAL_TIMEOUT}