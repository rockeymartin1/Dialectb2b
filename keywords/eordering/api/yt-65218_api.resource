*** Keywords ***
Change order status
    [Arguments]    ${request_body}
    ${header}=    BuiltIn.Create dictionary    Content-Type=${API['MULESOFT']['HEADERS']['CONTENT-TYPE']}
    ...     clientId=${API['MULESOFT']['HEADERS']['CLIENTID']}
    ...     clientSecret=${API['MULESOFT']['HEADERS']['CLIENTSECRET']}

    ${response}=    RequestsLibrary.POST     url=${API['MULESOFT']['URL']}${API['MULESOFT']['YT-65218']['URI']}
    ...     headers=${header}
    ...     json=${request_body}

    BuiltIn.Should be equal as strings    ${response.status_code}    202
    [Return]    ${response.json()}

Get order status request
    [Arguments]    ${update_id}    ${order_status_request_lines}
    ${order_status_request}=    BuiltIn.Create dictionary    updateId=${update_id}     orderStatusRequestLine=${order_status_request_lines}
    ${request_body}=    BuiltIn.Create dictionary    orderStatusRequest=${order_status_request}
    [Return]    ${request_body}

Get order status request line
    [Arguments]    ${order_number}
    ...     ${line_number}
    ...     ${confirmed_availability_date}
    ...     ${status_date}
    ...     ${quantity}
    ...     ${re_ATP_quantity}
    ...     ${unit}
    ...     ${re_ATP_status}
    ...     ${operation_status}
    ...     ${warehouse_code}
    ...     ${for_attention}
    ...     ${order_type}
    ...     ${dispatch_date}

    ${order_status_request_lines}=    BuiltIn.Create dictionary       orderNumber=${order_number}
    ...     lineNumber=${line_number}
    ...     confirmedAvailabilityDate=${confirmed_availability_date}
    ...     statusDate=${status_date}
    ...     quantity=${quantity}
    ...     reATPQuantity=${re_ATP_quantity}
    ...     unit=${unit}
    ...     reATPStatus=${re_ATP_status}
    ...     operationStatus=${operation_status}
    ...     warehouseCode=${warehouse_code}
    ...     forAttention=${for_attention}
    ...     orderType=${order_type}
    ...     dispatchDate=${dispatch_date}

    [Return]    ${order_status_request_lines}