*** Settings ***
Library         SeleniumLibrary
Library         String
Library         Collections
Library         BuiltIn
# Library         REST
Library         RequestsLibrary
Library         OperatingSystem
Library         JSONLibrary
Library         DebugLibrary
Library         DateTime
# Library       AutoRecorder
# Library       Process
# Library       UtilitiesLibrary
# Library       requests_pkcs12
# Library       InternalLibrary
Library         DatabaseLibrary
Library         SSHLibrary
# Library       pprintpp

## Python lib
Library         ${CURDIR}${/}..${/}libs${/}helper.py

# Config
Variables       ${CURDIR}${/}..${/}settings${/}${env}${/}setting.yaml

# Test data
Variables       ${CURDIR}${/}..${/}testdata${/}${env}${/}test_data.yaml

## Keyword
Resource        ${CURDIR}${/}..${/}keywords${/}common${/}common.resource
Resource        ${CURDIR}${/}..${/}keywords${/}eordering${/}eordering_common.resource

Resource        ${CURDIR}${/}pages_keywords.resource
Resource        ${CURDIR}${/}pages_features_keywords.resource
Resource        ${CURDIR}${/}pages_locators.resource
Resource        ${CURDIR}${/}pages_api_keywords.resource