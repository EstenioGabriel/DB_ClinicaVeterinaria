Cenário 9 – Sistema para Clínica Veterinária
Em uma movimentada manhã de segunda-feira, a Clínica Veterinária "Vida Animal" inicia suas
atividades com a chegada dos primeiros tutores e seus pets. A recepcionista, Ana, acessa o
sistema para verificar os agendamentos do dia. Cada agendamento contém informações como
data, hora, nome do tutor, nome do animal e motivo da consulta. Ao atender um novo cliente,
Ana realiza o cadastro do tutor, registrando dados como nome completo, CPF, telefone e
endereço. Em seguida, ela cadastra o animal, associando-o ao tutor. As informações do animal
incluem nome, espécie, raça, idade, sexo, peso e histórico médico. O veterinário Dr. Carlos
chama o próximo paciente para consulta. Durante o atendimento, ele realiza a anamnese,
exame físico e, se necessário, solicita exames complementares. Todas essas informações são
registradas no prontuário eletrônico do animal, que inclui: data e hora do atendimento,
veterinário responsável, sintomas relatados, resultados de exames, diagnóstico, tratamento
prescrito. O prontuário é essencial para acompanhar a evolução clínica do paciente e deve ser
mantido atualizado a cada visita. Se o animal necessita de exames laboratoriais ou de imagem,
o sistema registra a solicitação, associando-a ao atendimento correspondente. Os resultados
são posteriormente anexados ao prontuário. Para procedimentos cirúrgicos, é necessário o
preenchimento de um termo de consentimento assinado pelo tutor, autorizando a intervenção.
Em casos que requerem internação, o animal é alocado em um leito disponível. O sistema
registra a data de entrada, previsão de alta, tratamentos administrados e observações clínicas.
Cada leito possui um identificador único e está associado ao animal internado. A clínica mantém
um estoque de medicamentos que é rigorosamente controlado. Cada entrada e saída de
medicamento é registrada, informando o nome do medicamento, quantidade, data de
movimentação e responsável pela ação. Isso garante a disponibilidade de insumos e evita
desperdícios. Após o atendimento, a recepcionista gera o recibo para o tutor, detalhando os
serviços prestados, medicamentos utilizados e seus respectivos valores. O sistema permite
diferentes formas de pagamento e emite comprovantes para o cliente.
Neste cenário, solicitamos a criação do Diagrama de Entidade e Relacionamento, Modelo de
Entidade e Relacionamento na 3ª Forma normal, os scripts de criação do banco de dados
(separar criação de FKs), scripts de carga de dados para possibilitar consultas e os scripts SQL
para gerar os seguintes relatórios:
1. Relatório de agendamentos para o dia, indicando quais os nomes dos pets, seus tutores
e o telefone do tutor.
2. Relação de valores recebidos da clínica no mês atual, indicando uma lista descritiva de
cada um dos valores que entraram na receita mensal da clínica.
3. Relação de todos os médicos veterinários e todos os procedimentos e atendimentos
feitos por eles na clínica, indicando o nome pet que foi atendido/visto.
4. Relatório de todos os Pets que estão em internação e os valores pagos e pendentes de
pagamento.

