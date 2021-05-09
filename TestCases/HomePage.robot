*** Settings ***
Library     SeleniumLibrary
Variables   ../Credentials/login.py

*** Variables ***
${browser}=     chrome
${url}=         https://saraswatienterprises.herokuapp.com/
${login_page}=  https://saraswatienterprises.herokuapp.com/login/

*** Test Cases ***
Home Page
    Open browser                        ${url}  ${browser}
    Page should contain element         css:.banner-heading
    Sleep                               2
    Close all browsers