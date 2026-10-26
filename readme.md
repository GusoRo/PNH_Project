# Sistema de Gestao de Delivery - Prato na Hora

Repositorio oficial da solucao de banco de dados relacional desenvolvida para a empresa ficticia Prato na Hora, especializada em delivery de marmitas para trabalhadores e estudantes. O sistema processa cerca de 100 pedidos diarios e centraliza as operacoes que antes eram descentralizadas em planilhas e cadernos.

---

## Sumario
1. [Sobre o Dominio](#1-sobre-o-dominio)
2. [Contextualizacao e Problemas Enfrentados](#2-contextualizacao-e-problemas-enfrentados)
3. [Solucao com SGBD Relacional](#3-solucao-com-sgbd-relacional)
4. [Modelagem Logica do Banco de Dados](#4-modelagem-logica-do-banco-de-dados)
5. [Aplicacao das Formas Normais (1FN a 4FN)](#5-aplicacao-das-formas-normais-1fn-a-4fn)
6. [Estrutura do Repositorio](#6-estrutura-do-repositorio)
7. [Instrucoes de Execucao e Hosting na Cloud (Aiven / Azure)](#7-instrucoes-de-execucao-e-hosting-na-cloud-aiven--azure)
8. [Procedimento de Dump](#8-procedimento-de-dump)
9. [Autoria](#9-autoria)

---

## 1. Sobre o Dominio
A empresa Prato na Hora atende diariamente dezenas de clientes com refeicoes rapidas e saudaveis. O sistema gerencia o fluxo operacional completo: cadastro de funcionarios, clientes, telefones de contato, cardapio de marmitas (produtos com controle de estoque), emissao de pedidos, itens detalhados da venda e controle financeiro de pagamentos.

---

## 2. Contextualizacao e Problemas sem um SGBD Relacional
Operando sem um banco de dados centralizado, a empresa sofria com graves gargalos operacionais:
* **Problema 1: Pedidos duplicados** - Dois funcionarios registraram o mesmo pedido em planilhas diferentes, resultando no preparo duplo de marmitas e desperdicio de alimentos.
* **Problema 2: Falta de controle dos ingredientes/estoque** - Vendas de marmitas foram efetuadas acima da capacidade real de producao devido a falta de atualizacao em tempo real, gerando atrasos nas entregas.
* **Problema 3: Informacoes incorretas dos clientes** - Alteracoes de endereco feitas em apenas uma das planilhas causaram entregas em locais errados por parte dos entregadores.
* **Problema 4: Erros nos pagamentos** - Divergencias entre valores de vendas e valores recebidos devido ao controle separado entre pedidos e pagamentos.
* **Problema 5: Perda de informacoes** - A exclusao acidental de uma planilha por um funcionario resultou na perda permanente de pedidos diarios por falta de rotinas de backup e seguranca.

---

## 3. Solucao com SGBD Relacional
A transicao para um SGBD relacional (MySQL ou PostgreSQL) garantiu:
* **Centralizacao e Atomicidade (ACID):** Dados unificados impedindo concorrencia desordenada e apagamentos acidentais.
* **Controle de Estoque Automatizado:** Atualizacao imediata do estoque a cada item vendido.
* **Integridade Referencial (FOREIGN KEY):** Bloqueio de registros orfaos ou vinculados a clientes/funcionarios inexistentes.
* **Rastreabilidade Financeira:** Vinculo direto e obrigatorio entre o pedido e seu respectivo pagamento.

---

## 4. Modelagem Logica do Banco de Dados

O banco de dados e composto por 7 tabelas principais:
1. **`funcionarios`**: Dados da equipe (atendentes, caixa, entregadores, gerente, cozinha).
2. **`clientes`**: Informacoes de cadastro e enderecos dos compradores.
3. **`cliente_telefones`**: Numeros de contato dos clientes (tabela filha normalizada).
4. **`produtos`**: Catalogo de marmitas, precos e quantidade disponivel em estoque.
5. **`pedidos`**: Cabecalho de compras vinculando cliente e funcionario responsavel.
6. **`itens_pedido`**: Tabela associativa que resolve a relacao N:M entre pedidos e produtos.
7. **`pagamentos`**: Controle financeiro atrelado diretamente ao ID do pedido.

> O Diagrama Entidade-Relacionamento (DER) detalhado esta disponivel na pasta `/docs/modelo_logico.png`.

---

## 5. Aplicacao das Formas Normais

* **1FN (Primeira Forma Normal):** Atributos atomicos garantidos. Telefones dos clientes foram isolados na tabela auxiliar `cliente_telefones`, eliminando listas e grupos repetitivos.
* **2FN (Segunda Forma Normal):** Ausencia de dependencia parcial. Na tabela associativa `itens_pedido`, guardamos apenas quantidade e preco unitario do item, enquanto os dados descritivos da marmita permanecem exclusivamente na tabela `produtos`.
* **3FN (Terceira Forma Normal):** Ausencia de dependencias transitivas. Cada atributo nao-chave depende exclusivamente da chave primaria da tabela.
* **4FN (Quarta Forma Normal):** Remocao de dependencias multivaloradas cruzadas e independentes, separando dados de contato em estruturas relacionais proprias.

---

## 6. Estrutura do Repositorio

```text
/
├── database/
│   ├── 01_schema.sql         # Script DDL de criacao do banco e tabelas (comentado)
│   ├── 02_seed.sql           # Script DML com inputs (minimo 5 registros por tabela)
│   ├── 03_queries.sql        # As 15 consultas SQL contextualizadas (Joins, Aggregations, etc.)
│   └── dump_prato_na_hora.sql# Backup completo do banco (Estrutura + Dados)
├── docs/
│   ├── modelo_logico.png     # Imagem do Diagrama Entidade-Relacionamento
│   └── apresentacao.pdf      # Slides oficiais de apresentacao do projeto
└── README.md                 # Documentacao principal do repositorio
```

---

## 7. Instrucoes de Execucao e Hosting na Cloud (Aiven / Azure)

1. Acesse o painel da sua plataforma escolhida (Aiven ou Azure Database).
2. Provisione uma instancia de banco de dados MySQL ou PostgreSQL.
3. Obtenha os parametros de conexao (Host, Porta, Usuario, Senha).
4. Utilize uma ferramenta de gestao (como DBeaver, pgAdmin ou MySQL Workbench) para conectar-se ao servidor na nuvem.
5. Execute os scripts na ordem:
   - `database/01_schema.sql`
   - `database/02_seed.sql`
   - `database/03_queries.sql`

---

## 8. Procedimento de Dump

Para exportar a estrutura e os dados atualizados do banco hospedado na nuvem:

* **No MySQL (mysqldump):**
  ```bash
  mysqldump -h <HOST_NUVEM> -P <PORTA> -u <USUARIO> -p prato_na_hora_db > database/dump_prato_na_hora.sql
  ```
* **No PostgreSQL (pg_dump):**
  ```bash
  pg_dump -h <HOST> -p <PORTA> -U <USUARIO> -d prato_na_hora_db -F p -f database/dump_prato_na_hora.sql
  ```

---

## 9. Autoria
Projeto desenvolvido para fins academicos e praticos de modelagem, estruturacao e administracao de Bancos de Dados Relacionais aplicados ao setor de delivery de alimentos.