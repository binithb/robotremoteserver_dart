*** Settings ***
Library           Remote    http://${ADDRESS}:${PORT}

*** Variables ***
${ADDRESS}        127.0.0.1
${PORT}           8270

*** Test Cases ***
Fly Spacecraft
    Log    Starting
    ${items2} =    Remote.describe
    Remote.takeOff    10
