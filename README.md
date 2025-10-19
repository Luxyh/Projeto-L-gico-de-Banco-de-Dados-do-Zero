# 🧰 Banco de Dados de Oficina Mecânica

Este projeto modela o **banco de dados completo de uma oficina mecânica**, incluindo clientes, veículos, ordens de serviço, equipes, mecânicos, peças e serviços prestados.

---

## 📂 Estrutura do Projeto

**Entidades principais:**
- **Cliente** — informações básicas dos clientes.
- **Veículo** — veículos cadastrados de cada cliente.
- **Equipe** — equipes responsáveis pelos atendimentos.
- **Mecânico** — membros de cada equipe.
- **OrdemServico** — registro de serviços executados e peças utilizadas.
- **Serviço** — catálogo de serviços oferecidos.
- **Peca** — catálogo e estoque de peças.
- **TabelaReferencia** — controle de tabelas vigentes de preços.

---

## ⚙️ Funcionalidades do Script
- Criação de todas as tabelas com relacionamentos e restrições (`FOREIGN KEY`, `CASCADE`).
- Inserção de dados de exemplo.
- Consultas SQL demonstrando operações comuns:
  - Listagem de OS em andamento.
  - Total gasto por cliente.
  - Serviços por equipe.
  - Peças mais utilizadas.
  - Clientes com mais de uma OS.

---

## 🧩 Requisitos
- **MySQL Workbench 8.0+**
- Banco criado com nome `OficinaDB`

---

## ▶️ Execução
1. Crie o banco de dados:
   ```sql
   CREATE DATABASE OficinaDB;
   USE OficinaDB;
