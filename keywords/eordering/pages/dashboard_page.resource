*** Keywords ***
Click menu create order
    common.Click element when ready         ${DASHBOARD.CREATE_ORDER.BUTTON}

Click create quote
    common.Click element when ready         ${DASHBOARD.QUOTE.CREATE.BUTTON}

Verify dashboard header is display
    SeleniumLibrary.Wait until element is visible        ${DASHBOARD.HEADER.TEXT}               ${GLOBAL_TIMEOUT}