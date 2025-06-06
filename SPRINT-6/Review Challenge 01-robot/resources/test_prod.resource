*** Settings ***
Documentation   Estes testes são realizados na api ServeRest, englobando toda a parte de produtos.
Library         RequestsLibrary
Library         Collections
Library         String
Library         BuiltIn
Library         FakerLibrary   locale=pt_br
Resource        ../resources/test_login.resource

*** Variables ***
${alias}                 ServeRest
${preco_item}            6661
${desc_item}             Test Product
${qtde_item}            10

${preco_item_edit}       1999
${desc_item_edit}        Test Product Edited
${qtde_item_edit}       6

*** Keywords ***
Cadastrar um produto
    ${random_prod}   FakerLibrary.Word   
    Set Suite Variable    ${random_prod}
    ${body}      Create Dictionary  
    ...          nome=${random_prod} ${random_prod}   
    ...          preco=${preco_item}   
    ...          descricao=${desc_item}  
    ...          quantidade=${qtde_item}
    ${headers}   Create Dictionary  Authorization=${token}
    ${response_cadastro}  POST On Session
    ...                   alias=${alias}
    ...                   url=produtos 
    ...                   json=${body} 
    ...                   headers=${headers}
    Set Test Variable    ${response_cadastro}
    Log   Resposta Retornada: ${\n}${response_cadastro.text}

Conferir se o produto foi cadastrado com sucesso
    Dictionary Should Contain Item    ${response_cadastro.json()}    message    Cadastro realizado com sucesso
    ${id_prod_cadastrado}  Get From Dictionary    ${response_cadastro.json()}    _id
    Set Global Variable   ${id_prod_cadastrado}

Pesquisar produto previamente criado
    Criar um usuario novo
    Iniciar sessao na API serverest
    Cadastrar o usuario criado na ServeRest
    Realizar login com o usuario                         status_code_desejado=200              
    Cadastrar um produto    
    Conferir se o produto foi cadastrado com sucesso
    ${headers}   Create Dictionary  Authorization=${token}
    ${response_listaprod}  GET On Session
    ...                    alias=${alias}
    ...                    url=produtos/${id_prod_cadastrado} 
    ...                    headers=${headers}
    Set Suite Variable    ${response_listaprod}

Conferir as informacoes do produto
    Log   Resposta Retornada: ${\n}${response_listaprod.text}
    Dictionary Should Contain Item    ${response_listaprod.json()}    nome        ${random_prod} ${random_prod}
    ${preco_int}  Convert To Integer  ${preco_item}
    Dictionary Should Contain Item    ${response_listaprod.json()}    preco       ${preco_int}
    ${desc_int}   Convert To String  ${desc_item}
    Dictionary Should Contain Item    ${response_listaprod.json()}    descricao   ${desc_int}
    ${qtde_int}   Convert To Integer  ${qtde_item}
    Dictionary Should Contain Item    ${response_listaprod.json()}    quantidade  ${qtde_int}
    Dictionary Should Contain Key     ${response_listaprod.json()}    _id 

Excluir produto previamente criado
    Criar um usuario novo
    Iniciar sessao na API serverest
    Cadastrar o usuario criado na ServeRest
    Realizar login com o usuario                         status_code_desejado=200              
    Cadastrar um produto    
    Conferir se o produto foi cadastrado com sucesso
    ${headers}   Create Dictionary  Authorization=${token}
    ${response_deletprod}  DELETE On Session
    ...                    alias=${alias}
    ...                    url=produtos/${id_prod_cadastrado}
    ...                    headers=${headers}    
    Set Suite Variable    ${response_deletprod}

Conferir se o produto foi realmente excluido
    Log    ${response_deletprod}
    Dictionary Should Contain Item    ${response_deletprod.json()}    message        Registro excluído com sucesso

Tentar buscar o produto excluido
    [Arguments]    ${status_code_desejado}
    ${headers}   Create Dictionary  Authorization=${token}
    ${response_listaprod}  GET On Session
    ...                    alias=${alias} 
    ...                    url=produtos/${id_prod_cadastrado}
    ...                    headers=${headers} 
    ...                    expected_status=${status_code_desejado}
    Set Suite Variable    ${response_listaprod}

Conferir se o produto aparece na lista de produtos
    Dictionary Should Contain Item    ${response_listaprod.json()}    message    Produto não encontrado

Editar produto previamente criado
    Criar um usuario novo
    Iniciar sessao na API serverest
    Cadastrar o usuario criado na ServeRest
    Realizar login com o usuario                         status_code_desejado=200              
    Cadastrar um produto    
    Conferir se o produto foi cadastrado com sucesso
    ${headers}   Create Dictionary  Authorization=${token}
    ${body}      Create Dictionary  
    ...          nome=${random_prod}   
    ...          preco=${preco_item_edit}   
    ...          descricao=${desc_item_edit}  
    ...          quantidade=${qtde_item_edit}
    ${response_editprod}  PUT On Session
    ...                       alias=${alias}
    ...                       url=produtos/${id_prod_cadastrado}
    ...                       headers=${headers}
    ...                       json=${body}
    Set Suite Variable    ${response_editprod}

Conferir se o produto realmente foi editado
    Log    ${response_editprod}
    Dictionary Should Contain Item    ${response_editprod.json()}    message        Registro alterado com sucesso

Buscar o produto editado
    ${headers}   Create Dictionary  Authorization=${token}
    ${response_listaprod}  GET On Session
    ...                    alias=${alias}
    ...                    url=produtos/${id_prod_cadastrado}
    ...                    headers=${headers}
    Set Suite Variable    ${response_listaprod}

Conferir se o produto esta correto
    Log   Resposta Retornada: ${\n}${response_listaprod.text}
    Dictionary Should Contain Item    ${response_listaprod.json()}    nome        ${random_prod}
    ${preco_int}  Convert To Integer  ${preco_item_edit}
    Dictionary Should Contain Item    ${response_listaprod.json()}    preco       ${preco_int}
    ${desc_int}   Convert To String  ${desc_item_edit}
    Dictionary Should Contain Item    ${response_listaprod.json()}    descricao   ${desc_int}
    ${qtde_int}   Convert To Integer  ${qtde_item_edit}
    Dictionary Should Contain Item    ${response_listaprod.json()}    quantidade  ${qtde_int}
    Dictionary Should Contain Key     ${response_listaprod.json()}    _id 