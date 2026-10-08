#!/bin/bash

# Script de Execução - Estúdio Sistema de Agendamentos
# Uso: chmod +x run.sh && ./run.sh

set -e

echo "=========================================="
echo "  Iniciando Estúdio - Sistema de Agendamentos"
echo "=========================================="
echo ""

# Verifica se existe ambiente virtual
if [ ! -d "venv" ]; then
    echo "⚠️  Ambiente virtual não encontrado."
    echo "   Execute primeiro: ./install.sh"
    exit 1
fi

# Ativa ambiente virtual
echo "🔧 Ativando ambiente virtual..."
source venv/bin/activate

# Verifica se dependências estão instaladas
if ! python -c "import flask, mysql.connector" 2>/dev/null; then
    echo "⚠️  Dependências não encontradas. Instalando..."
    pip install -r requirements.txt
fi

# Verifica conexão com banco
echo "🔗 Verificando conexão com banco de dados..."
python3 -c "
import mysql.connector
from conexao import con
try:
    if con.is_connected():
        print('✅ Banco de dados conectado')
    else:
        print('❌ Falha na conexão com banco')
        exit(1)
except Exception as e:
    print(f'❌ Erro: {e}')
    exit(1)
"

echo ""
echo "🚀 Iniciando servidor Flask..."
echo "   Acesse: http://localhost:5000"
echo "   Login Admin: admin@estudio.com / admin123"
echo ""
echo "   Pressione Ctrl+C para parar"
echo "=========================================="
echo ""

# Executa a aplicação
python main.py