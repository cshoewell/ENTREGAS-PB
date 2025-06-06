*** Settings ***
Documentation    Estes testes são realizados na api ServeRest, englobando toda a parte de produtos.
Resource    ../resources/test_prod.resource
Resource    ../resources/test_login.resource

*** Test Cases ***
Cenario 01: Cadastrar um produto
    Criar um usuario novo
    Iniciar sessao na API serverest
    Cadastrar o usuario criado na ServeRest
    Realizar login com o usuario                             status_code_desejado=200              
    Cadastrar um produto    
    Conferir se o produto foi cadastrado com sucesso

Cenario 02: Listar produtos cadastrados
    Pesquisar produto previamente criado
    Conferir as informacoes do produto

Cenario 03: Excluir produto
    Excluir produto previamente criado
    Conferir se o produto foi realmente excluido
    Tentar buscar o produto excluido                         status_code_desejado=400
    Conferir se o produto aparece na lista de produtos

Cenario 04: Editar produto
    Editar produto previamente criado
    Conferir se o produto realmente foi editado
    Buscar o produto editado
    Conferir se o produto esta correto