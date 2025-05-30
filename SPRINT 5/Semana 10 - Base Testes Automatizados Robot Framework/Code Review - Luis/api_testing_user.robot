*** Settings ***
Resource  ../Code Review - Luis/api_testing_user.resource
Documentation  Testes de API - ReqRes - Luis

*** Test Cases ***
Cenário: POST Fazer login
    Criar sessão no ReqRes
    POST Endpoint /login
    Validar status code "200"

Cenário: POST Fazer login UNSUCCESSFUL
    Criar sessão no ReqRes
    POST Endpoint /login - sem senha
    Validar status code "400"

Cenário: POST Logout
    Criar sessão no ReqRes
    POST Endpoint /logout
    Validar status code "200"

Cenário: POST Cadastro de usuário
    [tags]    POST    user
    Criar sessão no ReqRes
    POST Endpoint /register
    Validar status code "200"

Cenário: POST Cadastro de usuário UNSUCCESSFUL
    [tags]    POST    user
    Criar sessão no ReqRes
    POST Endpoint /register - sem senha
    Validar status code "400"

Cenário: GET Listar todos os usuários
    [Tags]    GET     user
    Criar sessão no ReqRes
    GET Endpoint /users
    Validar status code "200"

Cenário: GET Listar um usuário
    [Tags]    GET    user
    Criar sessão no ReqRes
    GET Endpoint /users/id
    Validar status code "200"

Cenário: PUT Editar um usuário
    [tags]    PUT    user
    Criar sessão no ReqRes
    PUT Endpoint /users/id
    Validar status code "200"

Cenário: PATCH Editar um usuário
    [Tags]    PATCH    user
    Criar sessão no ReqRes
    PATCH Endpoint /users/id
    Validar status code "200"

Cenário: DELETE Excluir um usuário
    [Tags]    DELETE    user
    Criar sessão no ReqRes
    DELETE Endpoint /users/id
    Validar status code "200"

Cenário: GET Listar um recurso
    [Tags]    GET    resource
    Criar sessão no ReqRes
    GET Endpoint /resource/id
    Validar status code "200"

Cenário: PUT Editar um recurso
    [Tags]    PUT    resource
    Criar sessão no ReqRes
    PUT Endpoint /resource/id
    Validar status code "200"

Cenário: DELETE Excluir um recurso
    [Tags]    DELETE    resource
    Criar sessão no ReqRes
    DELETE Endpoint /resource/id
    Validar status code "200"

Cenário: GET Listar todos os recursos
    [Tags]    GET    resource
    Criar sessão no ReqRes
    GET Endpoint /resource
    Validar status code "200"