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
