#!/bin/bash

# Script de Instalação Automática - Estúdio Sistema de Agendamentos
# Uso: chmod +x install.sh && ./install.sh

set -e  # Para o script se houver erro

echo "=========================================="
echo "  Instalação - Estúdio Sistema de Agendamentos"
echo "=========================================="
echo ""

# Verifica Python
echo "🔍 Verificando Python..."
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 não encontrado. Instale o Python 3.8+ primeiro."
    exit 1
fi
PYTHON_VERSION=$(python3 --version | cut -d' ' -f2)
echo "✅ Python $PYTHON_VERSION encontrado"

# Verifica MySQL
echo "🔍 Verificando MySQL..."
if ! command -v mysql &> /dev/null; then
    echo "⚠️  MySQL client não encontrado. Você precisará instalar o MySQL Server separadamente."
    echo "   Ubuntu/Debian: sudo apt install mysql-server"
    echo "   macOS: brew install mysql"
    echo "   Windows: Baixe do site oficial do MySQL"
else
    echo "✅ MySQL client encontrado"
fi

# Cria ambiente virtual
echo "📦 Criando ambiente virtual..."
if [ -d "venv" ]; then
    echo "⚠️  Ambiente virtual já existe. Removendo..."
    rm -rf venv
fi
python3 -m venv venv
echo "✅ Ambiente virtual criado"

# Ativa ambiente virtual
echo "🔧 Ativando ambiente virtual..."
source venv/bin/activate

# Atualiza pip
echo "⬆️  Atualizando pip..."
pip install --upgrade pip > /dev/null 2>&1

# Instala dependências
echo "📥 Instalando dependências Python..."
pip install -r requirements.txt
echo "✅ Dependências instaladas"

# Configura banco de dados
echo "🗄️  Configurando banco de dados..."
echo ""
echo "Para configurar o banco de dados, preciso das credenciais do MySQL:"
read -p "Host do MySQL [localhost]: " DB_HOST
DB_HOST=${DB_HOST:-localhost}

read -p "Usuário MySQL [root]: " DB_USER
DB_USER=${DB_USER:-root}

read -s -p "Senha MySQL (deixe vazio se não tiver): " DB_PASS
echo ""

read -p "Nome do banco de dados [estudio_db]: " DB_NAME
DB_NAME=${DB_NAME:-estudio_db}

# Testa conexão e cria banco
echo "🔗 Testando conexão com MySQL..."
if mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" -e "SELECT 1;" > /dev/null 2>&1; then
    echo "✅ Conexão com MySQL bem-sucedida"
    
    echo "📋 Criando banco de dados e tabelas..."
    mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" < db.sql
    echo "✅ Banco de dados '$DB_NAME' criado e populado"
    
    # Atualiza conexao.py
    echo "⚙️  Atualizando arquivo de conexão..."
    sed -i "s/host='localhost'/host='$DB_HOST'/" conexao.py
    sed -i "s/database='estudio'/database='$DB_NAME'/" conexao.py
    sed -i "s/user='root'/user='$DB_USER'/" conexao.py
    sed -i "s/password=''/password='$DB_PASS'/" conexao.py
    echo "✅ Arquivo conexao.py atualizado"
else
    echo "❌ Não foi possível conectar ao MySQL."
    echo "   Verifique se o MySQL está rodando e as credenciais estão corretas."
    echo "   Você pode configurar manualmente editando o arquivo conexao.py"
    echo "   E executar: mysql -h $DB_HOST -u $DB_USER -p < db.sql"
fi

# Cria arquivo .env para produção (opcional)
echo "📝 Criando arquivo .env.example..."
cat > .env.example << EOF
# Copie este arquivo para .env e preencha com seus valores
FLASK_SECRET_KEY=sua_chave_secreta_super_segura_aqui
DB_HOST=$DB_HOST
DB_NAME=$DB_NAME
DB_USER=$DB_USER
DB_PASSWORD=$DB_PASS
EOF
echo "✅ Arquivo .env.example criado"

echo ""
echo "=========================================="
echo "  ✅ Instalação Concluída!"
echo "=========================================="
echo ""
echo "Para executar o projeto:"
echo "  ./run.sh"
echo ""
echo "Ou manualmente:"
echo "  source venv/bin/activate"
echo "  python main.py"
echo ""
echo "Acesse: http://localhost:5000"
echo ""
echo "Login Admin: admin@estudio.com / admin123"
echo "=========================================="