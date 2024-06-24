*** Keywords ***
Login with username or email
    [Arguments]    ${username}      ${password}
    ##login_page.Click sign in with username or email button
    BuiltIn.Sleep                                                                       ${TIME_SLEEP['S']}
    login_page.Input username                                                           ${username}
    login_page.Input password                                                           ${password}
    login_page.Click sign in button

Login with username or email and close cookie popup
    [Arguments]    ${username}      ${password}
    Login with username or email        ${username}      ${password}
    eordering_common.Close cookie popup

Login with SCG account
    [Arguments]    ${username}    ${password}
    login_page.Click sign in with SCG account button
    BuiltIn.Sleep                                                                        ${TIME_SLEEP['S']}
    login_page.Input username for SCG account                                            ${username}
    login_page.Click MS next-signin button for SCG
    login_page.Input password for SCG account                                            ${password}
    login_page.Click MS next-signin button for SCG
    login_page.Click MS next-signin button for SCG

Login with SCG account and close cookie popup
    [Arguments]    ${username}      ${password}
    Login with SCG account       ${username}      ${password}
    eordering_common.Close cookie popup

Logout
    [Arguments]     ${display_username}
    login_page.Click icon profile    ${display_username}
    login_page.Click logout button
    login_page.Verify signin in with username or email button is display