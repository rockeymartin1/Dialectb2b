*** Keywords **
Verify that value on sales organization show correctly in search page
    [Arguments]    ${sales}
    ${locator.sales}=    String.Replace string    ${DELIVERY_REPORT.SALES_ORGANIZATION.TEXT}    {sales}    ${sales}
    SeleniumLibrary.Wait until element is visible       ${locator.sales}       ${GLOBAL_TIMEOUT}

Verify that default fromdate is proper
    [Arguments]    ${fromdate}
    ${locator.fromdate}=    String.Replace string    ${DELIVERY_REPORT.FROMDATE.TEXT}    {fromdate}    ${fromdate}
    SeleniumLibrary.Wait until element is visible       ${locator.fromdate}       ${GLOBAL_TIMEOUT}
    Log  "Num value is ${fromdate}"  console=True


Verify that default todate is proper
    [Arguments]    ${todate}
    ${locator.todate}=    String.Replace string    ${DELIVERY_REPORT.TODATE.TEXT}    {todate}    ${todate}
    SeleniumLibrary.Wait until element is visible       ${locator.todate}       ${GLOBAL_TIMEOUT}
    Log  "Num value is ${todate}"  console=True


Input sold to
    [Arguments]     ${sold_to}
    common.Input text when ready            ${DELIVERY_REPORT.SOLD_TO.TEXTBOX}    ${sold_to}

Click sold to on balloon
    [Arguments]     ${sold_to}
    ${locator.soldto}=     String.Replace string    ${DELIVERY_REPORT.SOLD_TO.BALLOON.TEXTBOX}       {sold_to}   ${sold_to}
    common.Click element when ready         ${locator.soldto}

Input material no
    [Arguments]     ${mat_no}
    common.Input text when ready            ${DELIVERY_REPORT.MATERIAL_NO-GRADE_GRAM.TEXTBOX}    ${mat_no}

Click material no on balloon
    [Arguments]     ${mat_no}
    ${locator.material}=     String.Replace string       ${DELIVERY_REPORT.MATERIAL_NO-GRADE_GRAM.BALLOON.TEXTBOX}    {material_no}   ${mat_no}
    common.Click element when ready         ${locator.material}

Input po no
    [Arguments]    ${po_no}
    common.Input text when ready                        ${DELIVERY_REPORT.PO_NO.TEXTBOX}      ${po_no}

Input so no
    [Arguments]    ${so_no}
    common.Input text when ready                        ${DELIVERY_REPORT.SO_NO.TEXTBOX}       ${so_no}

Click date clear button
    common.Click element when ready                     ${DELIVERY_REPORT.DATECLEAR.BUTTON}

Verify related item found is display
  SeleniumLibrary.Wait until element is visible      ${DELIVERY_REPORT.RELATED_ITEM.TEXT} 


Verify that result table display po no correctly
    [Arguments]    ${po_no}    
    ${locator.po_no}=    String.Replace string        ${DELIVERY_REPORT.RESULT_TABLE.PO_NO.TEXT}     {po_no}    ${po_no}
    SeleniumLibrary.Wait until element is visible       ${locator.po_no}      ${GLOBAL_TIMEOUT}

Verify that result table display so no correctly
    [Arguments]     ${so_no}
    ${locator.so_no}=    String.Replace string        ${DELIVERY_REPORT.RESULT_TABLE.SO_NO.TEXT}     {so_no}    ${so_no}
    SeleniumLibrary.Wait until element is visible       ${locator.so_no}      ${GLOBAL_TIMEOUT}

Verify that result table display mat no correctly
    [Arguments]     ${mat_no}
    ${locator.mat_no}=    String.Replace string        ${DELIVERY_REPORT.RESULT_TABLE.MAT_NO.TEXT}     {mat_no}    ${mat_no}
    SeleniumLibrary.Wait until element is visible       ${locator.mat_no}      ${GLOBAL_TIMEOUT}

Click search button
    common.Click element when ready                     ${DELIVERY_REPORT.SEARCH.BUTTON}

Click clear button
    common.Wait until element is visible with handle stale element      ${DELIVERY_REPORT.CLEAR.BUTTON}    timeout=${TIME_SLEEP['XL']}
    common.Click element when ready         ${DELIVERY_REPORT.CLEAR.BUTTON}

Verify that system reset field sales organization
    [Arguments]     ${expected_value}=All
    ${sales_organization}=    delivery_report_page.Get sales organization
    BuiltIn.Should be equal as strings     ${sales_organization}    ${expected_value}

Verify that system reset field soldtocode
    [Arguments]     ${expected_value}=${EMPTY}
    ${soldto_code}=    delivery_report_page.Get soldtocode
    BuiltIn.Should be equal as strings     ${soldto_code}    ${expected_value}

Verify that system reset field materialcode
    [Arguments]     ${expected_value}=${EMPTY}
    ${material_code}=    delivery_report_page.Get materialcode
    BuiltIn.Should be equal as strings     ${material_code}    ${expected_value}


Verify that system reset field pono
    [Arguments]     ${expected_value}=${EMPTY}
    ${po_no}=    delivery_report_page.Get pono
    BuiltIn.Should be equal as strings     ${po_no}    ${expected_value}

Verify that system reset field sono
    [Arguments]     ${expected_value}=${EMPTY}
    ${so_no}=    delivery_report_page.Get pono
    BuiltIn.Should be equal as strings     ${so_no}    ${expected_value}

Verify the lms statusid 1 is showing properly
    delivery_report_page.Input so no   ${dom_00018['so_no1']}
    delivery_report_page.Click date clear button
    delivery_report_page.Click search button
    [Arguments]     ${expected_value}=2. เดินทางมาขึ้นสินค้า
    ${status_column}=    delivery_report_page.Get lms status column
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}
    delivery_report_page.Click tab delivery report
    delivery_report_page.Click clear button

Verify the lms statusid 2 is showing properly
    delivery_report_page.Input so no   ${dom_00018['so_no2']}
    delivery_report_page.Click date clear button
    delivery_report_page.Click search button
    [Arguments]     ${expected_value}=2. เดินทางมาขึ้นสินค้า
    ${status_column}=    delivery_report_page.Get lms status column
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}
    delivery_report_page.Click tab delivery report
    delivery_report_page.Click clear button

Verify the lms statusid 2.1 is showing properly
    delivery_report_page.Input so no   ${dom_00018['so_no3']}
    delivery_report_page.Click date clear button
    delivery_report_page.Click search button
    [Arguments]     ${expected_value}=2. เดินทางมาขึ้นสินค้า
    ${status_column}=    delivery_report_page.Get lms status column
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}
    delivery_report_page.Click tab delivery report
    delivery_report_page.Click clear button

Verify the lms statusid 2.2 is showing properly
    delivery_report_page.Input so no   ${dom_00018['so_no4']}
    delivery_report_page.Click date clear button
    delivery_report_page.Click search button
    [Arguments]     ${expected_value}=2. เดินทางมาขึ้นสินค้า
    ${status_column}=    delivery_report_page.Get lms status column
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}
    delivery_report_page.Click tab delivery report
    delivery_report_page.Click clear button

Verify the lms statusid 2.3 is showing properly
    delivery_report_page.Input so no   ${dom_00018['so_no5']}
    delivery_report_page.Click date clear button
    delivery_report_page.Click search button
    [Arguments]     ${expected_value}=2. เดินทางมาขึ้นสินค้า
    ${status_column}=    delivery_report_page.Get lms status column
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}
    delivery_report_page.Click tab delivery report
    delivery_report_page.Click clear button

Verify the lms statusid 2.4 is showing properly
    delivery_report_page.Input so no   ${dom_00018['so_no6']}
    delivery_report_page.Click date clear button
    delivery_report_page.Click search button
    [Arguments]     ${expected_value}=2. เดินทางมาขึ้นสินค้า
    ${status_column}=    delivery_report_page.Get lms status column
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}
    delivery_report_page.Click tab delivery report
    delivery_report_page.Click clear button

Verify the lms statusid 3 is showing properly
    delivery_report_page.Input so no   ${dom_00018['so_no7']}
    delivery_report_page.Click date clear button
    delivery_report_page.Click search button
    [Arguments]     ${expected_value}=3. รอขึ้นสินค้า
    ${status_column}=    delivery_report_page.Get lms status column
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}
    delivery_report_page.Click tab delivery report
    delivery_report_page.Click clear button

Verify the lms statusid 4 is showing properly
    delivery_report_page.Input so no   ${dom_00018['so_no8']}
    delivery_report_page.Click date clear button
    delivery_report_page.Click search button
    [Arguments]     ${expected_value}=4. เดินทางไปลูกค้า
    ${status_column}=    delivery_report_page.Get lms status column
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}
    delivery_report_page.Click tab delivery report
    delivery_report_page.Click clear button

Verify the lms statusid 4.1 is showing properly
    delivery_report_page.Input so no   ${dom_00018['so_no9']}
    delivery_report_page.Click date clear button
    delivery_report_page.Click search button
    [Arguments]     ${expected_value}=4. เดินทางไปลูกค้า
    ${status_column}=    delivery_report_page.Get lms status column
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}
    delivery_report_page.Click tab delivery report
    delivery_report_page.Click clear button

Verify the lms statusid 4.2 is showing properly
    delivery_report_page.Input so no   ${dom_00018['so_no10']}
    delivery_report_page.Click date clear button
    delivery_report_page.Click search button
    [Arguments]     ${expected_value}=4. เดินทางไปลูกค้า
    ${status_column}=    delivery_report_page.Get lms status column
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}
    delivery_report_page.Click tab delivery report
    delivery_report_page.Click clear button

Verify the lms statusid 5 is showing properly
    delivery_report_page.Input so no   ${dom_00018['so_no11']}
    delivery_report_page.Click date clear button
    delivery_report_page.Click search button
    [Arguments]     ${expected_value}=5. ระหว่างลงสินค้า
    ${status_column}=    delivery_report_page.Get lms status column
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}
    delivery_report_page.Click tab delivery report
    delivery_report_page.Click clear button

Verify the lms statusid 6 is showing properly
    delivery_report_page.Input so no   ${dom_00018['so_no12']}
    delivery_report_page.Click date clear button
    delivery_report_page.Click search button
    [Arguments]     ${expected_value}=6. เดินทางกลับจากลูกค้า
    ${status_column}=    delivery_report_page.Get lms status column
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}
    delivery_report_page.Click tab delivery report
    delivery_report_page.Click clear button

Verify the lms statusid 7 is showing properly
    delivery_report_page.Input so no   ${dom_00018['so_no13']}
    delivery_report_page.Click date clear button
    delivery_report_page.Click search button
    [Arguments]     ${expected_value}=6. เดินทางกลับจากลูกค้า
    ${status_column}=    delivery_report_page.Get lms status column
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}
    delivery_report_page.Click tab delivery report
    delivery_report_page.Click clear button

Verify the lms statusid 7.1 is showing properly
    delivery_report_page.Input so no   ${dom_00018['so_no14']}
    delivery_report_page.Click date clear button
    delivery_report_page.Click search button
    [Arguments]     ${expected_value}=6. เดินทางกลับจากลูกค้า
    ${status_column}=    delivery_report_page.Get lms status column
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}
    delivery_report_page.Click tab delivery report
    delivery_report_page.Click clear button

Verify the lms statusid 8 is showing properly
    delivery_report_page.Input so no   ${dom_00018['so_no15']}
    delivery_report_page.Click date clear button
    delivery_report_page.Click search button
    [Arguments]     ${expected_value}=6. เดินทางกลับจากลูกค้า
    ${status_column}=    delivery_report_page.Get lms status column
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}
    delivery_report_page.Click tab delivery report
    delivery_report_page.Click clear button

Verify the lms statusid 8.1 is showing properly
    delivery_report_page.Input so no   ${dom_00018['so_no16']}
    delivery_report_page.Click date clear button
    delivery_report_page.Click search button
    [Arguments]     ${expected_value}=6. เดินทางกลับจากลูกค้า
    ${status_column}=    delivery_report_page.Get lms status column
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}
    delivery_report_page.Click tab delivery report
    delivery_report_page.Click clear button
   
Verify the lms statusid 8.2 is showing properly
    delivery_report_page.Input so no   ${dom_00018['so_no17']}
    delivery_report_page.Click date clear button
    delivery_report_page.Click search button
    [Arguments]     ${expected_value}=6. เดินทางกลับจากลูกค้า
    ${status_column}=    delivery_report_page.Get lms status column
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}
    delivery_report_page.Click tab delivery report
    delivery_report_page.Click clear button

Verify the lms statusid 9 is showing properly
    delivery_report_page.Input so no   ${dom_00018['so_no18']}
    delivery_report_page.Click date clear button
    delivery_report_page.Click search button
    [Arguments]     ${expected_value}=6. เดินทางกลับจากลูกค้า
    ${status_column}=    delivery_report_page.Get lms status column
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}
    delivery_report_page.Click tab delivery report
    delivery_report_page.Click clear button

Verify the lms statusid and gi date is blank showing properly
    delivery_report_page.Input so no   ${dom_00018['so_no19']}
    delivery_report_page.Click date clear button
    delivery_report_page.Click search button
    [Arguments]     ${expected_value}=รอดำเนินการ GI สินค้า
    ${status_column}=    delivery_report_page.Get lms status column
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}
    delivery_report_page.Click tab delivery report
    delivery_report_page.Click clear button

Verify the lms statusid is null and gi date has value is showing properly
    delivery_report_page.Input so no   ${dom_00018['so_no20']}
    delivery_report_page.Click date clear button
    delivery_report_page.Click search button
    [Arguments]     ${expected_value}=ออกใบจ่ายสินค้า (GI) วันที่ 13/02/2024 13:44:03
    ${status_column}=    delivery_report_page.Get lms status column
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}
    delivery_report_page.Click tab delivery report
    delivery_report_page.Click clear button

    
Verify shipmentno in gps popup   
    [Arguments]     ${expected_value}=0114269925
    ${status_column}=    delivery_report_page.Get shipment value from gps popup
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}
    [Arguments]     ${expected_value1}=71-3371ฉช

Verify carregistrationno in gps popup   
    [Arguments]     ${expected_value}=71-3371ฉช
    ${status_column}=    delivery_report_page.Get Car registration value from gps popup
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}

Verify Currentposition in gps popup   
    [Arguments]     ${expected_value}=จระเข้หิน:ครบุรี:นครราชสีมา
    ${status_column}=    delivery_report_page.Get Currentposition value from gps popup
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}

Verify carrier in gps popup   
    [Arguments]     ${expected_value}=บจก.เอสซีจี เจดับเบิ้ลยูดี โลจิสติกส์
    ${status_column}=    delivery_report_page.Get carrier value from gps popup
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}

Verify speed in gps popup   
    [Arguments]     ${expected_value}=0 กม.
    ${status_column}=    delivery_report_page.Get speed value from gps popup
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}

Verify last signal received time in gps popup   
    [Arguments]     ${expected_value}=12/01/2024 15:52:13
    ${status_column}=    delivery_report_page.Get last signal received time value from gps popup
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}

Verify product payment number in gps popup   
    [Arguments]     ${expected_value}=0413401094
    ${status_column}=    delivery_report_page.Get product payment number value from gps popup
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}

Verify Place of delivery in gps popup   
    [Arguments]     ${expected_value}=โรงงานชลบุรี (TCCB)
    ${status_column}=    delivery_report_page.Get place of delivery value from gps popup
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}

Verify car status in gps popup   
    [Arguments]     ${expected_value}=4. เดินทางไปลูกค้า
    ${status_column}=    delivery_report_page.Get car status value from gps popup
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}

Verify destination arrival time in gps popup   
    [Arguments]     ${expected_value}=05/04/2024 08:37:00
    ${status_column}=    delivery_report_page.Get destination arrival time from gps popup
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}

Verify customer estimatiom time in gps popup   
    [Arguments]     ${expected_value}=05/04/2024 08:37:00
    ${status_column}=    delivery_report_page.Get customer estimation time from gps popup
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}
    
  

Verify remaining distance in gps popup   
    [Arguments]     ${expected_value}=56 กม.
    ${status_column}=    delivery_report_page.Get remaining distance time from gps popup
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}

Verify estimated time required in gps popup   
    [Arguments]     ${expected_value}=62 นาที
    ${status_column}=    delivery_report_page.Get estimated time required from gps popup
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}

Verify estimated arrival time required in gps popup   
    [Arguments]     ${expected_value}=05/04/2024 08:37:00
    ${status_column}=    delivery_report_page.Get estimated arrival time required from gps popup
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}

Verify distance from factory to customer in gps popup   
    [Arguments]     ${expected_value}=119 กม.
    ${status_column}=    delivery_report_page.Get distance from factory to customer from gps popup
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}

Verify date of invoice in gps popup   
    [Arguments]     ${expected_value}=04 / 04 / 2024
    ${status_column}=    delivery_report_page.Get date of invoice from gps popup
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}

Verify product delivery deadline in gps popup   
    [Arguments]     ${expected_value}=07 / 02 / 2024 14:30:00
    ${status_column}=    delivery_report_page.Get product delivery deadline from gps popup
    BuiltIn.Should be equal as strings     ${status_column}    ${expected_value}
    

Click tab delivery report
    common.Click element when ready         ${DELIVERY_REPORT.DELIVERY_REPORT.BUTTON}


Get sales organization
    ${sales_organization}=    common.Get text when ready      ${DELIVERY_REPORT.SALES_ORGANIZATION.TEXT}
    [Return]    ${sales_organization}

Get soldtocode
    ${soldto_code}=    common.Get text when ready      ${DELIVERY_REPORT.SOLD_TO.TEXTBOX}
    [Return]    ${soldto_code}

Get materialcode
    ${material_code}=    common.Get text when ready      ${DELIVERY_REPORT.MATERIAL_NO-GRADE_GRAM.TEXTBOX}
    [Return]    ${material_code}


Get pono
    ${po_no}=    common.Get text when ready      ${DELIVERY_REPORT.PO_NO.TEXTBOX}
    [Return]    ${po_no}

Get sono
    ${so_no}=    common.Get text when ready      ${DELIVERY_REPORT.SO_NO.TEXTBOX}
    [Return]    ${so_no}

Get lms status column
    ${status_column}=    common.Get text when ready      ${DELIVERY_REPORT.RESULT_TABLE.LMS_COLUMN_STATUS.TEXT}
    [Return]    ${status_column}

Get shipment value from gps popup
    ${status_column}=    common.Get text when ready      ${DELIVERY_REPORT.GPS_POPUP.SHIPMENTNO.TEXT}
    [Return]    ${status_column}

Get Car registration value from gps popup
    ${status_column}=    common.Get text when ready      ${DELIVERY_REPORT.GPS_POPUP.CARREGISTRATION.TEXT}
    [Return]    ${status_column}
    Log  "car registration number is ${status_column}"  console=True

Get Currentposition value from gps popup
    ${status_column}=    common.Get text when ready      ${DELIVERY_REPORT.GPS_POPUP.CURRENTPOSITION.TEXT}
    [Return]    ${status_column}
    Log  "car registration number is ${status_column}"  console=True

Get carrier value from gps popup
    ${status_column}=    common.Get text when ready      ${DELIVERY_REPORT.GPS_POPUP.CARRIER.TEXT}
    [Return]    ${status_column}
    Log  "carrier number is ${status_column}"  console=True

Get speed value from gps popup
    ${status_column}=    common.Get text when ready      ${DELIVERY_REPORT.GPS_POPUP.SPEED.TEXT}
    [Return]    ${status_column}
    Log  "speed is ${status_column}"  console=True

Get last signal received time value from gps popup
    ${status_column}=    common.Get text when ready      ${DELIVERY_REPORT.GPS_POPUP.LASTSIGNALRECIEVEDTIME.TEXT}
    [Return]    ${status_column}
    Log  "last signal recived time is ${status_column}"  console=True

Get product payment number value from gps popup
    ${status_column}=    common.Get text when ready      ${DELIVERY_REPORT.GPS_POPUP.PRODUCTPAYMENTNO.TEXT}
    [Return]    ${status_column}
    Log  "product payment no is ${status_column}"  console=True

Get place of delivery value from gps popup
    ${status_column}=    common.Get text when ready      ${DELIVERY_REPORT.GPS_POPUP.PLACEOFDELIVERY.TEXT}
    [Return]    ${status_column}
    Log  "PLACEOFDELIVERY is ${status_column}"  console=True

Get car status value from gps popup
    ${status_column}=    common.Get text when ready      ${DELIVERY_REPORT.GPS_POPUP.CARSTATUS.TEXT}
    [Return]    ${status_column}
    Log  "car status is ${status_column}"  console=True

Get destination arrival time from gps popup
    ${status_column}=    common.Get text when ready      ${DELIVERY_REPORT.GPS_POPUP.DESTINATIONARRIVALTIME.TEXT}
    [Return]    ${status_column}
    Log  "destination arrival time is ${status_column}"  console=True

Get customer estimation time from gps popup
    ${status_column}=    common.Get text when ready      ${DELIVERY_REPORT.GPS_POPUP.CUSTOMERESTIMATION.TEXT}
    [Return]    ${status_column}
    Log  "customer estimation time is ${status_column}"  console=True

Get remaining distance time from gps popup
    ${status_column}=    common.Get text when ready      ${DELIVERY_REPORT.GPS_POPUP.REMAININGDISTANCE.TEXT}
    [Return]    ${status_column}
    Log  "remaining is ${status_column}"  console=True

Get estimated time required from gps popup
    ${status_column}=    common.Get text when ready      ${DELIVERY_REPORT.GPS_POPUP.ESTIMATEDTIMEREQUIRED.TEXT}
    [Return]    ${status_column}
    Log  "estimated required is ${status_column}"  console=True

Get estimated arrival time required from gps popup
    ${status_column}=    common.Get text when ready      ${DELIVERY_REPORT.GPS_POPUP.ESTIMATEDARRIVALTIME.TEXT}
    [Return]    ${status_column}
    Log  "estimated arrival is ${status_column}"  console=True

Get distance from factory to customer from gps popup
    ${status_column}=    common.Get text when ready      ${DELIVERY_REPORT.GPS_POPUP.DISTCANCECUSTOMERTOFACTORY.TEXT}
    [Return]    ${status_column}
    Log  "distance from factory is ${status_column}"  console=True

Get date of invoice from gps popup
    ${status_column}=    common.Get text when ready      ${DELIVERY_REPORT.GPS_POPUP.DATEOFINVOICE.TEXT}
    [Return]    ${status_column}
    Log  "date of invoice is ${status_column}"  console=True

Get product delivery deadline from gps popup
    ${status_column}=    common.Get text when ready      ${DELIVERY_REPORT.GPS_POPUP.PRODUCTDELIVERYDEADLINE.TEXT}
    [Return]    ${status_column}
    Log  "date of invoice is ${status_column}"  console=True