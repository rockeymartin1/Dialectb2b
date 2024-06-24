*** Keywords ***
Input text in search box
    [Arguments]         ${search_text}
    common.Input text when ready                            ${OUTLOOK_EMAIL.SEARCH.TEXTBOX}             ${search_text}

Click search button
    common.Click element when ready                         ${OUTLOOK_EMAIL.SEARCH.BUTTON}

Verify search email is display
    [Arguments]         ${email_header}     ${time_sleep}=5
    ${OUTLOOK_EMAIL.INBOX_EMAIL.TEXT}                       String.Replace string                       ${OUTLOOK_EMAIL.INBOX_EMAIL.TEXT}                        email_header                ${email_header}
    SeleniumLibrary.Wait until element is visible           ${OUTLOOK_EMAIL.INBOX_EMAIL.TEXT}           ${time_sleep}

Select email from inbox
    [Arguments]         ${email_header}
    ${OUTLOOK_EMAIL.INBOX_EMAIL.TEXT}                       String.Replace string                       ${OUTLOOK_EMAIL.INBOX_EMAIL.TEXT}                        email_header                ${email_header}
    common.Click element when page contains element         ${OUTLOOK_EMAIL.INBOX_EMAIL.TEXT}

Check email header is correct
    [Arguments]         ${email_header}
    ${OUTLOOK_EMAIL.EMAIL_CONTENT_HEADER.TEXT}              String.Replace string                       ${OUTLOOK_EMAIL.EMAIL_CONTENT_HEADER.TEXT}              email_header                 ${email_header}
    SeleniumLibrary.Wait until element is visible           ${OUTLOOK_EMAIL.EMAIL_CONTENT_HEADER.TEXT}

Check source of the error in email content page
    [Arguments]         ${error_source}
    ${OUTLOOK_EMAIL.EMAIL_CONTENT_ERROR_SOURCE.TEXT}        String.Replace string                       ${OUTLOOK_EMAIL.EMAIL_CONTENT_ERROR_SOURCE.TEXT}        error_source                ${error_source}
    SeleniumLibrary.Wait until element is visible           ${OUTLOOK_EMAIL.EMAIL_CONTENT_ERROR_SOURCE.TEXT}

Check source of the error in email content page when failed SAP
    [Arguments]         ${error_source}
    ${OUTLOOK_EMAIL.EMAIL_CONTENT_ERROR_SOURCE.TEXT}        String.Replace string                       ${OUTLOOK_EMAIL.EMAIL_CONTENT_ERROR_SOURCE_SAP.TEXT}        error_source                ${error_source}
    SeleniumLibrary.Wait until element is visible           ${OUTLOOK_EMAIL.EMAIL_CONTENT_ERROR_SOURCE.TEXT}


Check email message and attachment in email content page
    [Arguments]         ${email_message}     ${email_attachment}
    ${OUTLOOK_EMAIL.INBOX_EMAIL.TEXT}                       String.Replace string                       ${OUTLOOK_EMAIL.INBOX_EMAIL.TEXT}                        email_header                ${email_message}
    ${OUTLOOK_EMAIL.EMAIL_CONTENT_ATTACHMENT}              String.Replace string                        ${OUTLOOK_EMAIL.EMAIL_CONTENT_HEADER.TEXT}               email_header                ${email_attachment}
    SeleniumLibrary.Wait until element is visible           ${OUTLOOK_EMAIL.INBOX_EMAIL.TEXT}
    SeleniumLibrary.Wait until element is visible           ${OUTLOOK_EMAIL.EMAIL_CONTENT_ATTACHMENT}

Get so no from email content
    ${text_so_no}            SeleniumLibrary.Get text                               ${OUTLOOK_INBOX_EMAIL.EMAIL.TEXT_SO_NO}
    ${so_no_in_email}            String.Remove string           ${text_so_no}       เลขที่ใบสั่งซื้อ :        ${SPACE}
    [Return]            ${so_no_in_email}

Click search box
    [Arguments]     ${retry}=4
    FOR     ${i}    IN RANGE    ${retry}
        ${is_visible}=      BuiltIn.Run keyword and return status       SeleniumLibrary.Wait until element is visible            ${OUTLOOK_EMAIL.SEARCH.BUTTON}      ${TIME_SLEEP['L']}
        common.Click element when ready                         ${OUTLOOK_EMAIL.SEARCH.TEXTBOX}
        BuiltIn.Exit for loop if        ${is_visible}
    END
    IF   not(${is_visible})
        BuiltIn.Fail        Ciuldn't click search box properly
    END

Clear search field manually
    common.Manually clear input from textbox                ${OUTLOOK_EMAIL.SEARCH.TEXTBOX}
