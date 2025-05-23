from funcoes import *

def test_email_valido():
    assert email_valido("exemplo@dominio.com") == True
    assert email_valido("exemplo@dominio") == False
    assert email_valido("exemplo.dominio.com") == False

def test_dividir():
    assert dividir(10, 2) == 5
    assert dividir(10, 0) == "Divisão por zero não é permitida."
    assert dividir(-10, -2) == 5
    assert dividir(10, -2) == -5   