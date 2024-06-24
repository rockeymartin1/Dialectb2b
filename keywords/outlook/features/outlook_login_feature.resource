*** Keywords ***
Sign in outlook with email and password
    [Arguments]             ${email}        ${password}
    outlook_login_page.Open outlook
    outlook_login_page.Input outlook email                          ${email}
    outlook_login_page.Click next button
    outlook_login_page.Input outlook password                       ${password}
    outlook_login_page.Click sign in button
    outlook_login_page.Click yes button to stay signed in

Sign in outlook with email and password on new tab
    [Arguments]             ${email}        ${password}
    outlook_login_page.Open outlook with new tab
    outlook_login_page.Input outlook email                          ${email}
    outlook_login_page.Click next button
    outlook_login_page.Input outlook password                       ${password}
    outlook_login_page.Click sign in button
    outlook_login_page.Click yes button to stay signed in