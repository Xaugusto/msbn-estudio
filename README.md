# Estúdio - Sistema de Agendamentos

Sistema web desenvolvido em Python com Flask para gerenciamento de agendamentos de um estúdio. Permite que clientes se cadastrem, façam login e marquem horários, enquanto administradores gerenciam usuários e agendamentos.

## 🚀 Funcionalidades

### Para Usuários (Clientes)

- **Cadastro e Autenticação:** Criação de conta, login e logout seguros com controle de sessão
- **Agendamento de Horários:** Escolha de data e horário (início e término), com verificação de conflitos em tempo real
- **Gerenciamento de Agendamentos:** Visualização dos agendamentos marcados e opção de cancelamento
- **Perfil do Usuário:** Visualização, edição de dados pessoais e exclusão de conta

### Para Administradores

- **Painel Administrativo:** Área restrita para administração do sistema
- **Gestão de Usuários:** Listagem de todos os usuários cadastrados e opção de exclusão
- **Gestão de Agendamentos:** Listagem geral de todos os agendamentos do estúdio e opção de cancelamento

## 🛠️ Tecnologias Utilizadas

- **Backend:** Python, Flask
- **Banco de Dados:** MySQL (`mysql-connector-python`)
- **Frontend:** HTML, CSS, Templates Jinja2

> **Nota:** O **frontend** (templates HTML, CSS e páginas) foi **gerado por IA**. Os scripts de automação **`install.sh`** e **`run.sh`** também foram **gerados por IA** para facilitar a instalação e execução do projeto.

## ⚙️ Pré-requisitos

- Python 3.8+
- MySQL Server 5.7+ ou MariaDB 10.3+
- pip (gerenciador de pacotes do Python)

## 📦 Instalação

### Opção 1: Instalação Automática (Recomendada)

Execute o script de instalação que configura tudo automaticamente:

```bash
chmod +x install.sh
./install.sh
```

### Opção 2: Instalação Manual

1. **Clone o repositório** (se aplicável) ou navegue até a pasta do projeto:

   ```bash
   cd msbn-estudio
   ```

2. **Crie e ative um ambiente virtual** (recomendado):

   ```bash
   python3 -m venv venv
   source venv/bin/activate  # Linux/macOS
   # ou
   venv\Scripts\activate     # Windows
   ```

3. **Instale as dependências:**

   ```bash
   pip install -r requirements.txt
   ```

   Ou instale manualmente:

   ```bash
   pip install flask mysql-connector-python
   ```

4. **Configure o Banco de Dados MySQL:**

   Acesse o MySQL:

   ```bash
   mysql -u root -p
   ```

   Execute o script SQL para criar o banco e as tabelas:

   ```sql
   SOURCE db.sql;
   ```

   Ou execute diretamente no terminal:

   ```bash
   mysql -u root -p < db.sql
   ```

5. **Ajuste as configurações de conexão** (se necessário):

   Edite o arquivo `conexao.py` se seu MySQL tiver configurações diferentes:

   ```python
   con = mysql.connector.connect(
       host='localhost',
       database='estudio_db',  # Nome do banco criado no db.sql
       user='root',
       password='sua_senha_aqui',  # Coloque sua senha do MySQL
       use_pure=True
   )
   ```

## ▶️ Como Executar

### Com o script de inicialização:

```bash
chmod +x run.sh
./run.sh
```

### Manualmente:

```bash
# Ative o ambiente virtual (se criou um)
source venv/bin/activate

# Execute a aplicação
python main.py
```

A aplicação estará disponível em: **http://localhost:5000**

## 🌐 Como Usar

### 1. Acesso Inicial

- Acesse `http://localhost:5000` - Página inicial
- Acesse `http://localhost:5000/landing` - Landing page

### 2. Cadastro de Usuário

- Clique em "Cadastrar" ou acesse `/pagina_cadastro`
- Preencha: Nome, Email, Telefone, Senha
- Após cadastro, faça login

### 3. Login

- Acesse `/loguin` ou clique em "Entrar"
- **Usuário comum:** Qualquer usuário cadastrado (exceto ID 1)
- **Administrador:** Email `admin@estudio.com` / Senha `admin123` (ID 1)

### 4. Agendamento (Usuário Comum)

1. Faça login como usuário comum
2. Clique em "Agendar" ou acesse `/pagina_consulta_agend`
3. Escolha uma data e clique em "Consultar"
4. Selecione um horário disponível
5. Defina hora de início e término
6. Confirme o agendamento

### 5. Painel Administrativo

1. Faça login com: `admin@estudio.com` / `admin123`
2. Será redirecionado automaticamente para `/pagina_admin`
3. Opções disponíveis:
   - **Listar Usuários:** `/pagina_listagem_users`
   - **Listar Agendamentos:** `/pagina_listagem_agend`
   - **Excluir Usuário/Agendamento:** Botões na listagem

### 6. Perfil do Usuário

- Acesse `/perfil_user` após login
- Edite dados em `/pagina_edit_user`
- Exclua conta se desejar

## 📁 Estrutura do Projeto

```
msbn-estudio/
├── main.py                 # Aplicação principal Flask (rotas)
├── conexao.py              # Conexão com MySQL
├── db.sql                  # Script de criação do banco de dados
├── requirements.txt        # Dependências Python
├── install.sh              # Script de instalação automática (gerado por IA)
├── run.sh                  # Script de execução (gerado por IA)
├── templates/              # Templates HTML (Jinja2) - Frontend gerado por IA
│   ├── static/css/styles.css
│   ├── *.html              # Páginas da aplicação
└── md/                     # Documentação adicional
```

## 🔧 Configurações Importantes

### Variáveis de Ambiente (Produção)

Para produção, configure estas variáveis:

```bash
export FLASK_SECRET_KEY="sua_chave_secreta_super_segura"
export DB_HOST="localhost"
export DB_NAME="estudio_db"
export DB_USER="root"
export DB_PASSWORD="sua_senha_segura"
```

E altere `main.py` e `conexao.py` para usar `os.environ.get()`.

### Segurança

- **NÃO use a chave secreta padrão em produção**
- **NÃO use senha vazia no MySQL em produção**
- Use HTTPS em produção
- Considere usar hash de senhas (bcrypt)

## 🐛 Solução de Problemas

### Erro de conexão com MySQL

```bash
# Verifique se o MySQL está rodando
sudo systemctl status mysql  # Linux
brew services list | grep mysql  # macOS

# Inicie se necessário
sudo systemctl start mysql
```

### Erro "Access denied for user 'root'"

- Verifique a senha no `conexao.py`
- Ou crie um usuário dedicado:
  ```sql
  CREATE USER 'estudio_user'@'localhost' IDENTIFIED BY 'senha_segura';
  GRANT ALL PRIVILEGES ON estudio_db.* TO 'estudio_user'@'localhost';
  FLUSH PRIVILEGES;
  ```

### Porta 5000 já em uso

```bash
# Mate o processo na porta 5000
lsof -ti:5000 | xargs kill -9
# Ou mude a porta no main.py: app.run(debug=True, port=5001)
```

### Módulo não encontrado

```bash
# Reinstale as dependências
pip install -r requirements.txt --force-reinstall
```

## 📝 Licença

Este projeto é de uso livre.
