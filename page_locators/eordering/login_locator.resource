*** Variable ***
${LOGIN_LOGOUT.SIGN_IN_WITH_USERNAME_OR_EMAIL.BUTTON}           //button[span[text()="Sign in with Username or Email"]]
${LOGIN_LOGOUT.USERNAME_OR_EMAIL.TEXTBOX}                       //input[@name="email"]
${LOGIN_LOGOUT.PASSWORD.TEXTBOX}                                //input[@name="password"]
${LOGIN_LOGOUT.SIGNIN_SUBMIT.BUTTON}                            //input[@type="submit"]

${LOGIN_LOGOUT.USERNAME_SCG.TEXTBOX}                            //input[@name="loginfmt"]
${LOGIN_LOGOUT.PASSWORD_SCG.TEXTBOX}                            //input[@name="passwd"]
${LOGIN_LOGOUT.MS_NEXT-SIGNIN.BUTTON}                           //input[@type="submit"]
${LOGIN_LOGOUT.SIGN_IN_WITH_SCG_ACCOUNT.BUTTON}                 //button[span//b[text()="SCG Account"]]

${LOGIN_LOGOUT.ICON_PROFILE.BUTTON}                             //div[text()="{display_username}" and contains(@class,"MuiTypography-root")]
${LOGIN_LOGOUT.ICON_PROFILE.LOGOUT.BUTTON}                      //ul[div/div[text()="ออกจากระบบ"] and @role="menu"]