from flask import Flask, render_template, request, session, url_for, redirect
import mysql.connector
from mysql.connector import Error
from conexao import con

app = Flask(__name__)

""" Chave para a session """
app.secret_key = 'uma_chave_muito_segura_aqui'

# Rotas Para Usuarios

""" Rota Loguin """

@app.route('/loguin_sql', methods=['POST'])
def Loguin_user():
    loguin_email = request.form.get('email_loguin')
    loguin_senha = request.form.get('senha_loguin')

    sql_loguin = "SELECT * FROM usuario WHERE email LIKE %s AND senha LIKE %s"
    valores_loguin = (loguin_email, loguin_senha)

    cursor = con.cursor(dictionary=True)
    cursor.execute(sql_loguin, valores_loguin)
    user = cursor.fetchone()

    if user:
        session['id_user'] = user['id_usuario']
        session['nome_user'] = user['nome']

        id_sessao = session.get('id_user')
        nome_sessao = session['nome_user']

        if id_sessao ==  1 :
            return render_template('pagina_admin.html')
        else:
            return redirect(url_for('index'))
    else:

        return render_template('erro_loguin.html')

""" Rota Padrao """

@app.route("/")
def index():
    return render_template('index.html', id = session.get('id_user'))

""" Rota Pagina de Loguin """

@app.route("/loguin")
def loguin_page():
    return render_template('loguin.html')

""" Rota Pagina de Cadastro """

@app.route("/pagina_cadastro")
def cadastro_page():
    return render_template('cadastro.html')

""" Rota Cadastro """

@app.route("/cadastro_sql", methods=['POST'])
def cadastroBanco():
    cadastro_nome = request.form.get('nome')
    cadastro_email = request.form.get('email')
    cadastro_telefone = request.form.get('telefone')
    cadastro_senha = request.form.get('senha')

    sql_cadastro = "INSERT INTO usuario (nome, email, telefone, senha) VALUES (%s, %s, %s, %s)"
    valores_cadastro = (cadastro_nome, cadastro_email, cadastro_telefone, cadastro_senha)
    cursor = con.cursor()
    cursor.execute(sql_cadastro, valores_cadastro)
    con.commit()
    

    if cursor.rowcount > 0 :
        
        return render_template('cadastrado.html',id = 1)
    else:
        
        return render_template('erro_cadastro.html')

""" Rota Pagina de Agendamentos """

@app.route('/pagina_consulta_agend')
def consul_page_agend():
    return render_template('consultar_agendamentos.html')

@app.route('/consulta_agend', methods=['POST'])
def consul_agend():
    data = request.form.get('data_agend')
    data_split = data.split('-')

    dia_consulta = int(data_split[2])
    mes_consulta = int(data_split[1])
    ano_consulta = int(data_split[0])

    sql_consulta_agend = "SELECT * FROM agendamentos where dia = %s and mes = %s and ano = %s"
    valores_consulta_agend = (dia_consulta, mes_consulta, ano_consulta)

    cursor = con.cursor(dictionary=True)
    cursor.execute(sql_consulta_agend, valores_consulta_agend)

    valor_consulta = cursor.fetchall() or 0

    if valor_consulta != 0:
        return render_template('data.html', agendas = valor_consulta)
    else:
        return render_template('nenhum_horario.html')


@app.route('/pagina_agendamentos')
def agendamentos_page():
    sql_horarios = "Select * From horarios"

    cursor = con.cursor(dictionary=True)
    cursor.execute(sql_horarios)

    hora_sql = cursor.fetchall()
    
    return render_template('agendamentos.html', horarios = hora_sql)
    
""" Rota Agendamentos"""

@app.route('/agendamentos', methods=['POST'])
def inserir_agendamentos():
    data = request.form.get('data_agend')
    data_split = data.split('-')
    dia_agend = int(data_split[2])
    mes_agend = int(data_split[1])
    ano_agend = int(data_split[0])
    
    agend_hora_init = int(request.form.get('hora_inicio'))
    agend_hora_end = int(request.form.get('hora_termino'))
    
    sql_consulta_agend_script = "SELECT * FROM agendamentos where dia = %s and mes = %s and ano = %s"
    valores_consulta_agend_script = (dia_agend, mes_agend, ano_agend)

    cursor = con.cursor(dictionary=True)
    cursor.execute(sql_consulta_agend_script, valores_consulta_agend_script)

    hora_permitido = False

    horarios_banco = cursor.fetchall()
    for h in horarios_banco:
        if agend_hora_init < h['hora_termino'] and agend_hora_end > h['hora_inicio']:
            hora_permitido = True
            break

    if hora_permitido:
        return render_template('erro_agend.html') 
    else:
        return render_template('agendado.html', var=1)

""" Rota de Consulta Agendamentos Do Usuario """

@app.route('/meus_agend')
def consulta_agend():
    sql_consulta = "SELECT * FROM agendamentos where (id_cliente) = (%s)"
    id_cli = session.get('id_user')
    valor_id_user =  (id_cli,)

    cursor = con.cursor(dictionary=True)
    cursor.execute(sql_consulta, valor_id_user)

    consulta = cursor.fetchall()

    return render_template('meus_agendamentos.html', usuarios = consulta)

""" Rota Para Cancelar Agendamentos """

@app.route('/del_agend', methods=['POST'])
def delete_horario():
    id_hora = request.form.get('id_delete')
    sql_delete_agend = "DELETE FROM agendamentos WHERE id_horarios = (%s)"
    valor_del_agend = (id_hora,)

    cursor = con.cursor()
    cursor.execute(sql_delete_agend, valor_del_agend)
    con.commit()

    if cursor.rowcount > 0:
        return redirect(url_for('consulta_agend'))
    else:
        return render_template('erro_del_agend.html')


""" Rota Para Pagina de Perfil do Usuario """

@app.route('/perfil_user')
def perfil_page():
    sql_consulta = "SELECT * FROM usuario where (id_usuario) in (%s)"
    id_cli = session['id_user']
    valor_consulta =  (id_cli,)

    cursor = con.cursor(dictionary=True)
    cursor.execute(sql_consulta, valor_consulta)

    consulta = cursor.fetchall()

    return render_template('meu_perfil.html', id_user = session['id_user'], atributos = consulta)
    
""" Rota de Pagina para Editar Usuario """

@app.route('/pagina_edit_user', methods = ['POST'])
def editar_user_page():
    sql_consulta = "SELECT * FROM usuario where (id_usuario) in (%s)"
    id_cli = session['id_user']
    valor_consulta =  (id_cli,)

    cursor = con.cursor(dictionary=True)
    cursor.execute(sql_consulta, valor_consulta)

    consulta = cursor.fetchall()

    return render_template('editar_usuario.html', id_user = session['id_user'], atributos = consulta)

""" Rota Editar Usuario """

@app.route('/edit_user', methods = ['POST'])
def edit_user():
    id_edit_user = request.form.get('id_usuario_edit')
    nome_edit_user = request.form.get('nome')
    email_edit_user = request.form.get('email')
    telefone_edit_user = request.form.get('telefone')
    senha_edit_user = request.form.get('senha')

    sql_edit_user = "UPDATE usuario set nome = (%s), email = (%s), telefone = (%s), senha = (%s) WHERE id_usuario = (%s)"
    valor_edit_user =  (nome_edit_user, email_edit_user, telefone_edit_user, senha_edit_user, id_edit_user)

    cursor = con.cursor()
    cursor.execute(sql_edit_user, valor_edit_user)
    con.commit()

    session['nome_user'] = nome_edit_user

    return redirect(url_for('perfil_page'))

@app.route('/del_user', methods = ['POST'])
def user_delete():
    id_delete_user = request.form.get('id_del_user')

    sql_delete_agend = "DELETE FROM usuario WHERE id_usuario = (%s)"
    valor_del_agend = (id_delete_user,)

    cursor = con.cursor()
    cursor.execute(sql_delete_agend, valor_del_agend)
    con.commit()

    if cursor.rowcount > 0:
        session.clear()
        return redirect(url_for('index'))
    else:
        return render_template('erro_del_conta.html')



#Rotas Para ADM



""" Rota para Logout do Usuario """

@app.route('/logout')
def logout():
    session.clear()
    return render_template('index.html', id= None)


if __name__ == "__main__":
    app.run(debug=True) 