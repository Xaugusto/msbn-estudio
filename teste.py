from flask import Flask, render_template, request, session, url_for, redirect
import mysql.connector
from mysql.connector import Error
from conexao import con

app = Flask(__name__)

""" Chave para a session """
app.secret_key = 'uma_chave_muito_segura_aqui'

@app.route('/')
def pagina_inicial():
    return render_template('formteste.html')

@app.route('/processar_formulario', methods=['POST'])
def processar_formulario():
    hora_inicial = request.form.get('hora_inicial')
    hora_final = request.form.get('hora_final')

    print(hora_inicial)
    print(hora_final)

    

if __name__ == "__main__":
    app.run(debug=True) 