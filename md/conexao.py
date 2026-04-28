import mysql.connector
 
print('teste') 

con = mysql.connector.connect(host='localhost', database='estudio', user='root', password='', use_pure=True)

"""

if con.is_connected():
    db_info = con.server_info
    print("Conectado ao banco versao", db_info)
    cursor = con.cursor()
    cursor.execute("select database();")
    linha = cursor.fetchone()
    print("conectado ao banco de dados", linha)

if con.is_connected():
    cursor.close()
    con.close()
    print("conexao mysql encerrada")

"""