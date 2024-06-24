*** Settings ***
Resource        ${CURDIR}${/}..${/}..${/}imports${/}import.resource
Test Teardown   common.Default test teardown
Force Tags      e_ordering    create_order  report

*** Test Cases ***
Verify that the Delivery report function works correctly.
    [Tags]    e2e   domestic    dom_00018
    ##----- Create Order -------##
    common.Open chrome browser   ${URL['E_ORDERING']}
    BuiltIn.Sleep                                                                                  ${TIME_SLEEP['L']}
    dashboard_page.Click on banner
    eordering_common.Close cookie popup
    login_feature.Login with username or email and close cookie popup           ${dom_00018['username']}   ${dom_00018['password']}
    eordering_common.Click close message popup if exist
    dashboard_page.Click menu inquiry
    dashboard_page.Click submenu delivery report lms
    delivery_report_page.Verify that value on sales organization show correctly in search page     ${dom_00018['sales']}
    delivery_report_page.Verify that default fromdate is proper                                    ${dom_00018['fromdate']}
    delivery_report_page.Verify that default todate is proper                                      ${dom_00018['todate']}
    delivery_report_feature.Input sold to and click suggest                                        ${dom_00018['sold_to']}
    delivery_report_feature.Input material no and click suggest                                    ${dom_00018['mat_no']}
    delivery_report_page.Input po no                                                               ${dom_00018['po_no']}
    delivery_report_page.Input so no                                                               ${dom_00018['so_no']}
    delivery_report_page.Click date clear button
    delivery_report_page.Click search button
    delivery_report_page.Verify related item found is display
    delivery_report_page.Verify that result table display po no correctly                          ${dom_00018['po_no']}
    delivery_report_page.Verify that result table display so no correctly                          ${dom_00018['so_no']}
    delivery_report_page.Verify that result table display mat no correctly                         ${dom_00018['mat_no']}
    delivery_report_page.Click tab delivery report
    common.Scroll page custom                                                                      1200
    delivery_report_feature.Click clear and verify that system reset value all field
    delivery_report_feature.Verify the all lms status  
    delivery_report_feature.verify the gps popup
    BuiltIn.Sleep                                                                                  ${TIME_SLEEP['L']}
   