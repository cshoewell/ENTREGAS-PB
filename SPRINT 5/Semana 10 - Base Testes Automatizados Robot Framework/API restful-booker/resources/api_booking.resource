*** Settings ***
Library  RequestsLibrary
Library  String
Library  Collections


*** Variables ***
${url}      https://restful-booker.herokuapp.com


*** Keywords ***

Criar sessao na API
    ${header}    Create Dictionary  
    ...          Content-Type=application/json
    
    Create Session    alias=Restful-booker    url=${url}    headers=${header}

    ${header}    Create Dictionary  
    ...          Content-Type=application/json
    Log    ${header}

    ${body}    Create Dictionary
    ...        username=admin
    ...        password=password123
    Log    ${body}

Criar um token novo
    ${response}    POST On Session
    ...            alias=Restful-booker
    ...            url=/auth
    #...            json=${body}
   
    Set Test Variable        ${token}    ${response.json()}[token]
    Status Should Be     200

Conferir se o token foi criado corretamente
    Log    ${token}
    Status Should Be    200
    Should Not Be Empty  ${token}

Buscar uma lista de reservas
    ${response}  GET
    ...          url=${url}/booking
    Log  ${response.json()}

    Status Should Be    200
    Should Not Be Empty  ${response.json()}

Buscar uma reserva pelo ID
    Set Suite Variable    ${id}    5
    
    ${resposta}    GET    https://restful-booker.herokuapp.com/booking/${id}    
    Log    ${resposta}
    #Should Be Equal  ${id}    143
    Status Should Be    200
    Should Not Be Empty  ${resposta.json()}
       
Buscar uma reserva pelo nome
    ${body}    Create Dictionary    
    ...        firstname=Susan
    Log  ${body} 

    ${response.json()}  GET  https://restful-booker.herokuapp.com/booking?${body}
    Log    ${response.json()}
    Status Should Be    200   

Buscar uma reserva pela data
    ${body}    Create Dictionary    
    ...        checkin=2023-10-01
    ...        checkout=2023-10-10
   
    ${response}  GET
    ...          url=https://restful-booker.herokuapp.com/booking?${body}&${body}
    Log  ${response.json()}
    Status Should Be    200

Criar uma reserva
    ${header}    Create Dictionary
    ...          Content-Type=application/json
    ...          Accept=application/json
        
    ${body}    Create Dictionary
    ...        firstname=Carolina
    ...        lastname=Hoewell
    ...        totalprice=148
    ...        depositpaid=true
    ...        bookingdates=Create Dictionary
    ...            checkin=2024-10-01
    ...            checkout=2024-10-10
    ...        additionalneeds=Breakfast

    #Create Session    alias=Restful-booker    url=${url}    headers=${header}

    ${response}  POST
    ...          url=https://restful-booker.herokuapp.com/booking
    ...          json=${body}
    
    Set Test Variable        ${id}    ${response.json()}[bookingid]
    Log  ${id}
    Status Should Be    200
    Should Be Equal    ${response.json()}[firstname]    Carolina  
    Should Be Equal    ${response.json()}[lastname]    Hoewell
    Should Be Equal As Numbers    ${response.json()}[totalprice]    148
    Dictionary Should Contain Value     ${response.json()}    Carolina




Atualizar uma reserva
    ${header}    Create Dictionary
    ...          Content-Type=application/json
    ...          Accept=application/json
    ...          Cookie=${token}
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
    ...          Cookie=${token}
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
    ...          Cookie=${token}
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