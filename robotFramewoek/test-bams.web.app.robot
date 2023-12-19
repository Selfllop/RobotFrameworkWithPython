*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem

Resource         ../PageObject/Landingpage.robot


*** Variables ***
${USERNAME}       standard_user
${PASSWORD}       secret_sauce


     
     

${URL}
*** Test Cases ***

Validate the login details
    Landingpage.Invoke the Broswer
    Landingpage.signin using login credentials     ${username}     ${password}
After login validate Page name
    Landingpage.Get the page Title
Verify Swag Labs Text in the web page
    Landingpage.Validate Swag Labs Text in the web page
Validate list of product
    Landingpage.Create list of product
Validate select any cart item    
    Landingpage.select any cart item        add-to-cart-sauce-labs-bolt-t-shirt
Validate that cart is opening
    Landingpage.open the cart
validate user able to check out
    Landingpage.Able to check out
    Landingpage.checkout form     ${firstname}    ${lastname}    ${zipcode}
    Landingpage.Item verification





