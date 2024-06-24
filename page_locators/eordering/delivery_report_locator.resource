*** Variables ***
${DELIVERY_REPORT.HEADER.TEXT}                                     //div[text()="Pending Order"]
${DELIVERY_REPORT.SALES_ORGANIZATION.TEXT}                         //div[@id='mui-component-select-saleOrganization']
${DELIVERY_REPORT.FROMDATE.TEXT}                                   //input[@id='mui-1']
${DELIVERY_REPORT.TODATE.TEXT}                                     //input[@id='mui-2']
${DELIVERY_REPORT.SOLD_TO.TEXTBOX}                                 //input[@placeholder="ค้นหา Sold-to"]
${DELIVERY_REPORT.SOLD_TO.BALLOON.TEXTBOX}                         //li/span[text()="{sold_to}"]
${DELIVERY_REPORT.PO_NO.TEXTBOX}                                   //input[@name="poNo"]
${DELIVERY_REPORT.SO_NO.TEXTBOX}                                   //input[@name="soNo"]
${DELIVERY_REPORT.SEARCH.BUTTON}                                   //button/span[text()="ค้นหา"]
${DELIVERY_REPORT.DATECLEAR.BUTTON}                                //button/span[text()="ล้างวันที่"]
${DELIVERY_REPORT.MATERIAL_NO-GRADE_GRAM.TEXTBOX}                  //input[@placeholder="ค้นหา Material Code / Description"]
${DELIVERY_REPORT.MATERIAL_NO-GRADE_GRAM.BALLOON.TEXTBOX}          //li/span[text()="{material_no}"]



${DELIVERY_REPORT.RELATED_ITEM.TEXT}                                 (//div[contains(text(),"รายการที่เกี่ยวข้อง")])[2]
${DELIVERY_REPORT.RESULT_TABLE.PO_NO.TEXT}                           //tbody/tr[1]/td[3]/div[1]
${DELIVERY_REPORT.RESULT_TABLE.SO_NO.TEXT}                           //tbody/tr[1]/td[4]/div[1]
${DELIVERY_REPORT.RESULT_TABLE.MAT_NO.TEXT}                          //tbody/tr[1]/td[6]/div[1]
${DELIVERY_REPORT.RESULT_TABLE.LMS_COLUMN_STATUS.TEXT}               //tbody/tr[1]/td[18]/div[1]
${DELIVERY_REPORT.RESULT_TABLE.LMS_COLUMN_GPS.BUTTON}                //tbody/tr[1]/td[1]/*[1]

${DELIVERY_REPORT.GPS_POPUP.SHIPMENTNO.TEXT}                         //div[contains(text(),'0114269925')]
${DELIVERY_REPORT.GPS_POPUP.CARREGISTRATION.TEXT}                    (//div[contains(text(),"71-3371ฉช")])[2]
${DELIVERY_REPORT.GPS_POPUP.CURRENTPOSITION.TEXT}                    (//div[contains(text(),"จระเข้หิน:ครบุรี:นครราชสีมา")])
${DELIVERY_REPORT.GPS_POPUP.CARRIER.TEXT}                            (//div[contains(text(),"บจก.เอสซีจี เจดับเบิ้ลยูดี โลจิสติกส์")])
${DELIVERY_REPORT.GPS_POPUP.SPEED.TEXT}                              (//div[contains(text(),"0 กม.")])
${DELIVERY_REPORT.GPS_POPUP.LASTSIGNALRECIEVEDTIME.TEXT}             (//div[contains(text(),"12/01/2024 15:52:13")])
${DELIVERY_REPORT.GPS_POPUP.PRODUCTPAYMENTNO.TEXT}                   (//div[contains(text(),"0413401094")])
${DELIVERY_REPORT.GPS_POPUP.PLACEOFDELIVERY.TEXT}                    (//div[contains(text(),"โรงงานชลบุรี (TCCB)")])
${DELIVERY_REPORT.GPS_POPUP.CARSTATUS.TEXT}                          (//div[contains(text(),"4. เดินทางไปลูกค้า")])
${DELIVERY_REPORT.GPS_POPUP.DESTINATIONARRIVALTIME.TEXT}             (//div[contains(text(),"05/04/2024 08:37:00")])
${DELIVERY_REPORT.GPS_POPUP.CUSTOMERESTIMATION.TEXT}                 (//div[contains(text(),"05/04/2024 08:37:00")])
${DELIVERY_REPORT.GPS_POPUP.REMAININGDISTANCE.TEXT}                  (//div[contains(text(),"56 กม.")])
${DELIVERY_REPORT.GPS_POPUP.ESTIMATEDTIMEREQUIRED.TEXT}              (//div[contains(text(),"62 นาที")])
${DELIVERY_REPORT.GPS_POPUP.ESTIMATEDARRIVALTIME.TEXT}               (//div[contains(text(),"05/04/2024 08:37:00")])
${DELIVERY_REPORT.GPS_POPUP.DISTCANCECUSTOMERTOFACTORY.TEXT}         (//div[contains(text(),"119 กม.")])
${DELIVERY_REPORT.GPS_POPUP.DATEOFINVOICE.TEXT}                      (//div[contains(text(),"04 / 04 / 2024")])
${DELIVERY_REPORT.GPS_POPUP.PRODUCTDELIVERYDEADLINE.TEXT}            (//div[contains(text(),"07 / 02 / 2024 14:30:00")])

${DELIVERY_REPORT.CLEAR.BUTTON}                                      //button[span[text()="ล้างข้อมูล"]]
${DELIVERY_REPORT.DELIVERY_REPORT.BUTTON}                            //div[div[text()="ค้นหา Delivery Report (LMS)"]]
