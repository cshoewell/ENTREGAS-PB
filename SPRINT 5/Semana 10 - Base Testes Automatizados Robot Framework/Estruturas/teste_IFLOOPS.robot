*** Settings ***
Documentation   Vamos aprender a fazer LOOPS usando o Robot Framework!!
Library    SeleniumLibrary

*** Variables ***

@{LISTA_DE_NUMEROS}   1  2  3  4  5  6  7  8  9  10  11  12  13  14  15

*** Test Case ***
Teste de imprimir números
    Imprimir somente se for 5 e 10

*** Keywords ***
Imprimir somente se for 5 e 10
    Log To Console    ${\n}
    FOR   ${NUMERO}   IN   @{LISTA_DE_NUMEROS}
        IF  ${NUMERO} == 5
            Log To Console  Eu sou o número 5!
        ELSE IF    ${NUMERO} == 10
            Log To Console  Eu sou o número 10!
        ELSE
            Log To Console  Eu não sou o número 5 e nem o 10!    
        END    
    END
