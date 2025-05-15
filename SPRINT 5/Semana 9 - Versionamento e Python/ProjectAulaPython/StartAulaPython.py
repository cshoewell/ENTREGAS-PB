print ('Hello World')
print('Meu nome e Carolina')
print('Eu tenho ' + '41 anos\n')

#estudo de variaveis
personagem_nome = 'Mike'
personagem_idade = '19'
personagem_esporte = 'Baseball'
personagem_hrvagas = 'GTA'

print('Meu nome e ' + personagem_nome + ',')
print('eu tenho ' + personagem_idade + '.')
print('Meu esporte favorito e ' + personagem_esporte + ',')
print('e eu gosto de jogar ' + personagem_hrvagas + ' nas minhas horas vagas.\n')

#como utilizar aspas simples dentro de aspas simples
print('Marco\'s da Silva')

#estudo de concatenação (utilizando 2 tipos de variaveis no mesmo print)
nome = 'Marcos da Silva'
print(nome)
print(nome + ' tem 19 anos de idade')

#estudo de funçoes
nome = 'Marcos da Silva'
print(nome.upper())
print(nome.lower())
print(len(nome))
print(nome[5])
print(nome.index('da'))
print(nome.count('a'))
print('\n')

#estudo de utilzaçao de numeros
print(8)
print(4+2)
print(4+2.5689247)
print(2*2+5)
print(2*(2+5))
print('\n')

num1 = 5
num2 = 10
print(num1 + num2)
#como imprimir numero com sequencia de frase, transforma o numero em string
print(str(num1) + ' e o meu numero da sorte.\n')

#estudo de funçoes matematicas
print(min(2, 8))
print(max(2, 8))
print(min(num1, num2))
print(pow(2, 3))
print(pow(3, 3))
print(round(11.7))

#inputs
nome1 = input('Digite o seu nome: ')
idade = input('Digite a sua idade: ')

print('Ola ' + nome1 + '!' + ' Hoje voce tem ' + idade + ' anos de idade.')