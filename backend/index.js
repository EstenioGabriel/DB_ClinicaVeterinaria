const express = require ('express');
const cors = require ('cors');
const mysql2 = require ('mysql2');

require('dotenv').config();

const app = express();

app.use(cors());
app.use(express.json());

const db = mysql2.createConnection({
    host: 'localhost',
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: 'clinica_veterinaria',
    dateStrings: true
});

db.connect((err) =>{
    if(err){
        console.error("Erro ao conectar ao banco.", err);   
        return;
    }
    console.log("Conectado ao banco com sucesso.");
});

app.get('/api', (req, res) =>{
    res.json({ mensagem: "Api da clinica veterinaria rodando!"});
});

app.get('/api/agendamentos', (req, res) => {
    const query = `
        SELECT * FROM agendamento;
    `

    db.query(query, (err, results) => {
        if(err) {
            console.log("Erro ao executar busca", err);
            return res.status(500).json({ erro: "Erro ao buscar os agendamentos de hoje"});
        }
        res.json(results);
    });
});

app.get('/api/animal', (req, res) => {
    const query = `
        SELECT * FROM animal;
    `

    db.query(query, (err, result) =>{
        if(err){
            console.log("Erro ao executar busca", err);
            return res.status(500).json({ erro: "Erro ao buscar animais"});
        }
        res.json(result);
    });
});

app.get('/api/atendimento', (req,res) => {
    const query = `
        SELECT * FROM atendimento;
    `

    db.query(query, (err, result) => {
        if(err){
            console.log("Erro ao executar busca", err);
            return res.status(500).json({ erro: "Erro ao buscar atendimentos"});
        }
        res.json(result);
    });
});

app.get('/api/exame', (req, res) => {
    const query = `
        SELECT * FROM exame;
    `

    db.query(query, (err, result) =>{
        if(err){
            console.log("Erro ao executar busca", err);
            return res.status(500).json({erro: "Erro ao buscar atendimento"});
        }
        res.json(result);
    });
});

app.get('/api/internacao', (req, res) => {
    const query = `
        SELECT * FROM internacao;
    `

    db.query(query, (err, result) => {
        if(err){
            console.log("Erro ao executar busca", err);
            return res.status(500).json({erro: "Erro ao buscar internacoes"});
        }
        res.json(result);
    });
});

app.get('/api/item_recibo', (req, res) => {
    const query = `
        SELECT * FROM item_recibo;
    `

    db.query(query, (err, result) => {
        if(err){
            console.log("Erro ao executar comando");
            return res.status(500).json({erro: "Erro ao buscar recibos"});
        }
        res.json(result);
    });
});

app.get('/api/leito', (req, res) => {
    const query = `
        SELECT * FROM leito;
    `

    db.query(query, (err, result) => {
        if(err){
            console.log("Erro ao executar comando");
            return res.status(500).json({erro: "Erro ao buscar leios"});
        }
        res.json(result);
    });
});

app.get('/api/medicamento', (req, res) => {
    const query = `
        SELECT * FROM medicamento;
    `

    db.query(query, (err, result) => {
        if(err){
            console.log("Erro ao executar comando");
            return res.status(500).json({erro: "Erro ao buscar medicamentos"});
        }
        res.json(result);
    });
});

app.get('/api/movim_estoque', (req, res) => {
    const query = `
        SELECT * FROM movim_estoque;
    `
    
    db.query(query, (err, result) => {
        if(err){
            console.log("Erro ao executar");
            return res.status(500).json({erro: "Erro ao buscar movimentacao do estoque"});
        }
        res.json(result);
    });
});

app.get('/api/pagamento', (req, res) => {
    const query = `
        SELECT * FROM pagamento;
    `

    db.query(query, (err, result) => {
        if(err){
            console.log("Erro ao executar comando");
            return res.status(500).json({erro: "Erro ao buscar pagamentos"});
        }
        res.json(result);
    });
});

app.get('/api/procedimento_cirurgico', (req, res) => {
    const query = `
        SELECT * FROM proc_cirurgico;
    `

    db.query(query, (err, result) => {
        if(err){
            console.log("Erro ao executar comando");
            return res.status(500).json({erro: "Erro ao buscar procedimentos cirurgicos"});
        }
        res.json(result);
    });
});

app.get('/api/prontuario', (req, res) => {
    const query = `
        SELECT * FROM prontuario;
    `

    db.query(query, (err, result) => {
        if(err){
            console.log("Erro ao executar comando");
            return res.status(500).json({erro: "Erro ao buscar prontuario"});
        }
        res.json(result);
    });
});

app.get('/api/recibo', (req, res) => {
    const query = `
        SELECT * FROM recibo;
    `

    db.query(query, (err, result) => {
        if(err){
            console.log("Erro ao executar busca");
            return res.status(500).json({erro: "Erro ao buscar recibos"});
        }
        res.json(result);
    });
});


app.get('/api/tratamento_internacao', (req, res) => {
    const query = `
        SELECT * FROM tratamento_internacao;
    `

    db.query(query, (err, result) => {
        if(err){
            console.log("Erro ao executar comando");
            return res.status(500).json({erro: "Erro ao buscar tratamento_internacao"});            
        }
        res.json(result);
    });
});

app.get('/api/tutor', (req, res) => {
    const query = `
        SELECT * FROM tutor;
    `

    db.query(query, (err, result) => {
        if(err){
            console.log("Erro ao executar comando");
            return res.status(500).json({erro: "Erro ao buscar tutores"});
        }
        res.json(result);
    });
});

app.get('/api/veterinario', (req, res) => {
    const query = `
        SELECT * FROM veterinario;
    `

    db.query(query, (err, result) => {
        if(err){
            console.log("Erro ao executar comando");
            return res.status(500).json({erro: "Erro ao buscar veterinarios"});
        }
        res.json(result);
    });
});

// Pedidos do cliente

app.get('/api/relatorioAgendamento', (req, res) => {
    const query = `
        SELECT
            animal.nome AS nome_do_pet,
            tutor.nome AS nome_do_tutor,
            tutor.telefone AS telefone_do_tutor,
            agendamento.data_hora AS data_da_consulta
        FROM agendamento
        INNER JOIN animal ON agendamento.id_animal
        INNER JOIN tutor ON animal.id_tutor = tutor.id_tutor;
    `
    db.query(query, (err, result) => {
        if(err){
            console.log("Erro ao executar comando");
            return json.status(500).json({erro: "Erro ao buscar relatorio de agendamentos"});
        }
        res.json(result);
    });
});

app.get('/api/valoresRecebidos', (req, res) => {
    const query = `
        SELECT 
            pagamento.id_pagamento AS codigo_transacao,
            pagamento.data_pagamento AS data_da_entrada,
            tutor.nome AS nome_do_tutor,
            animal.nome AS nome_do_pet,
            item_recibo.descricao AS descricao_do_item,
            item_recibo.tipo AS categoria_do_servico,
            pagamento.forma_pagamento AS meio_de_pagamento,
            item_recibo.valor AS valor_recebido
        FROM pagamento
        INNER JOIN recibo ON pagamento.id_recibo = recibo.id_recibo
        INNER JOIN tutor ON recibo.id_tutor = tutor.id_tutor
        INNER JOIN atendimento ON recibo.id_atendimento = atendimento.id_atendimento
        INNER JOIN animal ON atendimento.id_animal = animal.id_animal
        INNER JOIN item_recibo ON recibo.id_recibo = item_recibo.id_recibo
        WHERE MONTH(pagamento.data_pagamento) = MONTH(CURRENT_DATE())
        AND YEAR(pagamento.data_pagamento) = YEAR(CURRENT_DATE())
        ORDER BY pagamento.data_pagamento DESC;
    `

    db.query(query, (err, result) => {
        if(err){
            console.log("Erro ao executar comando");
            return res.status(500).json({erro: "Erro ao buscar valores recebidos do mes atual"});
        }
        res.json(result);
    });
});


const PORT = 3000;
app.listen(PORT, () =>{
    console.log(`Servidor rodando na PORTA:${PORT}`)
});