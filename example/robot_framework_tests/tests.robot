*** Settings ***
Library           Remote    http://${ADDRESS}:${PORT}    WITH NAME    Spacecraft

*** Variables ***
${ADDRESS}        127.0.0.1
${PORT}           8270

*** Test Cases ***
Fly Spacecraft
    Log    Starting
    ${items2} =    Spacecraft.describe
    Spacecraft.Return To Earth    10
