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
