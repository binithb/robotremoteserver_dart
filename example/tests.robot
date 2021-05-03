*** Settings ***
Library           Remote    http://${ADDRESS}:${PORT}    WITH NAME    Spacecraft

*** Variables ***
${ADDRESS}        127.0.0.1
${PORT}           8270

*** Test Cases ***
Describe spacecraft
    ${spacecraft details} =    Spacecraft.describe
    Log    ${spacecraft details}

Return to earth
    Spacecraft.Return To Earth    10
