import unittest      # Importa o módulo unittest para testes unitários
from calculadora import Calculadora     # Importa a classe Calculadora do arquivo calculadora.py
# Teste unitário para a classe Calculadora, que implementa operações matemáticas básicas.
# Os testes incluem soma, subtração, multiplicação, divisão, potência e raiz quadrada.
# Utiliza a biblioteca unittest para estruturar os testes e verificar os resultados esperados.
# Foi utilizado Copilot do VS Code para auxiliar na implementação do código

class TestCalculadora(unittest.TestCase):

    def setUp(self):
        """Configuração inicial para cada teste."""
        self.calculadora = Calculadora()

    def test_soma(self):
        self.assertEqual(self.calculadora.soma(2, 3), 5)
        self.assertEqual(self.calculadora.soma(-1, 5), 4)
        self.assertEqual(self.calculadora.soma(0, 0), 0)

    def test_subtrai(self):
        self.assertEqual(self.calculadora.subtrai(5, 2), 3)
        self.assertEqual(self.calculadora.subtrai(10, -3), 13)
        self.assertEqual(self.calculadora.subtrai(-9, 3), -12)
        self.assertEqual(self.calculadora.subtrai(0, 0), 0)

    def test_multiplica(self):
        self.assertEqual(self.calculadora.multiplica(2, 4), 8)
        self.assertEqual(self.calculadora.multiplica(-2, 5), -10)
        self.assertEqual(self.calculadora.multiplica(0, 10), 0)

    def test_dividi(self):
        self.assertEqual(self.calculadora.dividi(10, 2), 5)
        self.assertEqual(self.calculadora.dividi(15, 3), 5)
        with self.assertRaises(ValueError):
            self.calculadora.dividi(5, 0) # Espera-se que ocorra um erro ao dividir por zero
        self.assertEqual(self.calculadora.dividi(10, -2), -5)
        
    def test_potencia(self):
        self.assertEqual(self.calculadora.potencia(2, 2), 4)
        self.assertEqual(self.calculadora.potencia(-2, 5), -32)
        self.assertEqual(self.calculadora.potencia(0, 10), 0)    

    def test_raiz(self):
        self.assertEqual(self.calculadora.raiz(4), 2)
        self.assertEqual(self.calculadora.raiz(0), 0)
        with self.assertRaises(ValueError):
            self.calculadora.raiz(-4) # Espera-se que ocorra um erro ao calcular a raiz de um número negativo
        self.assertEqual(self.calculadora.raiz(9), 3)
    
    
if __name__ == '__main__':
    unittest.main()