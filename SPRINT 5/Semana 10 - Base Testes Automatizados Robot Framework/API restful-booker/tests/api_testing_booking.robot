*** Settings ***
Resource  ../resources/api_testing_booking.resource
Library  RequestsLibrary
Library  String

*** Keywords ***


*** Test Cases ***
Cenário 01: Criar token de autenticacao
    Criar um token novo
    Conferir se o token foi criado corretamente

Cenário 02: Buscar reservas
    Criar um token novo
    Conferir se o token foi criado corretamente
    Buscar uma lista de reservas
    Buscar uma reserva pelo ID
    Buscar uma reserva pelo nome
    Buscar uma reserva pela data

Cenário 03: Criar uma reserva
    Criar um token novo
    Conferir se o token foi criado corretamente
    Criar uma reserva

Cenário 04: Atualizar uma reserva
    Criar um token novo
    Conferir se o token foi criado corretamente
    Atualizar uma reserva
    Atualizar parcialmente uma reserva

Cenário 05: Deletar uma reserva
    Criar um token novo
    Conferir se o token foi criado corretamente
    Deletar uma reserva

Cenário 05: Ping na API
    Realizar ping