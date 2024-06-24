*** Keywords ***
Open outlook
    common.Open chrome browser                  ${url['outlook']}

Open outlook with new tab
    #Opening new tab from existing window and navigate to outlook on the new opened tab
    Execute JavaScript                          window.open("", "_blank")
    SeleniumLibrary.Switch Window               NEW
    SeleniumLibrary.Go To                       ${url['outlook']}

Input outlook email
    [Arguments]         ${email}
    common.Input text when ready                ${OUTLOOK_LOGIN_EMAIL.EMAIL.TEXTBOX}                ${email}

Click next button
    common.Click element when ready             ${OUTLOOK_LOGIN_EMAIL.NEXT.BUTTON}

Input outlook password
    [Arguments]         ${password}
    common.Input text when ready                ${OUTLOOK_LOGIN_PASS.PASSWORD.TEXTBOX}              ${password}

Click sign in button
    common.Click element when ready             ${OUTLOOK_LOGIN_PASS.SIGNIN.BUTTON}

Click yes button to stay signed in
    common.Click element when ready             ${OUTLOOK_LOGIN_STAYSIGNIN.YES.BUTTON}