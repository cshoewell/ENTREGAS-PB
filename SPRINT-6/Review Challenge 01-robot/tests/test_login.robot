*** Settings ***
Documentation    Estes testes são realizados na api ServeRest, englobando toda a parte de login.
Resource        ../resources/test_login.resource

*** Test Cases ***

Cenario 01: Efetuar o login como um novo usuario
    Criar um usuario novo
    Iniciar sessao na API serverest
    Cadastrar o usuario criado na ServeRest  
    Realizar login com o usuario                          status_code_desejado=200

Cenario 02: Efetuar o login como um novo usuario com erro
    Criar um usuario novo
    Iniciar sessao na API serverest
    Cadastrar o usuario criado na ServeRest  
    Realizar login com o usuario com erro                status_code_desejado=401
    