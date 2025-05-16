class Calculadora:
    def soma(self, a, b):
        return a + b

    def subtrai(self, a, b):
        return a - b

    def multiplica(self, a, b):
        return a * b

    def dividi(self, a, b):
        if b == 0:
            raise ValueError("Não é possível dividir por zero")
        return a / b
    
    def potencia(self, a, b):
        return a ** b
    
    def raiz(self, a):
        if a < 0:
            raise ValueError("Não é possível calcular a raiz quadrada de um número negativo")
        return a ** 0.5 