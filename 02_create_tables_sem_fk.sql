-- 02_create_tables_sem_fk.sql
USE clinica_veterinaria;

CREATE TABLE tutor (
    id_tutor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    endereco VARCHAR(150)
) ENGINE=InnoDB;

CREATE TABLE animal (
    id_animal INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especie VARCHAR(50) NOT NULL,
    raca VARCHAR(80),
    idade INT,
    sexo ENUM('M','F') NOT NULL,
    peso DECIMAL(6,2),
    historico_medico TEXT,
    id_tutor INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE veterinario (
    id_veterinario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    crmv VARCHAR(30) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE agendamento (
    id_agendamento INT AUTO_INCREMENT PRIMARY KEY,
    data_hora DATETIME NOT NULL,
    motivo VARCHAR(255),
    id_animal INT NOT NULL,
    id_veterinario INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE atendimento (
    id_atendimento INT AUTO_INCREMENT PRIMARY KEY,
    data_hora DATETIME NOT NULL,
    id_animal INT NOT NULL,
    id_veterinario INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE prontuario (
    id_prontuario INT AUTO_INCREMENT PRIMARY KEY,
    anamnese TEXT,
    exame_fisico TEXT,
    sintomas TEXT,
    resultado_exames TEXT,
    diagnostico TEXT,
    tratamento TEXT,
    id_atendimento INT NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE exame (
    id_exame INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(80) NOT NULL,
    data_solicitacao DATETIME NOT NULL,
    resultado TEXT,
    id_atendimento INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE proc_cirurgico (
    id_procedimento INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL,
    data_hora DATETIME NOT NULL,
    termo_consentimento VARCHAR(255),
    id_atendimento INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE leito (
    id_leito INT AUTO_INCREMENT PRIMARY KEY,
    identificador VARCHAR(30) NOT NULL UNIQUE,
    status ENUM('DISPONIVEL','OCUPADO','MANUTENCAO') NOT NULL DEFAULT 'DISPONIVEL'
) ENGINE=InnoDB;

CREATE TABLE internacao (
    id_internacao INT AUTO_INCREMENT PRIMARY KEY,
    data_entrada DATETIME NOT NULL,
    previsao_alta DATETIME,
    observacoes TEXT,
    id_animal INT NOT NULL,
    id_atendimento INT NOT NULL,
    id_leito INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE medicamento (
    id_medicamento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    quantidade_estoque INT NOT NULL DEFAULT 0
) ENGINE=InnoDB;

CREATE TABLE tratamento_internacao (
    id_tratamento INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL,
    data_hora DATETIME NOT NULL,
    dosagem VARCHAR(80),
    id_internacao INT NOT NULL,
    id_medicamento INT NULL
) ENGINE=InnoDB;

CREATE TABLE movim_estoque (
    id_movimentacao INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('ENTRADA','SAIDA') NOT NULL,
    quantidade INT NOT NULL,
    data DATETIME NOT NULL,
    responsavel VARCHAR(100) NOT NULL,
    id_medicamento INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE recibo (
    id_recibo INT AUTO_INCREMENT PRIMARY KEY,
    data_emissao DATETIME NOT NULL,
    status_pagamento ENUM('PAGO','PENDENTE','PARCIAL') NOT NULL DEFAULT 'PENDENTE',
    valor_total DECIMAL(10,2) NOT NULL,
    id_tutor INT NOT NULL,
    id_atendimento INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE item_recibo (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    id_recibo INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    valor_pago DECIMAL(10,2) NOT NULL,
    data_pagamento DATETIME NOT NULL,
    forma_pagamento ENUM('DINHEIRO','PIX','CARTAO_CREDITO','CARTAO_DEBITO') NOT NULL,
    id_recibo INT NOT NULL
) ENGINE=InnoDB;
