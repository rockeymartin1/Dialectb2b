*** Settings ***
Resource        ${CURDIR}${/}..${/}..${/}imports${/}import.resource
Test Teardown   common.Default test teardown
Force Tags      e_ordering    create_order  report

*** Test Cases ***
Verify that the pending order tracking report works correctly.
    [Tags]    e2e   domestic    dom_00019
    ##----- Create Order -------##
    common.Open chrome browser   ${URL['E_ORDERING']}
    BuiltIn.Sleep                                                                                  ${TIME_SLEEP['L']}
    ##dashboard_page.Click on banner
    eordering_common.Close cookie popup
    login_feature.Login with username or email and close cookie popup           ${dom_00019['username']}   ${dom_00019['password']}
    eordering_common.Click close message popup if exist
    dashboard_page.Click menu inquiry
    dashboard_page.Click submenu pendingorder tracking report
    pending_order_tracking_page.Verify header text is pending order tracking page
    pending_order_tracking_page.Verify that default value of sales organization show correctly in search page   ${dom_00019['sales']}