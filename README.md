# 🐾 Sistema de Gestão - Clínica Veterinária "Vida Animal"

Este repositório contém o projeto prático final desenvolvido para a disciplina de **Ambiente de Dados** do curso de Análise e Desenvolvimento de Sistemas da **Universidade de Fortaleza (UNIFOR)**. O objetivo principal é a modelagem completa, normalização na 3ª Forma Normal (3FN), implementação física e consulta de um banco de dados relacional utilizando o **MySQL** para solucionar os requisitos de negócio da clínica "Vida Animal".

---

## 🎓 Identificação do Projeto

* **Instituição:** Universidade de Fortaleza (UNIFOR)
* **Curso:** Análise e Desenvolvimento de Sistemas (ADS)
* **Semestre:** 3º Semestre
* **Disciplina:** Ambiente de Dados
* **Professora:** Ana Maria
* **Equipe:**
  * Estênio Gabriel
  * Gabriel Brandão

---

## 📖 Cenário 9: Clínica Veterinária "Vida Animal"

O sistema foi projetado com base em um fluxo operacional completo e integrado de uma clínica veterinária dinâmica, cobrindo os seguintes módulos:
* **Recepção e Agendamentos:** Registro de consultas contendo data, hora, dados completos do tutor (Nome completo, CPF, Telefone e Endereço) e dados do pet (Nome, Espécie, Raça, Idade, Sexo, Peso e Histórico Médico).
* **Atendimento Clínico e Prontuário:** Prontuário eletrônico alimentado pelo corpo veterinário (ex: Dr. Carlos) contendo anamnese, exame físico, sintomas relatados, solicitações de exames complementares/laboratoriais, diagnósticos e tratamentos prescritos.
* **Internação e Internamento:** Alocação de animais em leitos hospitalares específicos com identificação única. O sistema controla a data de entrada, previsão de alta, tratamentos administrados, observações clínicas e exige o vínculo do termo de consentimento cirúrgico/intervenção assinado pelo tutor.
* **Controle Rigoroso de Estoque:** Rastreabilidade absoluta de entradas e saídas de medicamentos, informando quantidade, data da movimentação e o profissional responsável pela ação, mitigando desperdícios.
* **Faturamento e Caixa:** Geração automatizada de recibos discriminando serviços prestados, insumos/medicamentos utilizados e os valores correspondentes. Suporte a diferentes formas de pagamento com emissão de comprovantes de liquidação.

---

## 🗄️ Artefatos e Estrutura do Banco de Dados (MySQL)

A entrega cumpre integralmente as exigências acadêmicas de modelagem de dados relacionais e está estruturada da seguinte forma:

### 1. Modelagem Arquitetural
* **Diagrama Entidade-Relacionamento (DER):** Modelo conceitual com o mapeamento visual das entidades, atributos e cardinalidades.
* **Modelo Relacional na 3ª Forma Normal (3FN):** Garantia de integridade de dados e eliminação de redundâncias, dependências parciais ou transitivas.

### 2. Scripts SQL Modulares (`/database`)
Os arquivos SQL foram divididos estrategicamente para garantir uma execução limpa e sem erros de dependência cíclica:
* `01_estrutura_tabelas.sql`: Comandos DDL para criação de todas as tabelas e definição de Chaves Primárias (`PRIMARY KEY`).
* `02_restricoes_fks.sql`: Comandos DDL isolados para alteração de tabelas (`ALTER TABLE`) e criação das Chaves Estrangeiras (`FOREIGN KEY`), garantindo excelente legibilidade física.
* `03_carga_dados.sql`: Massa de dados (DML) consistente para simular o funcionamento em ambiente real da clínica e validar os relatórios.

---

## 📊 Relatórios Gerenciais Exigidos (Consultas SQL)

As consultas SQL foram implementadas no banco de dados e são consumidas diretamente pela nossa interface para gerar painéis executivos rápidos e limpos:

1. **Relatório de Agendamentos do Dia:**
   * *Objetivo:* Listar a agenda corrente para organização do fluxo na recepção.
   * *Dados:* Nome do pet, nome do tutor e telefone do tutor.

2. **Receita Mensal Detalhada (Mês Atual):**
   * *Objetivo:* Demonstrativo analítico da receita mensal corrente.
   * *Dados:* Lista descritiva e detalhada de cada valor que entrou no faturamento da clínica dentro do mês ativo.

3. **Produtividade do Corpo Médico e Procedimentos:**
   * *Objetivo:* Mapear o histórico de atendimentos e produtividade dos veterinários.
   * *Dados:* Relação de todos os médicos veterinários, todos os procedimentos/atendimentos executados por eles e o nome do pet assistido.

4. **Painel de Internações e Balanço Financeiro:**
   * *Objetivo:* Controle clínico-financeiro de leitos ocupados.
   * *Dados:* Relatório de todos os pets em internação corrente, evidenciando os valores já pagos e os valores pendentes de pagamento.

---

## 🛠️ Stack Tecnológica

* **Camada de Persistência:** MySQL (SGBD Relacional)
* **Modelagem:** Workbench / Draw.io
* **Interface Visual (Frontend):** React.js (Interface construída do zero, aplicando uma arquitetura minimalista de alta legibilidade, otimizada em *Dark Mode* para redução do cansaço visual).
* **Camada de Integração (Backend):** Servidor API para comunicação direta com o banco de dados.

---

## 🚀 Como Executar o Projeto

### 1. Preparação do Banco de Dados
Abra o terminal de comandos do MySQL ou o seu SGBD de preferência e execute os arquivos na ordem estrita abaixo:
```bash
mysql -u seu_usuario -p < database/01_estrutura_tabelas.sql
mysql -u seu_usuario -p < database/02_restricoes_fks.sql
mysql -u seu_usuario -p < database/03_carga_dados.sql
