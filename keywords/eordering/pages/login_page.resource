*** Keywords ***

##=====  for external account  =====##
Click sign in with username or email button
    common.Click element when ready      ${LOGIN_LOGOUT.SIGN_IN_WITH_USERNAME_OR_EMAIL.BUTTON}

Input username
    [Arguments]     ${username}
    common.Input text when ready     ${LOGIN_LOGOUT.USERNAME_OR_EMAIL.TEXTBOX}      ${username}

Input password
    [Arguments]     ${password}
    common.Input text when ready     ${LOGIN_LOGOUT.PASSWORD.TEXTBOX}      ${password}

Click sign in button
    common.Click element when ready      ${LOGIN_LOGOUT.SIGNIN_SUBMIT.BUTTON}
##=====  for external account  =====##

##===== for scg account  =====##
Click sign in with SCG account button
    common.Click element when ready      ${LOGIN_LOGOUT.SIGN_IN_WITH_SCG_ACCOUNT.BUTTON}

Input username for SCG account
    [Arguments]     ${username}
    common.Input text when ready     ${LOGIN_LOGOUT.USERNAME_SCG.TEXTBOX}      ${username}

Input password for SCG account
    [Arguments]     ${password}
    common.Input text when ready     ${LOGIN_LOGOUT.PASSWORD_SCG.TEXTBOX}      ${password}

Click MS next-signin button for SCG
    common.Click element when ready      ${LOGIN_LOGOUT.MS_NEXT-SIGNIN.BUTTON}
##=====  for scg account  =====##

Click icon profile
    [Arguments]     ${display_username}
    ${locator.logout}=    String.Replace string    ${LOGIN_LOGOUT.ICON_PROFILE.BUTTON}      {display_username}      ${display_username}
    common.Click element when ready      ${locator.logout}

Click logout button
    Click element when ready        ${LOGIN_LOGOUT.ICON_PROFILE.LOGOUT.BUTTON}

Verify signin in with username or email button is display
    SeleniumLibrary.Wait until element is visible    ${LOGIN_LOGOUT.SIGN_IN_WITH_USERNAME_OR_EMAIL.BUTTON}    ${TIME_SLEEP['L']}
