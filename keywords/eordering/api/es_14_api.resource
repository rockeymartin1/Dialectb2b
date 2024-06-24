*** Keywords ***
Get from ES14
    [Arguments]     ${contract}     ${piMessageId}
    BuiltIn.Set test variable       ${uri_contract}     ${API['MULESOFT']['ES14']['URI']}${contract}?piMessageId=${piMessageId}&contractNo=${contract}
    ${reponse}=       common.Get request api
    ...         alias=${API['MULESOFT']['URL']}     uri=${uri_contract}
    ...         headers=${API['MULESOFT']['HEADERS']}
    [Return]     ${reponse}

# Get remain quantity
#     [Arguments]     ${reponse_body}     ${product_name}
#     ${dic_contract_item}=     JSONLibrary.Get value from json   ${reponse_body.json()}   $..contractItem
#     ${count}        BuiltIn.Get length      ${dic_contract_item[0]}
#     Log to console    ${dic_contract_item[0]}
#     Log to console    ${dic_contract_item[0]['rejectReason']}
#     FOR  ${i}    IN RANGE    ${count}
#         IF    '${dic_contract_item[${i}]['matNo']}' == '${product_name}' AND '${dic_contract_item[${i}]['rejectReason']}' == '${EMPTY}'
#             ${remainqty_api}=     JSONLibrary.Get value from json   ${dic_contract_item[${i}]}   $..RemainQty
#             BuiltIn.Exit For Loop
#         END
#     END
#     [Return]     ${remainqty_api}

Get remain quantity
    [Arguments]     ${reponse_body}     ${product_name}
    ${dic_contract_item}=     JSONLibrary.Get value from json   ${reponse_body.json()}   $..contractItem
    ${count}        BuiltIn.Get length      ${dic_contract_item[0]}
    FOR  ${i}    IN RANGE    ${count}
        ${mat_no}=     JSONLibrary.Get value from json   ${dic_contract_item[0][${i}]}   $..matNo
        ${isNotRejected}=    BuiltIn.Run keyword and return status    JSONLibrary.Should not have value in json    ${dic_contract_item[0][${i}]}    $..rejectReason
        IF   '${mat_no[0]}' == '${product_name}' and '${isNotRejected}' == 'True'
                ${remainqty_api}=     JSONLibrary.Get value from json   ${dic_contract_item[0][${i}]}   $..RemainQty
                ${remainqty_api}=     BuiltIn.Set variable         ${remainqty_api[0]}
                BuiltIn.Exit For Loop
        END
    END
    [Return]     ${remainqty_api}