*** Keywords ***
Upload eo with lp-01
    [Arguments]         ${requestBody}
    ${header}        BuiltIn.Create dictionary      Content-Type=${API['MULESOFT']['HEADERS']['CONTENT-TYPE']}
    ...     Authorization=Bearer ${API['EO_UPLOAD']['TOKEN']}
    ${response}      RequestsLibrary.POST           url=${API['EO_UPLOAD']['URL']}${API['EO_UPLOAD']['LP01']['URI']}
    ...     json=${requestBody}
    ...     headers=${header}
    BuiltIn.Should be equal as strings          ${response.status_code}         204

Create lp-01 initial request
    [Arguments]       ${eoNo}
    ...     ${contract}
    ...     ${division}
    ...     ${salesOrg}
    ...     ${order_type}
    ...     ${changeType}
    ...     ${salesOffice}
    ...     ${contractType}
    ...     ${createAndChangeType}
    ...     ${distributionChannel}

    ${time}                     BuiltIn.Get time                            year,month,day
    ${genNumber}                String.Generate random string               5                       [NUMBERS]
    ${lotNo}                    BuiltIn.Catenate                            SEPARATOR=_             ${time}[0]${time}[1]${time}[2]          ${gen_number}

    ${nextDay}                  helper.Get future date from current         1
    ${nextDay}                  String.Split string                         ${nextDay}         -
    ${requestDeliveryDate}      BuiltIn.Set variable                        ${nextDay}[2].${nextDay}[1].${nextDay}[0]

    ${bodyInitial}      BuiltIn.Create dictionary      eoNo=${eoNo}
    ...     lotNo=${lotNo}
    ...     contract=${contract}
    ...     division=${division}
    ...     salesOrg=${salesOrg}
    ...     orderType=${order_type}
    ...     changeType=${changeType}
    ...     salesOffice=${salesOffice}
    ...     contractType=${contractType}
    ...     createAndChangeType=${createAndChangeType}
    ...     distributionChannel=${distributionChannel}
    ...     requestDeliveryDate=${requestDeliveryDate}
    [Return]    ${bodyInitial}

Create lp-01 header request
    [Arguments]         ${cc}
    ...     ${ETA}
    ...     ${ETD}
    ...     ${uom}
    ...     ${poNo}
    ...     ${dlcNo}
    ...     ${gwUom}
    ...     ${payer}
    ...     ${usage}
    ...     ${author}
    ...     ${billTo}
    ...     ${remark}
    ...     ${shipTo}
    ...     ${soldTo}
    ...     ${incoterms}
    ...     ${salesEmail}
    ...     ${salesGroup}
    ...     ${description}
    ...     ${docCurrency}
    ...     ${endCustomer}
    ...     ${paymentTerm}
    ...     ${shippingMark}
    ...     ${contractPerson}
    ...     ${dlcExpiryDate}
    ...     ${salesEmployee}
    ...     ${noOfContainers}
    ...     ${unloadingPoint}
    ...     ${placeOfDelivery}
    ...     ${portOfDischarge}
    ...     ${productInformation}
    ...     ${paymentInstruction}
    ...     ${dlcLatestDeliveryDate}
    ...     ${internalCommentToWarehouse}

    ${bodyHeader}       BuiltIn.Create dictionary      cc=${cc}
    ...     ETA=${ETA}
    ...     ETD=${ETD}
    ...     uom=${uom}
    ...     poNo=${poNo}
    ...     dlcNo=${dlcNo}
    ...     gwUom=${gwUom}
    ...     payer=${payer}
    ...     usage=${usage}
    ...     author=${author}
    ...     billTo=${billTo}
    ...     remark=${remark}
    ...     shipTo=${shipTo}
    ...     soldTo=${soldTo}
    ...     incoterms=${incoterms}
    ...     salesEmail=${salesEmail}
    ...     salesGroup=${salesGroup}
    ...     description=${description}
    ...     docCurrency=${docCurrency}
    ...     endCustomer=${endCustomer}
    ...     paymentTerm=${paymentTerm}
    ...     shippingMark=${shippingMark}
    ...     contractPerson=${contractPerson}
    ...     dlcExpiryDate=${dlcExpiryDate}
    ...     salesEmployee=${salesEmployee}
    ...     noOfContainers=${noOfContainers}
    ...     unloadingPoint=${unloadingPoint}
    ...     placeOfDelivery=${placeOfDelivery}
    ...     portOfDischarge=${portOfDischarge}
    ...     productInformation=${productInformation}
    ...     paymentInstruction=${paymentInstruction}
    ...     dlcLatestDeliveryDate=${dlcLatestDeliveryDate}
    ...     internalCommentToWarehouse=${internalCommentToWarehouse}
    [Return]        ${bodyHeader}

Create lp-01 items request
    [Arguments]         ${unit}
    ...     ${plant}
    ...     ${price}
    ...     ${route}
    ...     ${remark}
    ...     ${eoItemNo}
    ...     ${palletNo}
    ...     ${itemCatEo}
    ...     ${itemCatPi}
    ...     ${noOfRolls}
    ...     ${commission}
    ...     ${palletSize}
    ...     ${refPiStock}
    ...     ${noOfPackage}
    ...     ${materialCode}
    ...     ${rejectReason}
    ...     ${orderQuantity}
    ...     ${priceCurrency}
    ...     ${conditionGroup1}
    ...     ${packingListText}
    ...     ${rollDiameterInch}
    ...     ${commissionPercent}
    ...     ${reamRollPerPallet}
    ...     ${commissionCurrency}
    ...     ${rollCoreDiameterInch}

    ${bodyItems}       BuiltIn.Create dictionary       unit=${unit}
    ...     plant=${plant}
    ...     price=${price}
    ...     route=${route}
    ...     remark=${remark}
    ...     eoItemNo=${eoItemNo}
    ...     palletNo=${palletNo}
    ...     itemCatEo=${itemCatEo}
    ...     itemCatPi=${itemCatPi}
    ...     noOfRolls=${noOfRolls}
    ...     commission=${commission}
    ...     palletSize=${palletSize}
    ...     refPiStock=${refPiStock}
    ...     noOfPackage=${noOfPackage}
    ...     materialCode=${materialCode}
    ...     rejectReason=${rejectReason}
    ...     orderQuantity=${orderQuantity}
    ...     priceCurrency=${priceCurrency}
    ...     conditionGroup1=${conditionGroup1}
    ...     packingListText=${packingListText}
    ...     rollDiameterInch=${rollDiameterInch}
    ...     commissionPercent=${commissionPercent}
    ...     reamRollPerPallet=${reamRollPerPallet}
    ...     commissionCurrency=${commissionCurrency}
    ...     rollCoreDiameterInch=${rollCoreDiameterInch}
    [Return]        ${bodyItems}