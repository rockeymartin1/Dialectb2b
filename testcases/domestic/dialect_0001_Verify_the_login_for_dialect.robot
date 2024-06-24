*** Settings ***
Resource        ${CURDIR}${/}..${/}..${/}imports${/}import.resource
Test Teardown   common.Default test teardown
Force Tags      e_ordering    create_order  report

*** Test Cases ***
Verify the procurement and sales flow for dialectb2b.
    [Tags]    e2e   domestic    dialect_0001
    common.Open chrome browser   ${URL['DIALECT']}
    BuiltIn.Sleep                                                                                  ${TIME_SLEEP['L']}
    eordering_common.Close cookie popup
    login_feature.Login with username or email and close cookie popup     ${dialect_0001['username']}   ${dialect_0001['password']}
    dashboard_page.Click create quote
    dialect_page.Input category                                      ${dialect_0001['category']}
    dialect_page.Click subcategory                                  ${dialect_0001['category']}
    dialect_page.Generate quote
    dialect_page.Verify that quote crated succesfully 
    dialect_page.Verify the generated quote in the inbox 
    ##dialect_page.Logout from the procurement account 
    ##---check the quote in the sales account
    ##login_feature.Login with username or email and close cookie popup     ${dialect_0001['username1']}   ${dialect_0001['password1']} 
    ##dialect_page.Verify the generated quote in the sales account                                      
   