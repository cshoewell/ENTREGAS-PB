*** Settings ***
Documentation   Exemplo de uso de variáveis como argumentos em Keywords
Library    String

*** Variable ***
&{PESSOA}       nome=Carolina  sobrenome=Hoewell

*** Test Cases ***
Criando imprimindo e-mail customizado e aleatorio
    ${EMAIL_CRIADO}    Criar e-mail customizado e aleatório  ${PESSOA.nome}   ${PESSOA.sobrenome}
     Log To Console  ${EMAIL_CRIADO}

*** Keywords ***
Criar e-mail customizado e aleatório
    [Arguments]  ${NOME}  ${SOBRENOME}
    ${ALEATORIA}    Generate Random String
    ${EMAIL_FINAL}    Set Variable    ${ALEATORIA}@testerobot.com
    [Return]  ${EMAIL_FINAL}