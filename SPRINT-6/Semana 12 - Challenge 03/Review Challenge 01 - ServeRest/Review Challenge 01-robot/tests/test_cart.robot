*** Settings ***
Documentation    Estes testes são realizados na api ServeRest, englobando toda a parte de carrinho.
Resource    ../resources/test_cart.resource
Resource    ../resources/test_login.resource
Resource    ../resources/test_prod.resource

*** Test Cases ***

Cenario 01: Cadastrar um novo carrinho
    Criar um usuario novo
    Iniciar sessao na API serverest
    Cadastrar o usuario criado na ServeRest
    Realizar login com o usuario                             status_code_desejado=200
    Cadastrar um carrinho
    Conferir se o carrinho foi cadastrado com sucesso

Cenario 02: Listar carrinhos cadastrados
    Criar um usuario novo
    Iniciar sessao na API serverest
    Cadastrar o usuario criado na ServeRest
    Realizar login com o usuario                             status_code_desejado=200
    Buscar carrinhos cadastrados
    Conferir os carrinhos cadastrados

Cenario 03: Deletar um carrinho
    Criar um usuario novo
    Iniciar sessao na API serverest
    Cadastrar o usuario criado na ServeRest
    Realizar login com o usuario                             status_code_desejado=200
    Cadastrar um carrinho
    Conferir se o carrinho foi cadastrado com sucesso
    Realizar requisicao para deletar carrinho
    A API deve responder com codigo 200, deletar o carrinho