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
    database: 'clinica_veterinaria'
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

app.get('/api/agendamentos/todos', (req, res) => {
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


const PORT = 3000;
app.listen(PORT, () =>{
    console.log(`Servidor rodando na PORTA:${PORT}`)
});