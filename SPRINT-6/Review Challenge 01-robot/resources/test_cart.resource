*** Settings ***
Documentation   Estes testes são realizados na api ServeRest, englobando toda a parte de carrinho.
Library         RequestsLibrary
Library         Collections
Library         String
Library         BuiltIn
Library         JSONLibrary
Library         FakerLibrary   locale=pt_br
Resource        ../resources/test_login.resource
Resource        ../resources/test_prod.resource

*** Variables ***
${alias}                 ServeRest

*** Keywords ***
Cadastrar um produto
    ${random_prod}   FakerLibrary.Word   
    Set Suite Variable    ${random_prod}
    ${body}      Create Dictionary  
    ...          nome=${random_prod}   
    ...          preco=${preco_item}   
    ...          descricao=${desc_item}  
    ...          quantidade=${qtde_item}
    ${headers}   Create Dictionary  Authorization=${token}
    ${response_cadastro}  POST On Session
    ...                    alias=${alias}    
    ...                    url=produtos
    ...                    json=${body}   
    ...                    headers=${headers}
    Set Test Variable    ${response_cadastro}
    Log   Resposta Retornada: ${\n}${response_cadastro.text}

Conferir se o produto foi cadastrado com sucesso
    Dictionary Should Contain Item    ${response_cadastro.json()}    message    Cadastro realizado com sucesso
    ${id_prod_cadastrado}  Get From Dictionary    ${response_cadastro.json()}    _id
    Set Suite Variable   ${id_prod_cadastrado}

Cadastrar um carrinho
    test_cart.Cadastrar um produto
    test_cart.Conferir se o produto foi cadastrado com sucesso
    ${data}=   Convert String to JSON    {"produtos": [{"idProduto": "id", "quantidade": 1}]}
    ${data}=   Update value to JSON      ${data}     $..quantidade   ${qtde_item}
    ${data}=   Update value to JSON      ${data}     $..idProduto    ${id_prod_cadastrado}     
    # ${data}=   Update value to JSON      ${data}     $.produtos[1].idProduto    ${id_prod}     
    ${data}=   Evaluate      json.dumps(${data})     json
    # ${BODY}    Create Dictionary    idProduto=${id_prod_cadastrado}    
    ${headers}   Create Dictionary  Authorization=${token}
    ${response_carts}  POST On Session
    ...                alias=${alias}
    ...                url=carrinhos
    ...                headers=${headers}
    ...                data=${data}
    Set Suite Variable    ${response_carts}

Conferir se o carrinho foi cadastrado com sucesso
    Dictionary Should Contain Item    ${response_carts.json()}    message    Cadastro realizado com sucesso
    ${id_cart_cadastrado}  Get From Dictionary    ${response_carts.json()}    _id
    Set Suite Variable   ${id_cart_cadastrado}

Buscar carrinhos cadastrados
    ${headers}   Create Dictionary  Authorization=${token}
    ${response_listacarts}  GET On Session
    ...                     alias=${alias}
    ...                     url=carrinhos 
    ...                     headers=${headers}
    Set Suite Variable    ${response_listacarts}
    Set Test Variable      ${response_body}      ${response_listacarts.json()}

Conferir os carrinhos cadastrados
    FOR    ${carrinho}    IN   @{response_body['carrinhos']}
        ${qtde_total}=   Set Variable    ${0}
        ${preco_total}=        Set Variable    ${0}
        FOR    ${prod}    IN   @{carrinho['produtos']}
            Set Test Variable   ${qtde}       ${prod['quantidade']}
            Set Test Variable   ${preco_unit}   ${prod['precoUnitario']}
            ${qtde_total}=  Evaluate    ${qtde_total} + ${prod['quantidade']}
            ${preco_total}=       Evaluate    (${preco_unit} * ${prod['quantidade']}) + ${preco_total}
        END
        Set Test Variable  ${qtde_total}
        Set Test Variable  ${preco_total}
        Should Be Equal As Integers    ${carrinho['quantidadeTotal']}    ${qtde_total}
        Should Be Equal As Integers    ${carrinho['precoTotal']}    ${preco_total}

    END

Realizar requisicao para deletar carrinho
    ${headers}   Create Dictionary  Authorization=${token}
    ${response_deletcart}  DELETE On Session
    ...                    alias=${alias}
    ...                    url=carrinhos/concluir-compra
    ...                    headers=${headers}
    Log    ${response_deletcart}
    Set Test Variable    ${response_deletcart}   

A API deve responder com codigo 200, deletar o carrinho
    Should Be True  '${response_deletcart.status_code}'=='200'
    ...              msg=Erro na requisição! Verifique: ${response_deletcart}
    Dictionary Should Contain Item    ${response_deletcart.json()}    message        Registro excluído com sucesso