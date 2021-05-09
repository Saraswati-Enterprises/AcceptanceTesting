*** Settings ***
Library         SeleniumLibrary
Library         Collections
Variables       ../Credentials/login.py
Suite Setup     Open browser              ${login_page}        ${browser}
Suite Teardown  Close all browsers

*** Variables ***
${browser}=         chrome
${url}=             https://saraswatienterprises.herokuapp.com/
${login_page}=      https://saraswatienterprises.herokuapp.com/login/
${dashboard_url}=   https://saraswatienterprises.herokuapp.com/dashboard/

*** Test Cases ***
Login
    input text              name:username      ${username}
    input text              name:password      ${password}
    Submit Form             css:.login
    Sleep                   1
Dashboard
    Title Should Be                                         Dashboard
    Page Should Contain Element                             xpath:.//h3[contains(text(),"Bashisth Chaudhary")]
    Page Should Contain Element                             xpath:.//h3[contains(text(),"Abhishek Chaudhary")]
Get Recent Bill
    ${recent_bill_url}=     get element attribute           css:a[href="/bill/"]      href
    sleep                   2
    Go To                   ${recent_bill_url}
    Title Should be         Bills
    ${first_bill_url}=      get element attribute            xpath:(.//a[contains(@href,"bill")])[1]    href
    Go to                   ${first_bill_url}
    Log to console          ${first_bill_url}
    sleep                   2
View Recent Bill
    Title Should Be         Info
    ${ele}=                 Get WebElement                  css:#generate-files
    Execute Javascript      arguments[0].click();           ARGUMENTS    ${ele}
    sleep                   2
View Products
    Go To                   ${dashboard_url}
    ${product_ele}=         Get WebElement                  xpath:.//a[contains(text(),'Products List')]
    Execute Javascript      arguments[0].click();           ARGUMENTS    ${product_ele}
    sleep                   1
    ${elements_count}=      Get Element Count               xpath:.//td/a
    Log to console          ${elements_count}
    FOR     ${element}          IN RANGE                       1    ${elements_count}
        ${link}=            get element attribute              xpath:(.//td/a)[${element}]   href
        ${link_text}=       Get Text                           xpath:(.//td/a)[${element}]
        Log to console      ${link_text}
        Go To               ${link}
        Title Should Be   ${link_text}
        sleep               1
        Go Back
    END

