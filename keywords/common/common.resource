*** Settings ***
Resource    ${CURDIR}${/}..${/}..${/}imports${/}import.resource

*** Keywords ***
Open chrome browser
    [Documentation]     Open chrome browser with so many option to customize.
    ...     \n ``browser_mode`` can be either desktop or mobile to open in mobile resolution
    ...     \n ``headless`` to open browser in headful or headless mode
    [Arguments]     ${url}    ${headless}=${headless}    ${alias}=None    ${download_dir}=${FALSE}

    ${chrome_options}=     Evaluate       sys.modules['selenium.webdriver'].ChromeOptions()     sys, selenium.webdriver
    BuiltIn.Call Method     ${chrome_options}     add_argument     --disable-infobars
    BuiltIn.Call Method     ${chrome_options}     add_argument     --window-size\=1920,1080
    BuiltIn.Call Method     ${chrome_options}     add_argument     ---dev-shm-usage
    BuiltIn.Call Method     ${chrome_options}     add_argument     --disable-gpu
    BuiltIn.Call Method     ${chrome_options}     add_argument     --no-sandbox
    BuiltIn.Call Method     ${chrome_options}     add_argument     --ignore-certificate-errors

    IF  ${download_dir}
        ${current_time}=            BuiltIn.Get time    epoch
        ${download_directory}=      OperatingSystem.Join path    ${OUTPUT_DIR}    downloads_${current_time}
        OperatingSystem.Create directory            ${download_directory}
        BuiltIn.Wait until keyword succeeds    5x    2s     OperatingSystem.Directory should exist  ${download_directory}
        ${prefs}=                   BuiltIn.Create dictionary    download.default_directory=${download_directory}
        BuiltIn.Log to console      file will be downloaded to ${download_directory}
        BuiltIn.Call Method    ${chrome_options}    add_experimental_option    prefs    ${prefs}
    ELSE
        ${download_directory}=  Set variable    ${EMPTY}
    END

    IF  ${headless}
        BuiltIn.Call Method     ${chrome_options}      add_argument    --headless
        BuiltIn.Call Method     ${chrome_options}      add_argument    --window-size\=1920,1080
    END

    SeleniumLibrary.Create WebDriver    Chrome      alias=${alias}    chrome_options=${chrome_options}
    SeleniumLibrary.Go To     ${url}
    SeleniumLibrary.Maximize Browser Window

    [Return]    ${download_directory}

Default test teardown
    BuiltIn.Run keyword and ignore error    DatabaseLibrary.Disconnect From Database
    BuiltIn.Run keyword and ignore error    SSHLibrary.Close all connections
    BuiltIn.Run keyword if test failed      SeleniumLibrary.Capture page screenshot
    SeleniumLibrary.Close all browsers

Wait until element is visible with handle stale element
    [Arguments]     ${locator}    ${retry}=2    ${timeout}=${GLOBAL_TIMEOUT}
    ${status}=    BuiltIn.Run keyword and return status    SeleniumLibrary.Wait until element is visible    ${locator}    ${timeout}
    ${isStale}=     BuiltIn.Evaluate    '{status[1]}'.find("StaleElementReferenceException") != -1
    IF    ${isStale}
        FOR     ${i}    IN RANGE    1    ${retry}
            ${status}=    BuiltIn.Run keyword and return status    SeleniumLibrary.Wait until element is visible    ${locator}    ${timeout}
            BuiltIn.Exit for loop if    '${status}'=='Pass'
        END
    ELSE IF    '${status}'== 'FAIL'
        BuiltIn.Fail    msg=${status[0]}
    END

Click element when ready
    [Arguments]    ${locator}    ${timeout}=${GLOBAL_TIMEOUT}
    SeleniumLibrary.Wait until element is visible       ${locator}      ${timeout}
    SeleniumLibrary.Wait until element is enabled       ${locator}      ${timeout}
    SeleniumLibrary.Click element                       ${locator}

Click element when ready with retry
    [Arguments]    ${locator}    ${timeout}=${GLOBAL_TIMEOUT}    ${retry}=4x    ${retry_interval}=5s
    BuiltIn.Wait until keyword succeeds    ${retry}    ${retry_interval}    common.Click element when ready    ${locator}    ${timeout}

Click element if exists
    [Arguments]    ${locator}    ${timeout}=${GLOBAL_TIMEOUT}
    ${element_exists} =     BuiltIn.Run keyword and return status     SeleniumLibrary.Element should be visible   ${locator}     ${timeout}
    BuiltIn.Run Keyword If    ${element_exists}    SeleniumLibrary.Click element    ${locator}

Scroll element into view when ready
    [Arguments]     ${locator}      ${retry}=4      ${timeout}=${GLOBAL_TIMEOUT}
    FOR     ${i}    IN RANGE   0    ${retry}
        SeleniumLibrary.Wait until page contains element    ${locator}      ${timeout}
        SeleniumLibrary.Scroll element into view            ${locator}
        ${is_visible}=  Run keyword and return status   SeleniumLibrary.Wait until element is visible       ${locator}      ${timeout}
        Exit for loop if    ${is_visible}
    END

Scroll right element with xpath by js
    [Arguments]     ${locator}    ${distance}
    SeleniumLibrary.Wait until page contains element    ${locator}    ${GLOBAL_TIMEOUT}
    SeleniumLibrary.Execute javascript    (document.evaluate('${locator}', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue).scrollTo(${distance},0);

Click element when ready by js
    [Arguments]     ${locator}
    SeleniumLibrary.Wait until page contains element    ${locator}    ${GLOBAL_TIMEOUT}
    ${js_cmd}=          BuiltIn.Set variable        (document.evaluate("${locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue).click();
    SeleniumLibrary.Execute javascript    ${js_cmd}

Click element when page contains element
    [Arguments]    ${locator}    ${timeout}=${GLOBAL_TIMEOUT}
    SeleniumLibrary.Wait until page contains element    ${locator}      ${timeout}
    SeleniumLibrary.Click element                       ${locator}

Input text when ready
    [Arguments]    ${locator}    ${text}    ${clear}=${True}    ${timeout}=${GLOBAL_TIMEOUT}
    SeleniumLibrary.Wait until element is visible       ${locator}      ${timeout}
    SeleniumLibrary.Input text                          ${locator}      ${text}    clear=${clear}

Get text when ready
    [Arguments]    ${locator}    ${timeout}=${GLOBAL_TIMEOUT}
    SeleniumLibrary.Wait until element is visible       ${locator}      ${timeout}
    ${text}=    SeleniumLibrary.Get text    ${locator}
    [Return]    ${text}

Click checkbox by label
    [Arguments]    ${locator}   ${label}    ${should_select}=${True}    ${timeout}=${GLOBAL_TIMEOUT}
    ${locator.checkbox}=    String.Replace string       ${locator}    {label}    ${label}
    SeleniumLibrary.Wait until element is enabled       ${locator.checkbox}     ${timeout}
    # Verify if the checkbox should be selected or unselected
    ${is_selected} =    BuiltIn.Run keyword if    ${should_select}    BuiltIn.Set variable    True    else    BuiltIn.Set variable    False
    # Select/unselect the checkbox based on the desired state
    BuiltIn.Run keyword if   ${is_selected}    SeleniumLibrary.Click element    ${locator.checkbox}

Get element count when ready
    [Arguments]     ${locator}   ${timeout}=${GLOBAL_TIMEOUT}
    SeleniumLibrary.Wait until element is visible       ${locator}      ${timeout}
    ${count}=   SeleniumLibrary.Get element count       ${locator}
    [Return]    ${count}

Get element attribute when ready
    [Arguments]     ${locator}      ${attribute}    ${timeout}=${GLOBAL_TIMEOUT}
    SeleniumLibrary.Wait until element is visible       ${locator}      ${timeout}
    ${att}=     SeleniumLibrary.Get element attribute     ${locator}      ${attribute}
    [Return]    ${att}

Get CSS property value
    [Arguments]    ${locator}    ${attribute_name}
    ${css}=             SeleniumLibrary.Get WebElement    ${locator}
    ${prop_val}=        BuiltIn.Call Method       ${css}    value_of_css_property    ${attribute_name}
    [Return]     ${prop_val}

Get value when ready
    [Arguments]     ${locator}      ${timeout}=${GLOBAL_TIMEOUT}
    SeleniumLibrary.Wait until element is visible       ${locator}      ${timeout}
    ${value}=   SeleniumLibrary.Get value     ${locator}
    [Return]    ${value}

Get value when ready with retry
    [Arguments]     ${locator}      ${retry}=3    ${interval}=3s    ${timeout}=${GLOBAL_TIMEOUT}
    ${isSuccess}=    BuiltIn.Run keyword and return status    common.Get value when ready    ${locator}  ${timeout}
    IF  not(${isSuccess})
        FOR    ${i}    IN RANGE    1    ${retry}
            ${isSuccess}=    BuiltIn.Run keyword and return status    common.Get value when ready    ${locator}  ${timeout}
            BuiltIn.Exit for loop if    ${isSuccess}
        END
    END
    ${value}    BuiltIn.Set variable
    IF  ${isSuccess}
        ${value}=    common.Get value when ready    ${locator}  ${timeout}
    ELSE
        BuiltIn.Fail    reason=can't get value form ${locator}
    END
        common.Get value when ready    ${locator}
    [Return]    ${value}

Clear text when ready
    [Arguments]     ${locator}      ${timeout}=${GLOBAL_TIMEOUT}
    SeleniumLibrary.Wait until element is visible       ${locator}      ${timeout}
    SeleniumLibrary.Clear element text                  ${locator}
    BuiltIn.Sleep    ${TIME_SLEEP['S']}

Manually clear input from textbox
    [Arguments]     ${locator}      ${timeout}=${GLOBAL_TIMEOUT}
    ${current_value}=   common.Get value when ready    ${locator}      ${timeout}
    ${word_length}=     BuiltIn.Get length      ${current_value}
    FOR     ${i}    IN RANGE   ${word_length}
        Press keys     ${locator}       BACKSPACE
    END

Mouse over when ready
    [Arguments]     ${locator}      ${timeout}=${GLOBAL_TIMEOUT}
    SeleniumLibrary.Wait until element is visible       ${locator}      ${timeout}
    SeleniumLibrary.Mouse over      ${locator}

Scroll page custom
    [Documentation]  Scroll page using java script
    [Arguments]    ${position}
    SeleniumLibrary.Execute javascript          window.scrollTo(0,${position})
    BuiltIn.Sleep    ${TIME_SLEEP['S']}

Scroll right element
    [Arguments]    ${locator}    ${distance}
    ${element}=    SeleniumLibrary.Get webElement    ${locator}
    SeleniumLibrary.Execute JavaScript    arguments[0].scrollLeft += ${distance}    ${element}

Upload file when ready
    [Arguments]     ${locator}      ${file_path}    ${timeout}=${GLOBAL_TIMEOUT}
    SeleniumLibrary.Wait until Page contains element   ${locator}       ${timeout}
    ${file_normalize}=    OperatingSystem.Normalize path    ${file_path}
    SeleniumLibrary.Choose File     ${locator}  ${file_normalize}

Convert to pure number format
    [Arguments]     ${number}
    ${number}=          BuiltIn.Convert to string       ${number}
    ${pure_number}=     String.Remove string            ${number}        ฿
    ${pure_number}=     String.Remove string            ${pure_number}        ,
    [Return]        ${pure_number}

Post request api
    [Arguments]    ${alias}=${EMPTY}    ${uri}=${EMPTY}       ${headers}=${EMPTY}       ${json}=${EMPTY}
    RequestsLibrary.Create Session    Inquiry    ${alias}
    ${resp}=   RequestsLibrary.POST On Session   Inquiry     ${uri}     json=${json}     headers=${headers}
    [Return]        ${resp}

Delete request api
    [Arguments]    ${alias}=${EMPTY}    ${uri}=${EMPTY}       ${headers}=${EMPTY}       ${json}=${EMPTY}
    RequestsLibrary.Create Session    Delete    ${alias}
    ${resp}=   RequestsLibrary.DELETE On Session   Delete     ${uri}     json=${json}     headers=${headers}
    [Return]        ${resp}

Get request api
    [Arguments]    ${alias}    ${uri}      ${headers}=${EMPTY}       ${params}=${EMPTY}
    RequestsLibrary.Create Session    Get    ${alias}
    ${resp}=   RequestsLibrary.GET On Session   Get     ${uri}     headers=${headers}        params=${params}
    [Return]        ${resp}

Remove decimal
    [Arguments]    ${number}
    ${number_without_decimal}=    BuiltIn.Evaluate    int(${number})
    [Return]    ${number_without_decimal}

Verify that download file success by count file
    [Arguments]     ${download_directory}       ${expected_count}=1
    ${count}=   OperatingSystem.Count files in directory     ${download_directory}
    BuiltIn.Should be equal as strings      ${count}    ${expected_count}

Verify that download file success
    [Arguments]     ${download_directory}       ${interval}=3s     ${retry}=10
    ${isExist}=    BuiltIn.Set variable    ${False}
    FOR     ${i}    IN RANGE    1    ${retry}
        BuiltIn.Sleep       ${interval}
        ${isExist}=     BuiltIn.Run keyword and return status    OperatingSystem.File should exist       ${download_directory}
        BuiltIn.Exit for loop if    ${isExist}
    END
    IF  not(${isExist})
        BuiltIn.Fail    msg=File not exist
    END

Verify that download file success by partial file name and extension
    [Arguments]     ${download_directory}     ${file_name}    ${extension}  ${interval}=3s     ${retry}=10
    ${isExist}=    BuiltIn.Set variable    ${False}
    FOR     ${i}    IN RANGE    1    ${retry}
        BuiltIn.Sleep       ${interval}
        ${files}=       OperatingSystem.List files in directory    ${download_directory}
        ${isExist}=     BuiltIn.Run keyword and return status    BuiltIn.Evaluate    [file for file in ${files} if file.startswith('${file_name}') and file.endswith('${extension}')]
        BuiltIn.Exit for loop if    ${isExist}
    END
    IF  not(${isExist})
        BuiltIn.Fail    msg=File not exist
    END

Select from list
    [Arguments]    ${locator}    ${label}   ${timeout}=${GLOBAL_TIMEOUT}
    SeleniumLibrary.Wait until element is visible       ${locator}      ${timeout}
    SeleniumLibrary.Wait until element is enabled       ${locator}      ${timeout}
    SeleniumLibrary.Select From List By label    ${locator}    ${label}