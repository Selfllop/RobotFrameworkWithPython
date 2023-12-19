*** Settings ***
Documentation    All the page objects and keywords of landing page
Library           SeleniumLibrary
Library        Collections

*** Variables ***
${SwagLabs} =   css:.app_logo  
${Yourcart} =    css:.title
${Checkouttext} =     css:.title
${firstname} =     Rahul
${lastname} =     Bhowmick
${zipcode} =    712222
${CheckoutItem} =    css:.inventory_item_name
${expectedItemAtcehckout} =    Sauce Labs Bolt T-Shirt
${ItemPrice} =   xpath://div[@class='inventory_item_price']
${TotalPrice} =    xpath://div[@class='summary_info_label summary_total_label']
${Thankyoumessage} =    css:.complete-header
*** Keywords ***
Invoke the Broswer
    Create Webdriver    Chrome  executable_path=/Users/SUBHRAJYOTI/Downloads/chromedriver-win32/chromedriver-win32/chromedriver.exe
    Go to   https://www.saucedemo.com/
    Maximize Browser Window
signin using login credentials
    [Arguments]    ${username}    ${password}
    Input Text     id=user-name   ${username}
    Input Text     id=password   ${password}
    Click Element  id:login-button
Get the page Title
    Title Should Be    Swag Labs
Validate Swag Labs Text in the web page
    ${Text} =    Get Text    ${SwagLabs}
    Element Text Should Be    ${SwagLabs}    Swag Labs
Create list of product 
    @{expectedProdects} =    create list     Sauce Labs Backpack   Sauce Labs Bike Light    Sauce Labs Bolt T-Shirt    Sauce Labs Fleece Jacket    Sauce Labs Onesie    Test.allTheThings() T-Shirt (Red)
    ${elements} =    Get Webelements    css:.inventory_item
    @{actuallist} =    Create List    
    FOR  ${element}  IN   @{elements}
        Log    ${element.text}    
        Append TO List     ${actuallist}   ${element.text}    
    END
    Lists Should Be Equal       ${expectedProdects}     ${actuallist}
select any cart item
    [Arguments]    ${cartname}
    ${elements}=     Get Webelements    xpath://button[@id='add-to-cart']
    ${index} =     Set Variable     1
    FOR    ${element}    IN    @{elements}
       Exit For Loop If  ${cartname} == ${element.text}
       ${index}=    ${index} + 1
    END
    sleep     5
    Click Button     xpath:(//button[@id='${cartname}'])
open the cart
    Wait Until Element Is Visible     ${Yourcart}
    ${cartsymbol}=    Get Webelement    xpath://a[@class='shopping_cart_link']    
    Click Button    ${cartsymbol}
    Element Text Should Be     ${Yourcart}    Your Cart
Able to check out
    Click Button    xpath://button[@id='checkout']
    Wait Until Element Is Visible    ${Checkouttext}
    Element Text Should Be    ${Checkouttext}    Checkout: Your Information
checkout form
    [Arguments]    ${firstname}    ${lastname}    ${zipcode}
    Input Text    id:first-name    ${firstname}
    Input Text    id:last-name    ${lastname}
    Input Text    id:postal-code     ${zipcode}
    ${continue}=    Get Webelement    id:continue
    Click Button    ${continue}
Item verification
    Sleep    9

    Click Button                id:finish
    Element Text Should Be     ${Thankyoumessage}     Thank you for your order!
    Log    check out successfully 