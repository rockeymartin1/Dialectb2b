*** Keywords ***
Verify that customer cannot access create order page when customer blocked
    dashboard_page.Click menu create order
    dashboard_page.Verify customer block display on the page
    dashboard_page.Click close button on customer block dialog

Verify that customer cannot access shoppping cart page when customer blocked
    navigator_top_bar_page.Click cart icon
    dashboard_page.Verify customer block display on the page
    dashboard_page.Click close button on customer block dialog

Verify that customer cannot access po upload page when customer blocked
    dashboard_page.Click menu po upload
    dashboard_page.Verify customer block display on the page
    dashboard_page.Click close button on customer block dialog
