*** Variables ***
${OUTLOOK_LOGIN_EMAIL.EMAIL.TEXTBOX}                        //input[@type="email"]
${OUTLOOK_LOGIN_EMAIL.NEXT.BUTTON}                          //input[@type="submit"]
${OUTLOOK_LOGIN_PASS.PASSWORD.TEXTBOX}                      //input[@type="password"]
${OUTLOOK_LOGIN_PASS.SIGNIN.BUTTON}                         //input[@type="submit"]
${OUTLOOK_LOGIN_STAYSIGNIN.YES.BUTTON}                      //button[@id="acceptButton"]
# Try change xpath to id
# ${OUTLOOK_EMAIL.SEARCH.TEXTBOX}                             //input[@placeholder="ค้นหา"]
${OUTLOOK_EMAIL.SEARCH.TEXTBOX}                             id=topSearchInput
${OUTLOOK_EMAIL.SEARCH.BUTTON}                              //button[@type="button" and @aria-label="Search"]
${OUTLOOK_EMAIL.INBOX_EMAIL.TEXT}                           //span[contains(.,"email_header")]
${OUTLOOK_EMAIL.INBOX_EMAIL.MESSAGE.TEXT}                   //span[contains(text(),"message")]
${OUTLOOK_EMAIL.EMAIL_CONTENT_HEADER.TEXT}                  //div[contains(@title,"email_header")]
${OUTLOOK_EMAIL.EMAIL_CONTENT_ERROR_SOURCE.TEXT}            //p[contains(text(),"error_source")]
${OUTLOOK_EMAIL.EMAIL_CONTENT_ERROR_SOURCE_SAP.TEXT}        //p/span[contains(text(),"error_source")]