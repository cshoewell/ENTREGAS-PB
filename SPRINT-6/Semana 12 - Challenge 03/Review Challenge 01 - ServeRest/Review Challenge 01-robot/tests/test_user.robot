*** Settings ***
Documentation    Estes testes são realizados na api ServeRest, englobando toda a parte de usuário.
Resource  ../resources/test_user.resource

*** Test Cases ***
Cenário 01: Cadastrar um novo usuario com sucesso na ServeRest
    Criar um usuario novo
    Cadastrar o usuario criado na ServeRest    email=${email_teste}    status_code_desejado=201
    Conferir se o usuario foi cadastrado corretamente

Cenário 02: Cadastrar um usuario ja existente
    Criar um usuario novo
    Cadastrar o usuario criado na ServeRest   email=${email_teste}    status_code_desejado=201
    Repetir o cadastro do usuario    
    Verificar se a API não permitiu o cadastro repetido

Cenário 03: Consultar os dados de um novo usuario
    Criar um usuario novo
    Cadastrar o usuario criado na ServeRest    email=${email_teste}    status_code_desejado=201
    Consultar os dados do novo usuario
    Conferir os dados retornados

Cenário 04: Excluir usuario
    Criar um usuario novo
    Cadastrar o usuario criado na ServeRest  email=${email_teste}  status_code_desejado=201
    Consultar os dados do novo usuario
    Deletar o usuario cadastrado
    Conferir se o usuario foi realmente deletado

Cenário 05: Editar usuario
    Criar um usuario novo
    Cadastrar o usuario criado na ServeRest  email=${email_teste}  status_code_desejado=201
    Consultar os dados do novo usuario
    Editar informacoes do usuario
    Consultar os novos dados do usuario
    Conferir os dados retornados se estao editados