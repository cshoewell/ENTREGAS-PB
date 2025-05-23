import pytest
from divisao import dividir

def test_dividir_zero():
    with pytest.raises(ZeroDivisionError):
        dividir(10, 0)
        
def test_dividir_zero2():
    with pytest.raises(ZeroDivisionError) as exec_info:
        dividir(10, 0)
    assert "Divisão por zero não é permitida." in str(exec_info)