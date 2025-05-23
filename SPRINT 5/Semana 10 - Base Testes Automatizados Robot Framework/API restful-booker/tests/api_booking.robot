*** Settings ***
Documentation    Testes API Booking
Resource  ../resources/api_booking.resource
Library  RequestsLibrary

*** Keywords ***


*** Test Cases ***
Cenário 01: Criar token de autenticacao
    Criar sessao na API
    Criar um token novo
    Conferir se o token foi criado corretamente

Cenário 02: Buscar reservas
    Buscar uma lista de reservas
    Buscar uma reserva pelo ID
    Buscar uma reserva pelo nome
    Buscar uma reserva pela data

Cenário 03: Criar uma reserva
    Criar uma reserva

Cenário 04: Atualizar uma reserva
    Atualizar uma reserva
    Atualizar parcialmente uma reserva

Cenário 05: Deletar uma reserva
    Deletar uma reserva

Cenário 05: Ping na API
    Realizar ping