*** Keywords ***
Search the email
    [Arguments]         ${search_text}
    outlook_inbox_page.Input text in search box                     ${search_text}
    outlook_inbox_page.Click search button

Verify email and get so no
    [Arguments]         ${email_header}
    outlook_inbox_page.Select email from inbox                                  ${email_header}
    BuiltIn.Sleep                                                               ${TIME_SLEEP['XL']}         reason=Wait for animation process
    outlook_inbox_page.Check email header is correct                            ${email_header}
    ${so_no_in_email}=      outlook_inbox_page.Get so no from email content
    [Return]            ${so_no_in_email}

Search the email and verify expected result
    [Arguments]     ${search_text}      ${email_header}     ${loop_round}=12    ${time_sleep}=10
    FOR     ${i}    IN RANGE    ${loop_round}
        outlook_inbox_page.Click search box
        outlook_inbox_page.Clear search field manually
        outlook_inbox_page.Input text in search box                     ${search_text}
        outlook_inbox_page.Click search button
        ${is_visible}=      BuiltIn.Run keyword and return status       outlook_inbox_page.Verify search email is display       ${email_header}     ${time_sleep}
        BuiltIn.Exit for loop if    ${is_visible}
    END
    IF      not(${is_visible})
        BuiltIn.Fail        Couldn't found expect email.
    END

Select expected email and verify email header with retry
    [Arguments]     ${email_header}     ${lot_no}   ${retry}=3
    FOR     ${i}    IN RANGE    ${retry}
        outlook_inbox_page.Select email from inbox                  ${email_header}
        ${is_visible}=      BuiltIn.Run keyword and return status       outlook_inbox_page.Check email header is correct            ${lot_no}
        BuiltIn.Exit for loop if    ${is_visible}
    END
    IF      not(${is_visible})
        BuiltIn.Fail        Couldn't found expect email.
    END