*** Keywords ***
Call api to get eo number
    [Arguments]         ${contract}         ${poNo}         ${lotNo}
    ${uri}              BuiltIn.Set variable            ${API['EO_UPLOAD']['LP03']['URI']}contract=${contract}&poNo=${poNo}&lotNo=${lotNo}
    ${header}           BuiltIn.Create dictionary       Authorization=Bearer ${API['EO_UPLOAD']['TOKEN']}
    ${response}         common.Get request api          ${API['EO_UPLOAD']['URL']}      ${uri}     ${header}
    BuiltIn.Should be equal as strings          ${response.status_code}         200
    [Return]        ${response.json()}

Get eo number when upload eo and status change as expected
    [Arguments]         ${contract}         ${poNo}         ${lotNo}        ${expectedStatus}
        FOR     ${i}    IN RANGE    ${EO_UPLOAD['EO_COUNT']}
            ${lp03Response}    lp_03_api.Call api to get eo number     ${contract}       ${poNo}       ${lotNo}
            Exit for loop if   "${lp03Response['status']}" == "${expectedStatus}"
            BuiltIn.Sleep   ${TIME_SLEEP['XL']}
        END
    [Return]        ${lp03Response['eoNo']}