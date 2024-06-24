*** Keywords **
Input category
    [Arguments]     ${category}
    common.Input text when ready             ${DIALECT.CATEGORY.TEXTBOX}    ${category}
    BuiltIn.Sleep                                   ${TIME_SLEEP['M']}

Click subcategory
    ##common.Click element when ready         ${DIALECT.SUBCATEGORY.BUTTON}
    [Arguments]     ${category}
    ${locator.subcategory}=     String.Replace string       ${DIALECT.SUBCATEGORY.BUTTON}    {subcategorytext}   ${category}
    common.Click element when ready         ${locator.subcategory}

Generate quote
    dialect_page.Input subject text       ${dialect_0001['subject']}     
    dialect_page.Input dateandtime        ${dialect_0001['date']}
    dialect_page.Input country dropdown    ${dialect_0001['country']}
    dialect_page.Input region dropdown     ${dialect_0001['region']}
    dialect_page.Input content text        ${dialect_0001['content']}
    dialect_page.click generate button

Input subject text
    [Arguments]     ${subject}
    common.Input text when ready             ${DIALECT.SUBJECT.TEXTBOX}    ${subject}

Input dateandtime
    [Arguments]     ${date}
    common.Input text when ready             ${DIALECT.DATEWINDOW.TEXTBOX}    ${date}

Input country dropdown
    [Arguments]     ${country}
    common.Select from list              ${DIALECT.COUNTRY.DROPBOX}    ${country}
    ##common.Input text when ready             ${DIALECT.COUNTRY.DROPBOX}    ${country}

Input region dropdown
    [Arguments]     ${region}
    common.Select from list              ${DIALECT.REGION.DROPBOX}    ${region}
    ##common.Input text when ready             ${DIALECT.COUNTRY.DROPBOX}    ${country}

Input content text
    [Arguments]     ${content}
    common.Input text when ready             ${DIALECT.CONTENT.TEXTBOX}    ${content}

click generate button
    BuiltIn.Sleep                                   ${TIME_SLEEP['L']}
    common.Scroll element into view when ready  ${DIALECT.GENERATE.BUTTON}    ${1}   ${GLOBAL_TIMEOUT}
    SeleniumLibrary.Wait until element is visible       ${DIALECT.GENERATE.BUTTON}       ${GLOBAL_TIMEOUT}
    common.Click element when ready         ${DIALECT.GENERATE.BUTTON}
    ##common.Wait until element is visible with handle stale element      ${DIALECT.GENERATE.BUTTON}    timeout=${TIME_SLEEP['XL']}
    ##common.Click element when ready         ${DIALECT.GENERATE.BUTTON}

Verify that quote crated succesfully 
    [Arguments]     ${expected_value}=Quote Generated
    ${success_message}=    dialect_page.Get success message
    BuiltIn.Should be equal as strings     ${success_message}    ${expected_value}   



Get success message
    ${success_message}=    common.Get text when ready      ${DIALECT.SUCCESS.TEXT}
    [Return]    ${success_message}

Verify the generated quote in the inbox 
    ${refrence_id}=        dialect_page.Get referenceid
    common.Click element when ready         ${DIALECT.GOTODASHBOARD.BUTTON}
    common.Click element when ready          ${DIALECT.SEARCHICON.BUTTON}
    common.Input text when ready             ${DIALECT.SEARCHID.TEXTBOX}    ${refrence_id}
    common.Click element when ready          ${DIALECT.SEARCHID.TEXTBOX}
    ${mailboxrefrence_id}=    dialect_page.Get referenceid from mail box
    BuiltIn.Should be equal as strings     ${mailboxrefrence_id}    ${refrence_id}
    common.Click element when ready          ${DIALECT.USERDROPDOWN.TEXTBOX}
    common.Click element when ready          ${DIALECT.LOGOUT.TEXTBOX}
    login_feature.Login with username or email and close cookie popup     ${dialect_0001['username1']}   ${dialect_0001['password1']} 
    common.Click element when ready          ${DIALECT.SALESSEARCHICON.BUTTON}
    common.Click element when ready          ${DIALECT.SALESSEARCHID.TEXTBOX}
    common.Input text when ready             ${DIALECT.SALESSEARCHID.TEXTBOX}    ${refrence_id}
    BuiltIn.Sleep                                   ${TIME_SLEEP['L']}
    SeleniumLibrary.Press keys    ${DIALECT.SALESSEARCHID.TEXTBOX}   ALT+ARROW_RIGHT
    common.Click element when page contains element         ${DIALECT.SALESSEARCHID.TEXTBOX}       ${GLOBAL_TIMEOUT} 
    BuiltIn.Sleep                                   ${TIME_SLEEP['L']}
    ${salesmailboxrefrence_id}=    dialect_page.Get referenceid from sales mail box
    @{list_string}     Split string   ${salesmailboxrefrence_id}      :
    log             ${list_string}[3]
    @{list_string}     Split string   ${list_string}[3]     \n
    log             ${list_string}[0]
    ${list_string}    Strip String    ${list_string}[0]
    Log    ${list_string}
    ${type_string}=    Evaluate     type($list_string)
    Log To Console     ${type_string}
    BuiltIn.Should be equal as strings     ${list_string}    ${refrence_id}

Get referenceid
   ${refrence_id}=     common.Get text when ready      ${DIALECT.REFERENCEID.TEXT}
    [Return]    ${refrence_id}

Get referenceid from mail box
    BuiltIn.Sleep                                   ${TIME_SLEEP['L']}
    ${mailboxrefrence_id}=    common.Get text when ready      ${DIALECT.MAILBOXREFERENCEID.TEXT}
    [Return]    ${mailboxrefrence_id}


Get referenceid from sales mail box
    BuiltIn.Sleep                                   ${TIME_SLEEP['L']}
    ${salesmailboxrefrence_id}=    common.Get text when ready      ${DIALECT.SALESMAILBOXREFERENCEID.TEXT}
    [Return]    ${salesmailboxrefrence_id}
  
    
    