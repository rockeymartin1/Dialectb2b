*** Keywords **

Verify header text is pending order tracking page
    SeleniumLibrary.Wait until element is visible           ${PENDING_ORDER_TRACKING.HEADER.TEXT}      ${GLOBAL_TIMEOUT}

Verify that default value of sales organization show correctly in search page
    [Arguments]    ${sales}
    ${locator.sales}=    String.Replace string    ${PENDING_ORDER_TRACKING.SALES_ORGANIZATION.TEXT}    {sales}    ${sales}
    SeleniumLibrary.Wait until element is visible       ${locator.sales}       ${GLOBAL_TIMEOUT}