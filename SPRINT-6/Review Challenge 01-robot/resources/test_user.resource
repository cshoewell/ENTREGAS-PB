*** Settings ***
Documentation   Estes testes são realizados na api ServeRest, englobando toda a parte de usuarios.
Library  RequestsLibrary
Library  String
Library  Collections

*** Keywords ***
Criar um usuario novo
    ${random_word}  Generate Random String  length=4  chars=[LETTERS]
    ${random_word}  Convert To Lower Case   ${random_word}
    Set Test Variable     ${email_teste}  ${random_word}@emailteste.com
    Log  ${email_teste}

Cadastrar o usuario criado na ServeRest
    [Arguments]    ${email}    ${status_code_desejado}
    ${body}    Create Dictionary
    ...    nome=Gabriel Barbosa
    ...    email=${email}
    ...    password=4321
    ...    administrador=true
    Log    ${body}
    Criar sessao na ServeRest
    ${response}    POST On Session
    ...            alias=ServeRest
    ...            url=/usuarios
    ...            json=${body}
    ...            expected_status=${status_code_desejado}
    Log    ${response.json()}
    IF    ${response.status_code} == 201
        Set Test Variable    ${id_user}  ${response.json()["_id"]}
    END
    Set Test Variable    ${response}    ${response.json()}

Criar sessao na ServeRest
    ${headers}    Create Dictionary
    ...           accept=application/json
    ...           Content-Type=application/json
    Create Session    alias=ServeRest    url=https://compassuol.serverest.dev

Conferir se o usuario foi cadastrado corretamente
   Log    ${response}
   Dictionary Should Contain Item    ${response}    message    Cadastro realizado com sucesso
   Dictionary Should Contain Key    ${response}   _id

Repetir o cadastro do usuario
    Cadastrar o usuario criado na ServeRest    ${email_teste}    status_code_desejado=400

Verificar se a API não permitiu o cadastro repetido
    Dictionary Should Contain Item    ${response}    message    Este email já está sendo usado

Consultar os dados do novo usuario
    ${response_consult}    GET On Session
    ...                     alias=ServeRest
    ...                     url=/usuarios/${id_user}
    Set Test Variable    ${resp_consult}    ${response_consult.json()}

Conferir os dados retornados
    Log    ${resp_consult}
    Dictionary Should Contain Item    ${resp_consult}    nome           Gabriel Barbosa
    Dictionary Should Contain Item    ${resp_consult}    email          ${email_teste}
    Dictionary Should Contain Item    ${resp_consult}    password       4321
    Dictionary Should Contain Item    ${resp_consult}    administrador  true
    Dictionary Should Contain Item    ${resp_consult}    _id            ${id_user}

Realizar login com o usuario
    ${login_user_email_password}    Create Dictionary
    ...                             email=${email_teste}
    ...                             password=4321
    ${login_user_email_password}    POST On Session
    ...                             alias=ServeRest
    ...                             url=/login
    ...                             json=${login_user_email_password}
    Set Test Variable    ${login_user_complete}    ${login_user_email_password.json()}


Conferir se o login ocorreu com sucesso
    Dictionary Should Contain Item    ${login_user_complete}    message    Login realizado com sucesso

Deletar o usuario cadastrado
    ${response_consult}    DELETE On Session
    ...                    alias=ServeRest
    ...                    url=/usuarios/${id_user}
    Set Test Variable    ${resp_delete}    ${response_consult.json()}

Conferir se o usuario foi realmente deletado
    Dictionary Should Contain Item    ${resp_delete}    message    Registro excluído com sucesso

Editar informacoes do usuario
    ${novas_info}    Create Dictionary
    ...              nome=Gabriel B
    ...              password=1234
    ...              email=${email_teste}
    ...              administrador=true
    ${novas_info}    PUT On Session
    ...              alias=ServeRest
    ...              url=/usuarios/${id_user}
    ...              json=${novas_info}

Consultar os novos dados do usuario
    ${response_consult}    GET On Session
    ...                    alias=ServeRest
    ...                    url=/usuarios/${id_user}
    Set Test Variable    ${resp_consult}    ${response_consult.json()}

Conferir os dados retornados se estao editados
    Log    ${resp_consult}
    Dictionary Should Contain Item    ${resp_consult}    nome           Gabriel B
    Dictionary Should Contain Item    ${resp_consult}    email          ${email_teste}
    Dictionary Should Contain Item    ${resp_consult}    password       1234
    Dictionary Should Contain Item    ${resp_consult}    administrador  true