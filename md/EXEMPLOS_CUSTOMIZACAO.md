# 🎨 EXEMPLOS DE CUSTOMIZAÇÃO

## Como Estender o CSS

O arquivo `templates/static/css/styles.css` foi criado para ser fácil de customizar. Aqui estão alguns exemplos práticos.

---

## 1️⃣ MUDAR A PALETA DE CORES

### Exemplo 1: Tema Azul
```css
:root {
    --primary-color: #1E3A8A;        /* Azul profundo */
    --secondary-color: #0EA5E9;      /* Azul claro */
    --tertiary-color: #06B6D4;       /* Ciano azulado */
    --dark-bg: #0F172A;
    --light-bg: #F0F4F8;
    --white: #ffffff;
    --text-dark: #1E293B;
    --text-light: #64748B;
    --border-color: #CBD5E1;
    --success: #10B981;
    --danger: #EF4444;
    --warning: #F59E0B;
}
```

### Exemplo 2: Tema Verdoso
```css
:root {
    --primary-color: #065F46;        /* Verde profundo */
    --secondary-color: #10B981;      /* Verde claro */
    --tertiary-color: #14B8A6;       /* Teal */
    /* ... mantém o resto igual ... */
}
```

### Exemplo 3: Tema Quente (Laranja/Vermelho)
```css
:root {
    --primary-color: #DC2626;        /* Vermelho */
    --secondary-color: #F97316;      /* Laranja */
    --tertiary-color: #FBBF24;       /* Amarelo ouro */
    /* ... */
}
```

---

## 2️⃣ ADICIONAR NOVAS VARIANTES DE BOTÕES

### Adicione ao final do CSS:

```css
/* Botão Gradient */
.btn-gradient {
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    color: var(--white);
}

.btn-gradient:hover {
    transform: translateY(-2px);
    box-shadow: var(--shadow-lg);
}

/* Botão Ghost (apenas borda) */
.btn-ghost {
    background: transparent;
    border: 2px solid var(--primary-color);
    color: var(--primary-color);
}

.btn-ghost:hover {
    background: var(--primary-color);
    color: var(--white);
}

/* Botão Desabilitado */
.btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
}
```

**Como usar:**
```html
<button class="btn btn-gradient">Botão Gradient</button>
<button class="btn btn-ghost">Botão Ghost</button>
<button class="btn btn-primary" disabled>Desabilitado</button>
```

---

## 3️⃣ CUSTOMIZAR CARDS

### Adicionar variantes de cards:

```css
/* Card com borda */
.card-bordered {
    border: 2px solid var(--primary-color);
}

/* Card com sombra grande */
.card-elevated {
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
}

/* Card compacto */
.card-compact {
    padding: 1rem;
}

/* Card com fundo colorido */
.card-primary {
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    color: white;
}

.card-primary .card-title {
    color: white;
}
```

**Como usar:**
```html
<div class="card card-bordered">
    <div class="card-header">
        <h3 class="card-title">Card com Borda</h3>
    </div>
</div>

<div class="card card-elevated">
    <div class="card-header">
        <h3 class="card-title">Card Elevado</h3>
    </div>
</div>

<div class="card card-primary">
    <div class="card-header">
        <h3 class="card-title">Card Colorido</h3>
    </div>
</div>
```

---

## 4️⃣ ADICIONAR BADGES/TAGS

### Novo componente de badges:

```css
/* Badges */
.badge {
    display: inline-block;
    padding: 0.25rem 0.75rem;
    border-radius: 20px;
    font-size: 0.875rem;
    font-weight: 600;
}

.badge-primary {
    background-color: var(--primary-color);
    color: white;
}

.badge-success {
    background-color: var(--success);
    color: white;
}

.badge-danger {
    background-color: var(--danger);
    color: white;
}

.badge-warning {
    background-color: var(--warning);
    color: white;
}

.badge-outline {
    border: 2px solid var(--primary-color);
    color: var(--primary-color);
    background: transparent;
}
```

**Como usar:**
```html
<span class="badge badge-primary">Novo</span>
<span class="badge badge-success">✓ Ativo</span>
<span class="badge badge-danger">Importante</span>
<span class="badge badge-warning">Pendente</span>
<span class="badge badge-outline">Info</span>
```

---

## 5️⃣ CUSTOMIZAR TABELAS

### Adicionar novas variantes de tabelas:

```css
/* Tabela zebrada */
table.table-striped tbody tr:nth-child(even) {
    background-color: var(--light-bg);
}

/* Tabela hover */
table.table-hover tbody tr:hover {
    background-color: #f0f0f0;
    cursor: pointer;
}

/* Tabela compacta */
table.table-compact thead th,
table.table-compact tbody td {
    padding: 0.5rem;
}

/* Tabela com bordas */
table.table-bordered,
table.table-bordered tbody td,
table.table-bordered thead th {
    border: 1px solid var(--border-color);
}
```

**Como usar:**
```html
<table class="table-striped table-hover">
    <!-- conteúdo -->
</table>

<table class="table-compact">
    <!-- conteúdo -->
</table>
```

---

## 6️⃣ ADICIONAR NOVO TEMA DE FORMULÁRIO

### Formulário inline:

```css
/* Formulário inline */
.form-inline {
    display: flex;
    gap: 1rem;
    align-items: flex-end;
}

.form-inline .form-group {
    margin-bottom: 0;
    flex: 1;
}

/* Input com ícone */
.input-icon-wrapper {
    position: relative;
}

.input-icon-wrapper input {
    padding-left: 2.5rem;
}

.input-icon {
    position: absolute;
    left: 0.75rem;
    top: 50%;
    transform: translateY(-50%);
    color: var(--text-light);
}
```

**Como usar:**
```html
<form class="form-inline">
    <div class="form-group">
        <label>Email</label>
        <input type="email" placeholder="seu@email.com">
    </div>
    <button class="btn btn-primary">Enviar</button>
</form>
```

---

## 7️⃣ DARK MODE SIMPLES

### Adicionar suporte a dark mode:

```css
/* Dark mode */
@media (prefers-color-scheme: dark) {
    :root {
        --dark-bg: #0a0e27;
        --light-bg: #1a1f3a;
        --text-dark: #e0e0e0;
        --text-light: #a0a0a0;
        --white: #1a1f3a;
        --border-color: #333;
    }

    body {
        background-color: var(--dark-bg);
        color: var(--text-dark);
    }

    .card {
        background-color: var(--light-bg);
    }

    input, textarea, select {
        background-color: var(--light-bg);
        color: var(--text-dark);
        border-color: var(--border-color);
    }
}
```

---

## 8️⃣ ADICIONAR ANIMAÇÕES CUSTOMIZADAS

### Novas animações:

```css
@keyframes bounce {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-10px); }
}

@keyframes rotate {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
}

@keyframes shake {
    0%, 100% { transform: translateX(0); }
    10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
    20%, 40%, 60%, 80% { transform: translateX(5px); }
}

/* Classes para usar as animações */
.animate-bounce {
    animation: bounce 1s infinite;
}

.animate-rotate {
    animation: rotate 2s linear infinite;
}

.animate-shake {
    animation: shake 0.5s;
}
```

**Como usar:**
```html
<div class="card animate-bounce">Pulsa</div>
<div class="card animate-rotate">Gira</div>
<div class="card animate-shake">Balança</div>
```

---

## 9️⃣ CRIAR LAYOUT SIDEBAR

### Adicionar sidebar layout:

```css
.layout-sidebar {
    display: grid;
    grid-template-columns: 250px 1fr;
    min-height: 100vh;
}

.sidebar {
    background-color: var(--primary-color);
    color: white;
    padding: 2rem 1rem;
    position: sticky;
    top: 0;
}

.sidebar ul {
    list-style: none;
    padding: 0;
}

.sidebar li {
    margin-bottom: 1rem;
}

.sidebar a {
    color: white;
    text-decoration: none;
    padding: 0.75rem 1rem;
    display: block;
    border-radius: 5px;
    transition: all 0.3s ease;
}

.sidebar a:hover {
    background-color: rgba(255, 255, 255, 0.2);
}

.main-content {
    padding: 2rem;
}

@media (max-width: 768px) {
    .layout-sidebar {
        grid-template-columns: 1fr;
    }
    
    .sidebar {
        display: none;
    }
}
```

**Como usar:**
```html
<div class="layout-sidebar">
    <aside class="sidebar">
        <ul>
            <li><a href="#">Home</a></li>
            <li><a href="#">Agendamentos</a></li>
            <li><a href="#">Perfil</a></li>
        </ul>
    </aside>
    
    <main class="main-content">
        <!-- Conteúdo -->
    </main>
</div>
```

---

## 🔟 HELPER CLASSES ÚTEIS

### Adicione estas classes úteis:

```css
/* Texto */
.text-uppercase { text-transform: uppercase; }
.text-capitalize { text-transform: capitalize; }
.text-lowercase { text-transform: lowercase; }
.text-bold { font-weight: 700; }
.text-italic { font-style: italic; }

/* Visibilidade */
.visible { display: block !important; }
.invisible { visibility: hidden; }
.sr-only {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip: rect(0, 0, 0, 0);
    white-space: nowrap;
    border-width: 0;
}

/* Bordas */
.border { border: 1px solid var(--border-color); }
.border-top { border-top: 1px solid var(--border-color); }
.border-bottom { border-bottom: 1px solid var(--border-color); }
.rounded { border-radius: 8px; }
.rounded-full { border-radius: 9999px; }

/* Overflow */
.overflow-hidden { overflow: hidden; }
.overflow-auto { overflow: auto; }
.text-ellipsis {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

/* Opacidade */
.opacity-50 { opacity: 0.5; }
.opacity-75 { opacity: 0.75; }
```

---

## 📝 TEMPLATE DE PÁGINA COMPLETA CUSTOMIZADA

```html
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Página Customizada</title>
    <link rel="stylesheet" href="{{ url_for('static', filename='css/styles.css') }}">
    <style>
        /* Customizações específicas desta página */
        :root {
            --primary-color: #1E3A8A; /* Azul */
        }
        
        .hero-custom {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            padding: 4rem 2rem;
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <!-- navbar -->
    </nav>

    <div class="container">
        <section class="hero-custom">
            <h1>Minha Página Customizada</h1>
        </section>
        
        <div class="grid grid-2">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Card 1</h3>
                </div>
                <div class="card-body">
                    Conteúdo
                </div>
            </div>
            
            <div class="card card-bordered">
                <div class="card-header">
                    <h3 class="card-title">Card 2</h3>
                </div>
                <div class="card-body">
                    Conteúdo
                </div>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2024</p>
    </footer>
</body>
</html>
```

---

## 🎯 DICAS FINAIS

1. **Sempre use variáveis CSS** ao invés de cores hardcoded
2. **Teste em mobile** ao fazer customizações
3. **Mantenha a consistência** com a paleta de cores existente
4. **Use classes utilitárias** ao invés de CSS inline
5. **Adicione comentários** em customizações complexas
6. **Verifique o contraste** de cores para acessibilidade

---

**Versão**: 1.0  
**Última atualização**: 2024

Aproveite a customização! 🎨
