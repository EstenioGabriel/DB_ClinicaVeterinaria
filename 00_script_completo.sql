-- 01_create_database.sql
DROP DATABASE IF EXISTS clinica_veterinaria;
CREATE DATABASE clinica_veterinaria DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_unicode_ci;
USE clinica_veterinaria;
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
-- 03_foreign_keys.sql
USE clinica_veterinaria;

ALTER TABLE animal ADD CONSTRAINT fk_animal_tutor FOREIGN KEY (id_tutor) REFERENCES tutor(id_tutor);
ALTER TABLE agendamento ADD CONSTRAINT fk_agendamento_animal FOREIGN KEY (id_animal) REFERENCES animal(id_animal);
ALTER TABLE agendamento ADD CONSTRAINT fk_agendamento_veterinario FOREIGN KEY (id_veterinario) REFERENCES veterinario(id_veterinario);
ALTER TABLE atendimento ADD CONSTRAINT fk_atendimento_animal FOREIGN KEY (id_animal) REFERENCES animal(id_animal);
ALTER TABLE atendimento ADD CONSTRAINT fk_atendimento_veterinario FOREIGN KEY (id_veterinario) REFERENCES veterinario(id_veterinario);
ALTER TABLE prontuario ADD CONSTRAINT fk_prontuario_atendimento FOREIGN KEY (id_atendimento) REFERENCES atendimento(id_atendimento);
ALTER TABLE exame ADD CONSTRAINT fk_exame_atendimento FOREIGN KEY (id_atendimento) REFERENCES atendimento(id_atendimento);
ALTER TABLE proc_cirurgico ADD CONSTRAINT fk_proc_cirurgico_atendimento FOREIGN KEY (id_atendimento) REFERENCES atendimento(id_atendimento);
ALTER TABLE internacao ADD CONSTRAINT fk_internacao_animal FOREIGN KEY (id_animal) REFERENCES animal(id_animal);
ALTER TABLE internacao ADD CONSTRAINT fk_internacao_atendimento FOREIGN KEY (id_atendimento) REFERENCES atendimento(id_atendimento);
ALTER TABLE internacao ADD CONSTRAINT fk_internacao_leito FOREIGN KEY (id_leito) REFERENCES leito(id_leito);
ALTER TABLE tratamento_internacao ADD CONSTRAINT fk_tratamento_internacao_internacao FOREIGN KEY (id_internacao) REFERENCES internacao(id_internacao);
ALTER TABLE tratamento_internacao ADD CONSTRAINT fk_tratamento_internacao_medicamento FOREIGN KEY (id_medicamento) REFERENCES medicamento(id_medicamento);
ALTER TABLE movim_estoque ADD CONSTRAINT fk_movim_estoque_medicamento FOREIGN KEY (id_medicamento) REFERENCES medicamento(id_medicamento);
ALTER TABLE recibo ADD CONSTRAINT fk_recibo_tutor FOREIGN KEY (id_tutor) REFERENCES tutor(id_tutor);
ALTER TABLE recibo ADD CONSTRAINT fk_recibo_atendimento FOREIGN KEY (id_atendimento) REFERENCES atendimento(id_atendimento);
ALTER TABLE item_recibo ADD CONSTRAINT fk_item_recibo_recibo FOREIGN KEY (id_recibo) REFERENCES recibo(id_recibo);
ALTER TABLE pagamento ADD CONSTRAINT fk_pagamento_recibo FOREIGN KEY (id_recibo) REFERENCES recibo(id_recibo);
-- 04_inserts.sql
USE clinica_veterinaria;

INSERT INTO tutor (nome, cpf, telefone, endereco) VALUES
('João Silva', '111.111.111-11', '(85) 99999-1111', 'Rua das Flores, 100'),
('Maria Souza', '222.222.222-22', '(85) 99999-2222', 'Av. Central, 250'),
('Carlos Lima', '333.333.333-33', '(85) 99999-3333', 'Rua Norte, 80'),
('Ana Pereira', '444.444.444-44', '(85) 99999-4444', 'Rua Sul, 45'),
('Fernanda Rocha', '555.555.555-55', '(85) 99999-5555', 'Av. Beira Mar, 900');

INSERT INTO animal (nome, especie, raca, idade, sexo, peso, historico_medico, id_tutor) VALUES
('Rex', 'Cachorro', 'Labrador', 5, 'M', 28.50, 'Vacinação em dia', 1),
('Luna', 'Gato', 'Siamês', 3, 'F', 4.20, 'Alergia alimentar', 2),
('Thor', 'Cachorro', 'Poodle', 7, 'M', 8.10, 'Histórico de otite', 3),
('Mel', 'Cachorro', 'Shih-tzu', 2, 'F', 5.60, 'Sem histórico relevante', 4),
('Nina', 'Gato', 'Persa', 4, 'F', 3.90, 'Problemas respiratórios leves', 5),
('Bob', 'Cachorro', 'Vira-lata', 6, 'M', 17.30, 'Recuperado de fratura', 1);

INSERT INTO veterinario (nome, crmv) VALUES
('Dr. Carlos Mendes', 'CRMV-CE-1001'),
('Dra. Beatriz Alves', 'CRMV-CE-1002'),
('Dr. Rafael Costa', 'CRMV-CE-1003');

INSERT INTO agendamento (data_hora, motivo, id_animal, id_veterinario) VALUES
(CURDATE() + INTERVAL 9 HOUR, 'Consulta de rotina', 1, 1),
(CURDATE() + INTERVAL 10 HOUR, 'Vômito e falta de apetite', 2, 2),
(CURDATE() + INTERVAL 14 HOUR, 'Retorno pós-operatório', 3, 1),
(CURDATE() + INTERVAL 16 HOUR, 'Vacinação', 4, 3),
(DATE_ADD(CURDATE(), INTERVAL 1 DAY) + INTERVAL 11 HOUR, 'Avaliação dermatológica', 5, 2);

INSERT INTO atendimento (data_hora, id_animal, id_veterinario) VALUES
(DATE_SUB(NOW(), INTERVAL 10 DAY), 1, 1),
(DATE_SUB(NOW(), INTERVAL 8 DAY), 2, 2),
(DATE_SUB(NOW(), INTERVAL 5 DAY), 3, 1),
(DATE_SUB(NOW(), INTERVAL 3 DAY), 4, 3),
(DATE_SUB(NOW(), INTERVAL 1 DAY), 5, 2),
(NOW(), 6, 1);

INSERT INTO prontuario (anamnese, exame_fisico, sintomas, resultado_exames, diagnostico, tratamento, id_atendimento) VALUES
('Tutor relata coceira frequente.', 'Pele avermelhada.', 'Coceira e irritação.', 'Sem alterações graves.', 'Dermatite leve.', 'Pomada dermatológica por 7 dias.', 1),
('Tutor relata vômitos.', 'Animal apático.', 'Vômito e anorexia.', 'Hemograma solicitado.', 'Gastrite provável.', 'Medicação antiemética e dieta leve.', 2),
('Animal em retorno.', 'Sutura íntegra.', 'Dor leve.', 'Sem infecção.', 'Pós-operatório estável.', 'Continuar anti-inflamatório.', 3),
('Consulta para vacinação.', 'Sem alterações.', 'Nenhum.', 'Não se aplica.', 'Animal saudável.', 'Vacinação aplicada.', 4),
('Respiração ruidosa.', 'Ausculta com ruídos leves.', 'Espirros frequentes.', 'Raio-X solicitado.', 'Rinite felina.', 'Antibiótico e observação.', 5),
('Animal com dor ao andar.', 'Sensibilidade em membro posterior.', 'Claudicação.', 'Raio-X indicado.', 'Suspeita de luxação.', 'Repouso e analgésico.', 6);

INSERT INTO exame (tipo, data_solicitacao, resultado, id_atendimento) VALUES
('Hemograma', DATE_SUB(NOW(), INTERVAL 8 DAY), 'Leucócitos levemente elevados', 2),
('Raio-X', DATE_SUB(NOW(), INTERVAL 5 DAY), 'Sem fratura aparente', 3),
('Raio-X', DATE_SUB(NOW(), INTERVAL 1 DAY), 'Alteração respiratória leve', 5),
('Ultrassom', NOW(), 'Resultado pendente', 6);

INSERT INTO proc_cirurgico (descricao, data_hora, termo_consentimento, id_atendimento) VALUES
('Sutura de ferimento superficial', DATE_SUB(NOW(), INTERVAL 5 DAY), 'Termo assinado pelo tutor', 3),
('Limpeza cirúrgica de ferimento', NOW(), 'Termo assinado pelo tutor', 6);

INSERT INTO leito (identificador, status) VALUES
('LEITO-01', 'OCUPADO'),
('LEITO-02', 'OCUPADO'),
('LEITO-03', 'DISPONIVEL'),
('LEITO-04', 'MANUTENCAO');

INSERT INTO internacao (data_entrada, previsao_alta, observacoes, id_animal, id_atendimento, id_leito) VALUES
(DATE_SUB(NOW(), INTERVAL 2 DAY), DATE_ADD(NOW(), INTERVAL 2 DAY), 'Animal em observação, quadro estável.', 2, 2, 1),
(DATE_SUB(NOW(), INTERVAL 1 DAY), DATE_ADD(NOW(), INTERVAL 3 DAY), 'Recuperação pós-procedimento.', 6, 6, 2);

INSERT INTO medicamento (nome, quantidade_estoque) VALUES
('Dipirona', 100),
('Antibiótico Pet', 50),
('Anti-inflamatório Pet', 40),
('Soro fisiológico', 80),
('Pomada dermatológica', 30);

INSERT INTO tratamento_internacao (descricao, data_hora, dosagem, id_internacao, id_medicamento) VALUES
('Aplicação de antiemético e hidratação', DATE_SUB(NOW(), INTERVAL 1 DAY), '1 dose', 1, 4),
('Administração de antibiótico', NOW(), '2ml', 1, 2),
('Controle de dor pós-procedimento', NOW(), '1 comprimido', 2, 1);

INSERT INTO movim_estoque (tipo, quantidade, data, responsavel, id_medicamento) VALUES
('ENTRADA', 100, DATE_SUB(NOW(), INTERVAL 20 DAY), 'Ana Recepção', 1),
('ENTRADA', 50, DATE_SUB(NOW(), INTERVAL 20 DAY), 'Ana Recepção', 2),
('ENTRADA', 40, DATE_SUB(NOW(), INTERVAL 20 DAY), 'Ana Recepção', 3),
('SAIDA', 2, DATE_SUB(NOW(), INTERVAL 1 DAY), 'Dr. Carlos Mendes', 1),
('SAIDA', 1, NOW(), 'Dra. Beatriz Alves', 2),
('SAIDA', 3, NOW(), 'Dr. Carlos Mendes', 4);

INSERT INTO recibo (data_emissao, status_pagamento, valor_total, id_tutor, id_atendimento) VALUES
(DATE_SUB(NOW(), INTERVAL 10 DAY), 'PAGO', 180.00, 1, 1),
(DATE_SUB(NOW(), INTERVAL 8 DAY), 'PARCIAL', 550.00, 2, 2),
(DATE_SUB(NOW(), INTERVAL 5 DAY), 'PAGO', 700.00, 3, 3),
(DATE_SUB(NOW(), INTERVAL 3 DAY), 'PAGO', 120.00, 4, 4),
(DATE_SUB(NOW(), INTERVAL 1 DAY), 'PENDENTE', 400.00, 5, 5),
(NOW(), 'PARCIAL', 900.00, 1, 6);

INSERT INTO item_recibo (descricao, valor, tipo, id_recibo) VALUES
('Consulta veterinária', 120.00, 'SERVICO', 1),
('Pomada dermatológica', 60.00, 'MEDICAMENTO', 1),
('Consulta de emergência', 150.00, 'SERVICO', 2),
('Internação diária', 300.00, 'INTERNACAO', 2),
('Medicação aplicada', 100.00, 'MEDICAMENTO', 2),
('Procedimento cirúrgico', 500.00, 'PROCEDIMENTO', 3),
('Exame de imagem', 200.00, 'EXAME', 3),
('Vacinação', 120.00, 'SERVICO', 4),
('Consulta + exame respiratório', 400.00, 'SERVICO', 5),
('Procedimento e internação', 900.00, 'INTERNACAO', 6);

INSERT INTO pagamento (valor_pago, data_pagamento, forma_pagamento, id_recibo) VALUES
(180.00, DATE_SUB(NOW(), INTERVAL 10 DAY), 'PIX', 1),
(300.00, DATE_SUB(NOW(), INTERVAL 8 DAY), 'CARTAO_CREDITO', 2),
(700.00, DATE_SUB(NOW(), INTERVAL 5 DAY), 'PIX', 3),
(120.00, DATE_SUB(NOW(), INTERVAL 3 DAY), 'DINHEIRO', 4),
(400.00, NOW(), 'CARTAO_DEBITO', 6);
-- 05_relatorios.sql
USE clinica_veterinaria;

-- 1. Agendamentos do dia: pets, tutores e telefone do tutor.
SELECT ag.id_agendamento, ag.data_hora, a.nome AS nome_pet, t.nome AS nome_tutor,
       t.telefone AS telefone_tutor, v.nome AS veterinario, ag.motivo
FROM agendamento ag
JOIN animal a ON a.id_animal = ag.id_animal
JOIN tutor t ON t.id_tutor = a.id_tutor
JOIN veterinario v ON v.id_veterinario = ag.id_veterinario
WHERE DATE(ag.data_hora) = CURDATE()
ORDER BY ag.data_hora;

-- 2. Valores recebidos da clínica no mês atual.
SELECT p.id_pagamento, p.data_pagamento, p.valor_pago, p.forma_pagamento,
       r.id_recibo, t.nome AS tutor, a.nome AS pet,
       GROUP_CONCAT(ir.descricao SEPARATOR ' | ') AS itens_cobrados
FROM pagamento p
JOIN recibo r ON r.id_recibo = p.id_recibo
JOIN tutor t ON t.id_tutor = r.id_tutor
JOIN atendimento atd ON atd.id_atendimento = r.id_atendimento
JOIN animal a ON a.id_animal = atd.id_animal
LEFT JOIN item_recibo ir ON ir.id_recibo = r.id_recibo
WHERE MONTH(p.data_pagamento) = MONTH(CURDATE())
  AND YEAR(p.data_pagamento) = YEAR(CURDATE())
GROUP BY p.id_pagamento, p.data_pagamento, p.valor_pago, p.forma_pagamento,
         r.id_recibo, t.nome, a.nome
ORDER BY p.data_pagamento;

-- 3. Veterinários, atendimentos e procedimentos, indicando o pet.
SELECT v.nome AS veterinario, v.crmv, atd.id_atendimento,
       atd.data_hora AS data_atendimento, a.nome AS pet,
       COALESCE(pc.descricao, 'Sem procedimento cirúrgico') AS procedimento
FROM veterinario v
LEFT JOIN atendimento atd ON atd.id_veterinario = v.id_veterinario
LEFT JOIN animal a ON a.id_animal = atd.id_animal
LEFT JOIN proc_cirurgico pc ON pc.id_atendimento = atd.id_atendimento
ORDER BY v.nome, atd.data_hora;

-- 4. Pets em internação e valores pagos/pendentes.
SELECT i.id_internacao, a.nome AS pet, t.nome AS tutor, l.identificador AS leito,
       i.data_entrada, i.previsao_alta, r.valor_total,
       COALESCE(SUM(p.valor_pago), 0) AS valor_pago,
       (r.valor_total - COALESCE(SUM(p.valor_pago), 0)) AS valor_pendente,
       r.status_pagamento
FROM internacao i
JOIN animal a ON a.id_animal = i.id_animal
JOIN tutor t ON t.id_tutor = a.id_tutor
JOIN leito l ON l.id_leito = i.id_leito
JOIN atendimento atd ON atd.id_atendimento = i.id_atendimento
LEFT JOIN recibo r ON r.id_atendimento = atd.id_atendimento
LEFT JOIN pagamento p ON p.id_recibo = r.id_recibo
WHERE l.status = 'OCUPADO'
GROUP BY i.id_internacao, a.nome, t.nome, l.identificador,
         i.data_entrada, i.previsao_alta, r.valor_total, r.status_pagamento
ORDER BY i.data_entrada;
