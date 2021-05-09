*** Settings ***
Library     SeleniumLibrary
Variables   ../Credentials/login.py

*** Variables ***
${browser}=     chrome
${url}=         https://saraswatienterprises.herokuapp.com/
${login_page}=  https://saraswatienterprises.herokuapp.com/login/

*** Test Cases ***
Wrong Username Password
    Open browser                           ${login_page}        ${browser}
    input text          name:username      ${wrong_username}
    input text          name:password      ${wrong_password}
    Title Should Be     Login
    Sleep               2
Null Username Password
    input text          name:username       ""
    input text          name:password       ""
    Title Should Be     Login
    Sleep               2
Correct Login
    Go to                                  ${login_page}
    input text          name:username      ${username}
    input text          name:password      ${password}
    Submit Form         css:.login
    Title Should be     Dashboard
    Sleep               1
    Close all browsers