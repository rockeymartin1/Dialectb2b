*** Keywords ***
Post from ES13
    [Arguments]     ${customer_no}
    ${date} =	Get Current Date	result_format=datetime
    ${date}     Set variable    ${date.day}/${date.month}/${date.year}
    ${saleorg_1}=        BuiltIn.Create dictionary         saleOrg=${API['MULESOFT']['ES13']['SALEORG_1']}
    ${saleorg_2}=        BuiltIn.Create dictionary         saleOrg=${API['MULESOFT']['ES13']['SALEORG_2']}
    ${saleorglist}    Create list         ${saleorg_1}      ${saleorg_2}
    &{request_body}=        BuiltIn.Create dictionary
    Collections.Set to dictionary       ${request_body}        piMessageId=${API['MULESOFT']['PI_MESSAGE_ID']}
    ...       customerNo=${customer_no}     validFrom=${date}    validTo=${date}      docType=${API['MULESOFT']['ES13']['DOC_TYPE']}
    ...       saleOrgList=${saleorglist}
    ${reponse}=       common.Post request api
    ...         ${API['MULESOFT']['URL']}     ${API['MULESOFT']['ES13']['URI']}
    ...         headers=${API['MULESOFT']['HEADERS']}     json=${request_body}
    [Return]     ${reponse}

Get contract list
    [Arguments]     ${reponse_body}
    ${dic_contract_list}=     JSONLibrary.Get value from json   ${reponse_body.json()}   $..data
    ${count}        BuiltIn.Get length      ${dic_contract_list[0]}
    Set test variable     ${index}       1
    &{actual.data_api}=        BuiltIn.Create dictionary
    FOR  ${i}    IN RANGE    ${count}
        ${actual.contract_no}=     JSONLibrary.Get value from json   ${dic_contract_list[0][${i}]}   $..contractNo
        ${actual.contract_no}=     BuiltIn.Set variable         ${actual.contract_no}[0]
        &{actual.item}=        BuiltIn.Create dictionary
        ...     contract_no=${actual.contract_no}
        Collections.Set to dictionary       ${actual.data_api}      item_${index}=${actual.item}
        ${index}=        Evaluate        ${index}+1
        ${index}=        BuiltIn.Convert to string       ${index}
    END
    [Return]     ${actual.data_api}
