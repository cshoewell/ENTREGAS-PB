from html.entities import name2codepoint

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

#calculadora
num1 = input('Digite o primeiro numero: ')
num2 = input('Digite o segundo numero: ')
soma = float(num1) + float(num2)
print(soma)

#listas
amigos = ['Marcos', 'Pedro', 'Adriana', 'Karina', 'Julia']
print(amigos)

amigos = ['Marcos', 'Pedro', 'Adriana', 'Karina', 'Julia']
print(amigos[2])

amigos = ['Marcos', 'Pedro', 'Adriana', 'Karina', 'Julia']
print(amigos[-1])

amigos = ['Marcos', 'Pedro', 'Adriana', 'Karina', 'Julia']
print(amigos[1:3]) #não inclui a terceira posiçao (Karina)

amigos = ['Marcos', 'Pedro', 'Adriana', 'Karina', 'Julia']
print(amigos[1:4]) #inclui a terceira posiçao (Karina)

amigos = ['Marcos', 'Pedro', 'Adriana', 'Karina', 'Julia']
print(amigos[2:]) #mostra a partir da posiçao indicada

amigos = ['Marcos', 'Pedro', 'Adriana', 'Karina', 'Julia']
amigos[1] = 'Joao'
print(amigos) #modifica a informaçao na posiçao indicada

#Funçoes dentro de listas
numeros = [3, 5, 12, 2, 15, 6]
amigos = ['Marcos', 'Pedro', 'Adriana', 'Karina', 'Julia']
amigos.extend(numeros) #imprime as duas listas juntos
print(amigos)
amigos.append('Joao') #inclui mais uma informaçao
print(amigos)
amigos.insert(1, 'Joao') #inclui informação na posiçao indicada
print(amigos)
amigos.remove('Adriana') #remove informação pelo nome
print(amigos)
amigos.pop(4) #remove informação pelo index
print(amigos)
print(amigos.index('Karina')) #informa se a informação existe na lista e em qual posiçao está
amigos = ['Marcos', 'Pedro', 'Adriana', 'Karina', 'Julia', 'Karina', 'Karina']
print(amigos.count('Karina')) #conta quantas vezes a informação aparece na lista
amigos.sort() #organiza em ordem alfabetica
print(amigos)
numeros.sort() #organiza em ordem numerica
print(numeros)

#If Statements (condiçoes V e F)
    #Eu acordei
    #Se for antes das 9am
    #    Eu faco meu cafe da manha
    #==============================
    #Eu acordei
    #Se for antes das 9am
    #    Eu faco meu cafe da manha
    #se nao
    #    Eu faco almoco
acordei_antes9 = False
fome = False
if acordei_antes9 and fome: #pode ser utilizado OR no lugar de AND
    print('Hora de fazer o cafe da manha')
elif acordei_antes9 and not(fome):
    print('Hora de fazer uma caminhada')
elif not(acordei_antes9) and fome:
    print('Hora de fazer o almoco')
else:
    print('Hora de trabalhar')

#questao 2 do teste
p, q, r = 10, 20 ,30
print(p, q, r)

#questao 3 do teste
var= "James Bond"
print(var[2::-1])

#questao 4 do teste
listOne = [20, 40, 60, 80]
listTwo = [20, 40, 60, 80]
print(listOne == listTwo)
print(listOne is listTwo)

#questao 5 do teste
var1 = 1
var2 = 2
var3 = '3'
print(var1 + var2 + var3)