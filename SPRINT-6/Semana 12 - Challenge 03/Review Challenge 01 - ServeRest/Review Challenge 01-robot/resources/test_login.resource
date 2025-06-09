*** Settings ***
Documentation   Estes testes são realizados na api ServeRest, englobando toda a parte de login.
Library         RequestsLibrary
Library         Collections
Library         FakerLibrary   locale=pt_br


*** Variables ***
${alias}        ServeRest


*** Keywords ***
Criar um usuario novo
    ${random_first_name}   FakerLibrary.First Name
    ${random_last_name}    FakerLibrary.Last Name
    ${random_email}   FakerLibrary.Email
    ${random_senha}     FakerLibrary.Password
    ${user}    Create Dictionary    
    ...           nome=${random_first_name} ${random_last_name}  
    ...           email=${random_email}  
    ...           senha=${random_senha}
    Set Global Variable    ${user}

Iniciar sessao na API serverest
    ${headers}   Create Dictionary    
    ...          Content-Type=application/json
    Create Session
    ...            alias=${alias}
    ...            url=https://compassuol.serverest.dev
    ...            headers=${headers}

Cadastrar o usuario criado na ServeRest
    Criar um usuario novo
    ${body}      Create Dictionary   
    ...          nome=${user.nome}   
    ...          email=${user.email}   
    ...          password=${user.senha}   
    ...          administrador=true
    ${response}  POST On Session
    ...          alias=${alias}
    ...          url=usuarios
    ...          json=${body}
    Log   Resposta Retornada: ${\n}${response.text}

Realizar login com o usuario
    [Arguments]  ${status_code_desejado}
    ${body}      Create Dictionary   
    ...          email=${user.email}   
    ...          password=${user.senha}
    ${response}  POST On Session
    ...          alias=${alias}
    ...          url=login 
    ...          json=${body}  
    ...          expected_status=${status_code_desejado}
    Log   Resposta Retornada: ${\n}${response.text}
    Dictionary Should Contain Item    ${response.json()}    message    Login realizado com sucesso
    ${token}     Get From Dictionary    ${response.json()}    authorization
    Set Global Variable    ${token}

Realizar login com o usuario com erro
    [Arguments]  ${status_code_desejado}
    ${body}      Create Dictionary   
    ...          email=${user.email}  
    ...          password=${user.senha}erro
    ${response}  POST On Session
    ...          alias=${alias}
    ...          url=login
    ...          json=${body} 
    ...          expected_status=${status_code_desejado}
    Log   Resposta Retornada: ${\n}${response.text}
    Dictionary Should Contain Item    ${response.json()}    message    Email e/ou senha inválidos