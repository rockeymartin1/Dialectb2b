*** Keywords ***
Input sold to and click suggest
    [Arguments]    ${sold_to}
    delivery_report_page.Input sold to                               ${sold_to}
    delivery_report_page.Click sold to on balloon                    ${sold_to}

Input material no and click suggest
    [Arguments]    ${mat_no}
    delivery_report_page.Input material no                               ${mat_no}
    delivery_report_page.Click material no on balloon                    ${mat_no}

Click clear and verify that system reset value all field
    delivery_report_page.Click clear button
    delivery_report_feature.Verify that system reset value all field
    

Verify that system reset value all field
    delivery_report_page.Verify that system reset field sales organization
    delivery_report_page.Verify that system reset field soldtocode
    delivery_report_page.Verify that system reset field materialcode
    delivery_report_page.Verify that default fromdate is proper              ${dom_00018['fromdate']}
    delivery_report_page.Verify that default todate is proper                ${dom_00018['todate']}
    delivery_report_page.Verify that system reset field pono
    delivery_report_page.Verify that system reset field sono

Verify the all lms status
    delivery_report_page.Verify the lms statusid 1 is showing properly
    delivery_report_page.Verify the lms statusid 2 is showing properly  
    delivery_report_page.Verify the lms statusid 2.1 is showing properly
    delivery_report_page.Verify the lms statusid 2.2 is showing properly
    delivery_report_page.Verify the lms statusid 2.3 is showing properly
    delivery_report_page.Verify the lms statusid 2.4 is showing properly
    delivery_report_page.Verify the lms statusid 3 is showing properly
    delivery_report_page.Verify the lms statusid 4 is showing properly
    delivery_report_page.Verify the lms statusid 4.1 is showing properly
    delivery_report_page.Verify the lms statusid 4.2 is showing properly
    delivery_report_page.Verify the lms statusid 5 is showing properly
    delivery_report_page.Verify the lms statusid 6 is showing properly
    delivery_report_page.Verify the lms statusid 7 is showing properly
    delivery_report_page.Verify the lms statusid 7.1 is showing properly
    delivery_report_page.Verify the lms statusid 8 is showing properly
    delivery_report_page.Verify the lms statusid 8.1 is showing properly
    delivery_report_page.Verify the lms statusid 8.2 is showing properly
    delivery_report_page.Verify the lms statusid 9 is showing properly
    delivery_report_page.Verify the lms statusid and gi date is blank showing properly
    delivery_report_page.Verify the lms statusid is null and gi date has value is showing properly


verify the gps popup
    delivery_report_page.Input so no   ${dom_00018['so_no8']}
    delivery_report_page.Click date clear button
    delivery_report_page.Click search button
    BuiltIn.Sleep                         ${TIME_SLEEP['L']}
    common.Click element when ready      ${DELIVERY_REPORT.RESULT_TABLE.LMS_COLUMN_GPS.BUTTON}
    BuiltIn.Sleep                         ${TIME_SLEEP['L']}
    delivery_report_page.Verify shipmentno in gps popup
    delivery_report_page.Verify carregistrationno in gps popup 
    delivery_report_page.Verify Currentposition in gps popup 
    delivery_report_page.Verify carrier in gps popup
    delivery_report_page.Verify speed in gps popup
    delivery_report_page.Verify last signal received time in gps popup
    delivery_report_page.Verify product payment number in gps popup 
    delivery_report_page.Verify Place of delivery in gps popup  
    delivery_report_page.Verify car status in gps popup
    ##delivery_report_page.Verify destination arrival time in gps popup 
    ##delivery_report_page.Verify customer estimatiom time in gps popup
    ##delivery_report_page.Verify remaining distance in gps popup
    ##delivery_report_page.Verify estimated time required in gps popup
    ##delivery_report_page.Verify estimated arrival time required in gps popup  
    ##delivery_report_page.Verify distance from factory to customer in gps popup
    ##delivery_report_page.Verify date of invoice in gps popup 
    delivery_report_page.Verify product delivery deadline in gps popup