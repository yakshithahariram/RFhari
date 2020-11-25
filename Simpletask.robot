*** Settings ***
Library    SeleniumLibrary
Library    Telnet
Library    Collections

*** Test Cases ***
EveLoginTest
    Log    Login to EVE
    #Open Browser      ${URL}     chrome
    #Set Browser Implicit Wait    10
    #LoginEVE
    TelnetLogin
    #Close Browser


*** Variables ***
${URL}    http://192.168.1.246
${login_un}    admin
${login_pwd}   eve
@{portlistfromansible}    32769    32770    32771    32782

*** Keywords ***
LoginEVE
    Input Text         xpath:/html/body/div/div/div[3]/div[1]/input             ${login_un}
    Input Password     xpath:/html/body/div/div/div[3]/div[2]/input             ${login_pwd}
    Click Button       id=btnlogin
    Log    Login to EVE is successful

TelnetLogin
    FOR    ${portlistfromansible}    IN    @{portlistfromansible}
        ${status}=    Run Keyword And Return Status    Open Connection    192.168.1.246    port=${portlistfromansible}    prompt=$
        Run Keyword If    ${status}==True    Set Tags    ${portlistfromansible} is up
        Run Keyword If    ${status}==False   Set Tags   ${portlistfromansible} is down
        Close Connection
    END
