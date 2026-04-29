# RELATÓRIO DE ARQUITETURA - T2Ti ERP Agenda

## 1. VISÃO GERAL DA APLICAÇÃO ATUAL

**Stack Tecnológico:**
- **Frontend:** Flutter 3.22.3 / Dart 3.4.3
- **Gerência de Estado/Navegação:** GetX 5.0
- **Banco de Dados:** Drift (SQLite) - suporte a local e remoto
- **UI:** Material Design + FlexColorScheme
- **Grid/Tabela:** PlutoGrid
- **Autenticação:** JWT Token

## 2. ARQUITETURA ATUAL

```
lib/
├── main.dart
└── app/
    ├── controller/          # Controllers (GetX)
    ├── data/
    │   ├── model/          # Models (DTOs)
    │   ├── provider/       # Providers (API e DB)
    │   │   ├── api/        # API REST
    │   │   └── drift/      # SQLite local
    │   └── repository/     # Repositories
    ├── domain/             # Regras de negócio
    ├── infra/              # Utilitários, constants, session
    ├── page/
    │   ├── modules/        # Módulos de negócio
    │   │   ├── agenda_compromisso/
    │   │   ├── agenda_categoria_compromisso/
    │   │   ├── recado_remetente/
    │   │   └── reuniao_sala/
    │   ├── shared_page/    # Páginas compartilhadas
    │   └── shared_widget/  # Widgets compartilhados
    ├── routes/             # Rotas
    └── translations/       # i18n
```

## 3. PADRÃO DE MÓDULO ATUAL

Cada módulo segue estrutura similar:

```
agenda_compromisso/
├── agenda_compromisso_controller.dart
├── agenda_compromisso_list_page.dart
├── agenda_compromisso_edit_page.dart
├── agenda_compromisso_tab_page.dart
├── agenda_compromisso_convidado_list_page.dart
├── agenda_compromisso_convidado_edit_page.dart
├── agenda_notificacao_list_page.dart
├── agenda_notificacao_edit_page.dart
└── reuniao_sala_evento_list_page.dart
```

**Componentes por módulo:**
- List Page (grid com PlutoGrid)
- Edit Page (formulário)
- Tab Page (container com abas)
- Sub-entidades (convidados, notificações, etc.)
- Controller GetX
- Repository
- Drift Provider
- Model

## 4. RECOMENDAÇÕES PARA 53 MÓDULOS

### 4.1 Estrutura Monorepo Recomendada

```
t2ti-erp-3.0/
├── frontend/                    # Flutter apps
│   ├── agenda/                 # Módulo 1
│   ├── contabilidade/         # Módulo 2
│   ├── frente_caixa/          # Módulo 3
│   └── ...                    # 53 módulos
│
├── backend/                    # Python APIs
│   ├── agenda/                 # Módulo 1
│   ├── contabilidade/         # Módulo 2
│   ├── frente_caixa/          # Módulo 3
│   └── ...                    # 53 módulos
│
└── common/                     # Código compartilhado
    ├── dart/                   # Pacotes Dart compartilhados
    └── python/                 # Pacotes Python compartilhados
```

### 4.2 Padrão Proposed para cada Módulo

```
lib/app/page/modules/{modulo}/
├── {modulo}_list_page.dart
├── {modulo}_edit_page.dart
├── {modulo}_tab_page.dart
├── controller/{modulo}_controller.dart
├── repository/{modulo}_repository.dart
├── provider/{modulo}_provider.dart
└── model/{modulo}_model.dart
```

### 4.3 Backend Python Recomendação

- **Framework:** FastAPI ou Django REST
- **ORM:** SQLAlchemy + Pydantic
- **Estrutura por módulo:**
```
backend/{modulo}/
├── app/
│   ├── __init__.py
│   ├── main.py
│   ├── routers/
│   │   └── {modulo}_router.py
��   ├── schemas/
│   │   └── {modulo}_schema.py
│   ├── models/
│   │   └── {modulo}_model.py
│   └── services/
│       └── {modulo}_service.py
└── requirements.txt
```

### 4.4 Pontos de Atenção

| Item | Recomendação |
|------|--------------|
| **Autenticação** | API Gateway centralizado para JWT |
| **Database** | PostgreSQL compartilhado ou por módulo |
| **Comunicação** | REST API entre frontend e cada backend |
| **Código compartilhado** | Criar packages Dart e Python comuns |
| **Naming** | Padronizar: `nomemodulo_list`, `nomemodulo_edit` |

---

*Documento gerado em: Tue Apr 21 2026*
*Local: http://localhost:52085/homePage*