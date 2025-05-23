*** Settings ***
Library  RequestsLibrary
Library  String
Library  Collections


*** Keywords ***
Criar um token novo
    ${body}    Create Dictionary
    ...        Content-Type=application/json
    ...        username=admin
    ...        password=password123
    
    ${response}    POST
    ...        url=https://restful-booker.herokuapp.com/auth
    ...        json=${body}
    Log    ${response.json()}
    
    ${token}    Set Variable    ${response.json()}[token]
    Log    ${token}
    Set Suite Variable    ${token}

Conferir se o token foi criado corretamente
    Set Suite Variable    ${response}   
    ${token}    Set Variable    ${response.json()}[token]
    Log  ${response}.json()
    Dictionary Should Contain Item  ${response}  token  abc123
    Status Should Be    200
    Should Not Be Empty  ${token}

Buscar uma lista de reservas
    ${response}  GET
    ...          url=https://restful-booker.herokuapp.com/booking
    Log  ${response.json()}

    Should Contain  ${response}  bookingid  
    Status Should Be    200
    Should Not Be Empty  ${response.json()}

Buscar uma reserva pelo ID
    ${header}    Create Dictionary  
    ...        Accept=application/json
   
    ${body}    Create Dictionary
    ...        firstname=John
    ...        lastname=Doe
    ...        totalprice=123
    ...        depositpaid=true
    ...        bookingdates=Create Dictionary
    ...            checkin=2023-10-01
    ...            checkout=2023-10-10
    ...        additionalneeds=Breakfast
    
    ${id}    Set Variable    ${response.json()}[bookingid]
    Set Suite Variable    ${response}
    Set Suite Variable    ${id}
    ${response}    GET    https://restful-booker.herokuapp.com/booking/${id}    
    Log    ${response.json()}
    Should Contain  ${response}  ${body}
    Status Should Be    200
    Should Not Be Empty  ${response.json()}

Buscar uma reserva pelo nome
    ${body}    Create Dictionary    
    ...        firstname=John
    ...        lastname=Doe
 
    ${response}  GET  url=https://restful-booker.herokuapp.com/booking/${body}
    Status Should Be    200
    Log List    ${response.json()}
    FOR  ${booking}  IN  @{response.json()}
        ${response}    GET    https://restful-booker.herokuapp.com/booking/${booking}[bookingid]
        TRY
            Log    ${response.json()}
        EXCEPT
            Log    Cannot retrieve JSON due to invalid data
        END
    END

Buscar uma reserva pela data
    ${body}    Create Dictionary    
    ...        checkin=2023-10-01
    ...        checkout=2023-10-10
   
    ${response}  GET
    ...          url=https://restful-booker.herokuapp.com/booking/${body}
    Status Should Be    200

Criar uma reserva
    ${header}    Create Dictionary
    ...          Content-Type=application/json
    ...          Accept=application/json
        
    ${body}    Create Dictionary
    ...        firstname=John
    ...        lastname=Doe
    ...        totalprice=123
    ...        depositpaid=true
    ...        bookingdates=Create Dictionary
    ...            checkin=2023-10-01
    ...            checkout=2023-10-10
    ...        additionalneeds=Breakfast

    ${response}  POST
    ...          url=https://restful-booker.herokuapp.com/booking  json=${body}
    ${id}    Set Variable    ${response.json()}[bookingid]
    Set Suite Variable    ${id}
    Status Should Be    200
    Should Be Equal    ${response.json()}[lastname]    Doe
    Should Be Equal    ${response.json()}[firstname]    John   
    Should Be Equal As Numbers    ${response.json()}[totalprice]    200
    Dictionary Should Contain Value     ${response.json()}    Doe

Atualizar uma reserva
    ${header}    Create Dictionary
    ...          Content-Type=application/json
    ...          Accept=application/json
    ...          Cookie=token\=${token}
    ...          Authorization=Basic YWRtaW46cGFzc3dvcmQxMjM=
    
    ${body}    Create Dictionary
    ...        firstname=James
    ...        lastname=Brown
    ...        totalprice=456
    ...        depositpaid=true
    ...        bookingdates=Create Dictionary
    ...            checkin=2023-02-01
    ...            checkout=2023-02-10
    ...        additionalneeds=Breakfast

    ${response}  PUT
    ...          url=https://restful-booker.herokuapp.com/booking/${id}  json=${body}
    Log  ${response.json()}
    Status Should Be    200
    Should Be Equal    ${response.json()}[lastname]    James
    Should Be Equal    ${response.json()}[firstname]    Brown   
    Should Be Equal As Numbers    ${response.json()}[totalprice]    456

Atualizar parcialmente uma reserva
    ${header}    Create Dictionary
    ...          Content-Type=application/json
    ...          Accept=application/json
    ...          Cookie=token\=${token}
    ...          Authorization=Basic YWRtaW46cGFzc3dvcmQxMjM=
    
    ${body}    Create Dictionary
    ...        totalprice=111
    
    ${response}  PATCH
    ...          url=https://restful-booker.herokuapp.com/booking/${id}  json=${body}
    Log  ${response.json()}
    Status Should Be    200
    Should Be Equal As Numbers    ${response.json()}[totalprice]    111

Deletar uma reserva
    ${header}    Create Dictionary
    ...          Cookie=token\=${token}
    ...          Authorization=Basic YWRtaW46cGFzc3dvcmQxMjM=
    ${body}    Create Dictionary
    ...        username=admin
    ...        password=password123
    ${response}    DELETE    url=https://restful-booker.herokuapp.com/booking/${id}    headers=${header} 
    Log    ${response.json()}
    Status Should Be    201    ${response}

Realizar ping
    ${response}  GET
    ...          url=https://restful-booker.herokuapp.com/ping
    Log  ${response.json()}
    Status Should Be    201
    Should Not Be Empty  ${response.json()}