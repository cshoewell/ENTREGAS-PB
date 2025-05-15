def email_valido(email):
    return "@" in email and "." in email

def dividir(a, b):
    if b == 0:
        return "Divisão por zero não é permitida."
    return a / b