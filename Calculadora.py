import tkinter as tk
from tkinter import Toplevel, messagebox
import hashlib
import base64
import math

def abrir_modular():
    submenu = Toplevel(root)
    submenu.title("Operaciones Matemáticas Modulares")
    tk.Button(submenu, text="Calcular Módulo", command=abrir_modulo).pack()
    tk.Button(submenu, text="Calcular Inverso Aditivo", command=abrir_inverso_aditivo).pack()
    tk.Button(submenu, text="Calcular Inverso de XOR", command=abrir_inverso_xor).pack()
    tk.Button(submenu, text="Calcular MCD e Inverso Multiplicativo", command=abrir_mcd).pack()
    tk.Button(submenu, text="Calcular Inverso Multiplicativo Tradicional", command=abrir_inverso_tradicional).pack()
    tk.Button(submenu, text="Calcular Inverso Multiplicativo con AEE", command=abrir_inverso_aee).pack()
    tk.Button(submenu, text="Volver", command=submenu.destroy).pack()

def abrir_modulo():
    ventana = Toplevel(root)
    ventana.title("Calcular Módulo")
    tk.Label(ventana, text="Número a:").pack()
    entry_a = tk.Entry(ventana)
    entry_a.pack()
    tk.Label(ventana, text="Módulo n:").pack()
    entry_n = tk.Entry(ventana)
    entry_n.pack()
    
    def calcular():
        try:
            a = int(entry_a.get())
            n = int(entry_n.get())
            resultado = a % n
            messagebox.showinfo("Resultado", f"{a} mod {n} = {resultado}")
        except ValueError:
            messagebox.showerror("Error", "Ingrese valores válidos")
    
    tk.Button(ventana, text="Calcular", command=calcular).pack()
    tk.Button(ventana, text="Volver", command=ventana.destroy).pack()

def abrir_inverso_aditivo():
    ventana = Toplevel(root)
    ventana.title("Inverso Aditivo")
    tk.Label(ventana, text="Número a:").pack()
    entry_a = tk.Entry(ventana)
    entry_a.pack()
    tk.Label(ventana, text="Módulo n:").pack()
    entry_n = tk.Entry(ventana)
    entry_n.pack()
    
    def calcular():
        try:
            a = int(entry_a.get())
            n = int(entry_n.get())
            resultado = (-a) % n
            messagebox.showinfo("Resultado", f"Inverso aditivo de {a} mod {n} = {resultado}")
        except ValueError:
            messagebox.showerror("Error", "Ingrese valores válidos")
    
    tk.Button(ventana, text="Calcular", command=calcular).pack()
    tk.Button(ventana, text="Volver", command=ventana.destroy).pack()

def abrir_inverso_xor():
    ventana = Toplevel(root)
    ventana.title("Inverso de XOR")
    tk.Label(ventana, text="Número a:").pack()
    entry_a = tk.Entry(ventana)
    entry_a.pack()
    tk.Label(ventana, text="Número b:").pack()
    entry_b = tk.Entry(ventana)
    entry_b.pack()
    
    def calcular():
        try:
            a = int(entry_a.get())
            b = int(entry_b.get())
            resultado = a ^ b
            messagebox.showinfo("Resultado", f"{a} XOR {b} = {resultado}")
        except ValueError:
            messagebox.showerror("Error", "Ingrese valores válidos")
    
    tk.Button(ventana, text="Calcular", command=calcular).pack()
    tk.Button(ventana, text="Volver", command=ventana.destroy).pack()

def abrir_mcd():
    ventana = Toplevel(root)
    ventana.title("MCD e Inverso Multiplicativo")
    tk.Label(ventana, text="Número a:").pack()
    entry_a = tk.Entry(ventana)
    entry_a.pack()
    tk.Label(ventana, text="Número b:").pack()
    entry_b = tk.Entry(ventana)
    entry_b.pack()
    
    def calcular():
        try:
            a = int(entry_a.get())
            b = int(entry_b.get())
            resultado = math.gcd(a, b)
            messagebox.showinfo("Resultado", f"MCD({a}, {b}) = {resultado}")
        except ValueError:
            messagebox.showerror("Error", "Ingrese valores válidos")
    
    tk.Button(ventana, text="Calcular", command=calcular).pack()
    tk.Button(ventana, text="Volver", command=ventana.destroy).pack()

def abrir_inverso_tradicional():
    ventana = Toplevel(root)
    ventana.title("Inverso Multiplicativo Tradicional")
    tk.Label(ventana, text="Número a:").pack()
    entry_a = tk.Entry(ventana)
    entry_a.pack()
    tk.Label(ventana, text="Módulo n:").pack()
    entry_n = tk.Entry(ventana)
    entry_n.pack()
    
    def calcular():
        try:
            a = int(entry_a.get())
            n = int(entry_n.get())
            for i in range(1, n):
                if (a * i) % n == 1:
                    messagebox.showinfo("Resultado", f"El inverso multiplicativo de {a} mod {n} es {i}")
                    return
            messagebox.showerror("Error", "No existe inverso multiplicativo")
        except ValueError:
            messagebox.showerror("Error", "Ingrese valores válidos")
    
    tk.Button(ventana, text="Calcular", command=calcular).pack()
    tk.Button(ventana, text="Volver", command=ventana.destroy).pack()

def abrir_inverso_aee():
    ventana = Toplevel(root)
    ventana.title("Inverso Multiplicativo con AEE")
    tk.Label(ventana, text="Número a:").pack()
    entry_a = tk.Entry(ventana)
    entry_a.pack()
    tk.Label(ventana, text="Módulo n:").pack()
    entry_n = tk.Entry(ventana)
    entry_n.pack()
    
    def calcular():
        try:
            a = int(entry_a.get())
            n = int(entry_n.get())
            t, new_t, r, new_r = 0, 1, n, a
            while new_r != 0:
                quotient = r // new_r
                t, new_t = new_t, t - quotient * new_t
                r, new_r = new_r, r - quotient * new_r
            if r > 1:
                messagebox.showerror("Error", "No existe inverso multiplicativo")
            else:
                messagebox.showinfo("Resultado", f"El inverso multiplicativo de {a} mod {n} es {t % n}")
        except ValueError:
            messagebox.showerror("Error", "Ingrese valores válidos")
    
    tk.Button(ventana, text="Calcular", command=calcular).pack()
    tk.Button(ventana, text="Volver", command=ventana.destroy).pack()

def abrir_cripto_clasica():
    submenu = Toplevel(root)
    submenu.title("Criptografía Clásica")
    tk.Button(submenu, text="Cifrado Módulo 27", command=abrir_cifrado_mod27).pack()
    tk.Button(submenu, text="Cifrado César", command=abrir_cifrado_cesar).pack()
    tk.Button(submenu, text="Cifrado Vernam", command=abrir_cifrado_vernam).pack()
    tk.Button(submenu, text="Cifrado ATBASH", command=abrir_cifrado_atbash).pack()
    tk.Button(submenu, text="Cifrado Transposición Columnar Simple", command=abrir_cifrado_transposicion).pack()
    tk.Button(submenu, text="Cifrado Afín", command=abrir_cifrado_afin).pack()
    tk.Button(submenu, text="Cifra de Sustitución Simple", command=abrir_cifra_sustitucion).pack()
    tk.Button(submenu, text="Volver", command=submenu.destroy).pack()

def abrir_cifrado_mod27():
    ventana = Toplevel(root)
    ventana.title("Cifrado Módulo 27")
    tk.Label(ventana, text="Mensaje:").pack()
    entry_msg = tk.Entry(ventana)
    entry_msg.pack()
    tk.Label(ventana, text="Clave:").pack()
    entry_key = tk.Entry(ventana)
    entry_key.pack()
    
    def cifrar():
        msg = entry_msg.get()
        key = int(entry_key.get())
        encrypted = ''.join(chr(((ord(char) - ord('A') + key) % 27) + ord('A')) for char in msg.upper())
        messagebox.showinfo("Resultado", f"Cifrado: {encrypted}")
    
    tk.Button(ventana, text="Cifrar", command=cifrar).pack()
    tk.Button(ventana, text="Volver", command=ventana.destroy).pack()


def abrir_cifrado_cesar():
    ventana = Toplevel(root)
    ventana.title("Cifrado César")
    tk.Label(ventana, text="Mensaje:").pack()
    entry_msg = tk.Entry(ventana)
    entry_msg.pack()
    tk.Label(ventana, text="Clave:").pack()
    entry_key = tk.Entry(ventana)
    entry_key.pack()
    
    def cifrar():
        msg = entry_msg.get()
        key = int(entry_key.get())
        encrypted = ''.join(chr((ord(char) + key - 65) % 26 + 65) for char in msg.upper())
        messagebox.showinfo("Resultado", f"Cifrado: {encrypted}")
    
    tk.Button(ventana, text="Cifrar", command=cifrar).pack()
    tk.Button(ventana, text="Volver", command=ventana.destroy).pack()

def abrir_cifrado_atbash():
    ventana = Toplevel(root)
    ventana.title("Cifrado ATBASH")
    tk.Label(ventana, text="Mensaje:").pack()
    entry_msg = tk.Entry(ventana)
    entry_msg.pack()
    
    def cifrar():
        msg = entry_msg.get()
        encrypted = ''.join(chr(155 - ord(char)) if char.isalpha() else char for char in msg.upper())
        messagebox.showinfo("Resultado", f"Cifrado: {encrypted}")
    
    tk.Button(ventana, text="Cifrar", command=cifrar).pack()
    tk.Button(ventana, text="Volver", command=ventana.destroy).pack()

def abrir_cifrado_vernam():
    ventana = Toplevel(root)
    ventana.title("Cifrado Vernam")
    tk.Label(ventana, text="Mensaje:").pack()
    entry_msg = tk.Entry(ventana)
    entry_msg.pack()
    tk.Label(ventana, text="Clave:").pack()
    entry_key = tk.Entry(ventana)
    entry_key.pack()
    
    def cifrar():
        msg = entry_msg.get()
        key = entry_key.get()
        encrypted = ''.join(chr(ord(m) ^ ord(k)) for m, k in zip(msg, key))
        messagebox.showinfo("Resultado", f"Cifrado: {encrypted}")
    
    tk.Button(ventana, text="Cifrar", command=cifrar).pack()
    tk.Button(ventana, text="Volver", command=ventana.destroy).pack()

def abrir_cifrado_transposicion():
    ventana = Toplevel(root)
    ventana.title("Cifrado Transposición Columnar Simple")
    tk.Label(ventana, text="Mensaje:").pack()
    entry_msg = tk.Entry(ventana)
    entry_msg.pack()
    
    def cifrar():
        msg = entry_msg.get()
        encrypted = ''.join(sorted(msg))
        messagebox.showinfo("Resultado", f"Cifrado: {encrypted}")
    
    tk.Button(ventana, text="Cifrar", command=cifrar).pack()
    tk.Button(ventana, text="Volver", command=ventana.destroy).pack()

def abrir_cifrado_afin():
    ventana = Toplevel(root)
    ventana.title("Cifrado Afín")
    tk.Label(ventana, text="Mensaje:").pack()
    entry_msg = tk.Entry(ventana)
    entry_msg.pack()
    tk.Label(ventana, text="Clave A:").pack()
    entry_key_a = tk.Entry(ventana)
    entry_key_a.pack()
    tk.Label(ventana, text="Clave B:").pack()
    entry_key_b = tk.Entry(ventana)
    entry_key_b.pack()
    
    def cifrar():
        msg = entry_msg.get()
        a = int(entry_key_a.get())
        b = int(entry_key_b.get())
        encrypted = ''.join(chr(((a * (ord(char) - 65) + b) % 26) + 65) for char in msg.upper())
        messagebox.showinfo("Resultado", f"Cifrado: {encrypted}")
    
    tk.Button(ventana, text="Cifrar", command=cifrar).pack()
    tk.Button(ventana, text="Volver", command=ventana.destroy).pack()

def abrir_cifra_sustitucion():
    ventana = Toplevel(root)
    ventana.title("Cifra de Sustitución Simple")
    tk.Label(ventana, text="Mensaje:").pack()
    entry_msg = tk.Entry(ventana)
    entry_msg.pack()
    tk.Label(ventana, text="Clave (alfabeto permutado):").pack()
    entry_key = tk.Entry(ventana)
    entry_key.pack()
    
    def cifrar():
        msg = entry_msg.get().upper()
        key = entry_key.get().upper()
        normal_alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        substitution = {normal_alphabet[i]: key[i] for i in range(26)}
        encrypted = ''.join(substitution.get(char, char) for char in msg)
        messagebox.showinfo("Resultado", f"Cifrado: {encrypted}")
    
    tk.Button(ventana, text="Cifrar", command=cifrar).pack()
    tk.Button(ventana, text="Volver", command=ventana.destroy).pack()

def abrir_cripto_moderna():
    submenu = Toplevel(root)
    submenu.title("Criptografía Moderna")
    tk.Button(submenu, text="Calcular Diffie Hellman", command=abrir_diffie_hellman).pack()
    tk.Button(submenu, text="Calcular RSA", command=abrir_rsa).pack()
    tk.Button(submenu, text="Calcular Algoritmo de Exponenciación Rápida", command=abrir_exponenciacion_rapida).pack()
    tk.Button(submenu, text="Volver", command=submenu.destroy).pack()

def abrir_diffie_hellman():
    ventana = Toplevel(root)
    ventana.title("Calcular Diffie Hellman")
    tk.Label(ventana, text="Base (g):").pack()
    entry_base = tk.Entry(ventana)
    entry_base.pack()
    tk.Label(ventana, text="Módulo (p):").pack()
    entry_modulo = tk.Entry(ventana)
    entry_modulo.pack()
    tk.Label(ventana, text="Clave Privada (a):").pack()
    entry_clave = tk.Entry(ventana)
    entry_clave.pack()
    
    def calcular():
        g = int(entry_base.get())
        p = int(entry_modulo.get())
        a = int(entry_clave.get())
        resultado = pow(g, a, p)
        messagebox.showinfo("Resultado", f"Clave Pública: {resultado}")
    
    tk.Button(ventana, text="Calcular", command=calcular).pack()
    tk.Button(ventana, text="Volver", command=ventana.destroy).pack()

def abrir_rsa():
    ventana = Toplevel(root)
    ventana.title("Calcular RSA")
    tk.Label(ventana, text="Mensaje (número):").pack()
    entry_msg = tk.Entry(ventana)
    entry_msg.pack()
    tk.Label(ventana, text="Clave Pública (e):").pack()
    entry_e = tk.Entry(ventana)
    entry_e.pack()
    tk.Label(ventana, text="Módulo (n):").pack()
    entry_n = tk.Entry(ventana)
    entry_n.pack()
    
    def calcular():
        msg = int(entry_msg.get())
        e = int(entry_e.get())
        n = int(entry_n.get())
        resultado = pow(msg, e, n)
        messagebox.showinfo("Resultado", f"Cifrado: {resultado}")
    
    tk.Button(ventana, text="Cifrar", command=calcular).pack()
    tk.Button(ventana, text="Volver", command=ventana.destroy).pack()

def abrir_exponenciacion_rapida():
    ventana = Toplevel(root)
    ventana.title("Algoritmo de Exponenciación Rápida")
    tk.Label(ventana, text="Base (a):").pack()
    entry_base = tk.Entry(ventana)
    entry_base.pack()
    tk.Label(ventana, text="Exponente (b):").pack()
    entry_exp = tk.Entry(ventana)
    entry_exp.pack()
    tk.Label(ventana, text="Módulo (n):").pack()
    entry_mod = tk.Entry(ventana)
    entry_mod.pack()
    
    def calcular():
        a = int(entry_base.get())
        b = int(entry_exp.get())
        n = int(entry_mod.get())
        resultado = pow(a, b, n)
        messagebox.showinfo("Resultado", f"Resultado: {resultado}")
    
    tk.Button(ventana, text="Calcular", command=calcular).pack()
    tk.Button(ventana, text="Volver", command=ventana.destroy).pack()

def abrir_hash():
    submenu = Toplevel(root)
    submenu.title("Algoritmos Hash")
    tk.Button(submenu, text="Calcular MD5", command=abrir_md5).pack()
    tk.Button(submenu, text="Calcular SHA128", command=abrir_sha128).pack()
    tk.Button(submenu, text="Calcular SHA512", command=abrir_sha512).pack()
    tk.Button(submenu, text="Volver", command=submenu.destroy).pack()

def abrir_md5():
    ventana = Toplevel(root)
    ventana.title("Calcular MD5")
    tk.Label(ventana, text="Ingrese el texto:").pack()
    entry_texto = tk.Entry(ventana)
    entry_texto.pack()
    
    def calcular():
        texto = entry_texto.get().encode()
        resultado = hashlib.md5(texto).hexdigest()
        messagebox.showinfo("Resultado", f"MD5: {resultado}")
    
    tk.Button(ventana, text="Calcular", command=calcular).pack()
    tk.Button(ventana, text="Volver", command=ventana.destroy).pack()

def abrir_sha128():
    ventana = Toplevel(root)
    ventana.title("Calcular SHA128")
    tk.Label(ventana, text="Ingrese el texto:").pack()
    entry_texto = tk.Entry(ventana)
    entry_texto.pack()
    
    def calcular():
        texto = entry_texto.get().encode()
        resultado = hashlib.sha1(texto).hexdigest()
        messagebox.showinfo("Resultado", f"SHA128: {resultado}")
    
    tk.Button(ventana, text="Calcular", command=calcular).pack()
    tk.Button(ventana, text="Volver", command=ventana.destroy).pack()

def abrir_sha512():
    ventana = Toplevel(root)
    ventana.title("Calcular SHA512")
    tk.Label(ventana, text="Ingrese el texto:").pack()
    entry_texto = tk.Entry(ventana)
    entry_texto.pack()
    
    def calcular():
        texto = entry_texto.get().encode()
        resultado = hashlib.sha512(texto).hexdigest()
        messagebox.showinfo("Resultado", f"SHA512: {resultado}")
    
    tk.Button(ventana, text="Calcular", command=calcular).pack()
    tk.Button(ventana, text="Volver", command=ventana.destroy).pack()

def abrir_codificacion():
    submenu = Toplevel(root)
    submenu.title("Codificación")
    tk.Button(submenu, text="Decodificar Binario", command=abrir_binario).pack()
    tk.Button(submenu, text="Decodificar Hexa", command=abrir_hexa).pack()
    tk.Button(submenu, text="Decodificar Base64", command=abrir_base64).pack()
    tk.Button(submenu, text="Volver", command=submenu.destroy).pack()

def abrir_binario():
    submenu = Toplevel(root)
    submenu.title("Decodificar Binario")
    entrada = tk.Entry(submenu)
    entrada.pack()
    
    def procesar():
        texto = entrada.get()
        try:
            resultado = "Binario: " + ' '.join(format(ord(c), '08b') for c in texto)
        except:
            resultado = "Error en conversión"
        messagebox.showinfo("Resultado", resultado)
    
    tk.Button(submenu, text="Convertir", command=procesar).pack()
    tk.Button(submenu, text="Volver", command=submenu.destroy).pack()

def abrir_hexa():
    submenu = Toplevel(root)
    submenu.title("Decodificar Hexa")
    entrada = tk.Entry(submenu)
    entrada.pack()
    
    def procesar():
        texto = entrada.get()
        try:
            resultado = "Hexadecimal: " + texto.encode().hex()
        except:
            resultado = "Error en conversión"
        messagebox.showinfo("Resultado", resultado)
    
    tk.Button(submenu, text="Convertir", command=procesar).pack()
    tk.Button(submenu, text="Volver", command=submenu.destroy).pack()

def abrir_base64():
    submenu = Toplevel(root)
    submenu.title("Decodificar Base64")
    entrada = tk.Entry(submenu)
    entrada.pack()
    
    def procesar():
        texto = entrada.get()
        try:
            resultado = "Base64: " + base64.b64encode(texto.encode()).decode()
        except:
            resultado = "Error en conversión"
        messagebox.showinfo("Resultado", resultado)
    
    tk.Button(submenu, text="Convertir", command=procesar).pack()
    tk.Button(submenu, text="Volver", command=submenu.destroy).pack()


# Ventana principal
root = tk.Tk()
root.title("Calculadora Criptográfica")

tk.Button(root, text="Operaciones Matemáticas Modulares", command=abrir_modular).pack()
tk.Button(root, text="Criptografía Clásica", command=abrir_cripto_clasica).pack()
tk.Button(root, text="Criptografía Moderna", command=abrir_cripto_moderna).pack()
tk.Button(root, text="Algoritmos Hash", command=abrir_hash).pack()
tk.Button(root, text="Codificación", command=abrir_codificacion).pack()

root.mainloop()
