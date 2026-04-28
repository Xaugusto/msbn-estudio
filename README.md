# Estúdio - Sistema de Agendamentos

Este é um sistema web desenvolvido em Python com Flask para gerenciamento de agendamentos de um estúdio. O sistema permite que clientes se cadastrem, façam login e marquem horários, enquanto administradores podem gerenciar usuários e todos os agendamentos.

## 🚀 Funcionalidades

### Para Usuários (Clientes)
- **Cadastro e Autenticação:** Criação de conta, login e logout seguros com controle de sessão.
- **Agendamento de Horários:** Escolha de data e horário (início e término), com verificação de conflitos em tempo real (evita sobreposição de horários).
- **Gerenciamento de Agendamentos:** Visualização dos agendamentos marcados pelo usuário e opção de cancelamento.
- **Perfil do Usuário:** Visualização, edição de dados pessoais e exclusão de conta.

### Para Administradores
- **Painel Administrativo:** Área restrita para administração do sistema.
- **Gestão de Usuários:** Listagem de todos os usuários cadastrados e opção de exclusão.
- **Gestão de Agendamentos:** Listagem geral de todos os agendamentos do estúdio e opção de cancelamento.

## 🛠️ Tecnologias Utilizadas

- **Backend:** Python, Flask
- **Banco de Dados:** MySQL (`mysql-connector-python`)
- **Frontend:** HTML, CSS, Templates Jinja2

## ⚙️ Pré-requisitos e Instalação

1. Certifique-se de ter o Python instalado em sua máquina.
2. Instale as dependências necessárias:
   ```bash
   pip install flask mysql-connector-python
   ```
3. Configure o Banco de Dados MySQL:
   - Crie um banco de dados chamado `estudio`.
   - Ajuste as configurações de conexão no arquivo `conexao.py` se necessário (host='localhost', user='root', password='').
4. Execute a aplicação:
   ```bash
   python main.py
   ```
5. Acesse no navegador através de `http://localhost:5000`

## 📁 Estrutura do Projeto

- `main.py`: Arquivo principal da aplicação contendo todas as rotas (endpoints) do Flask.
- `conexao.py`: Arquivo responsável por estabelecer a conexão com o banco de dados MySQL.
- `templates/`: Diretório contendo os templates HTML e arquivos estáticos (CSS) da aplicação.
