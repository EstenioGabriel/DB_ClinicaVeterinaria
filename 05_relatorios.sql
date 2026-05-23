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
