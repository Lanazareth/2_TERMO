
const express = require('express');
const sqlite3 = require('sqlite3').verbose();
const cors = require('cors');
const path = require('path');

const app = express();
const PORTA = 3000;

// Configurações do servidor
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Caminho do banco SQLite
const caminhoBanco = path.join(__dirname, 'contato.db');

// Abre ou cria o banco de dados
const db = new sqlite3.Database(caminhoBanco, (erro) => {
    if (erro) {
        console.error('Erro ao abrir o banco:', erro.message);
    } else {
        console.log('Banco SQLite conectado!');
        console.log('Banco utilizado:', caminhoBanco);
    }
});

// Cria a tabela de mensagens
db.run(`
    CREATE TABLE IF NOT EXISTS mensagens (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        email TEXT NOT NULL,
        mensagem TEXT NOT NULL,
        data_envio DATETIME DEFAULT CURRENT_TIMESTAMP
    )
`, (erro) => {
    if (erro) {
        console.error('Erro ao criar tabela:', erro.message);
    } else {
        console.log('Tabela mensagens pronta!');
    }
});

// Rota para cadastrar mensagens
app.post('/api/mensagens', (req, res) => {

    const { nome, email, mensagem } = req.body;

    if (!nome || !email || !mensagem) {
        return res.status(400).json({
            erro: 'Preencha todos os campos.'
        });
    }

    const sql = `
        INSERT INTO mensagens (nome, email, mensagem)
        VALUES (?, ?, ?)
    `;

    db.run(sql, [nome, email, mensagem], function (erro) {

        if (erro) {
            console.error('Erro ao salvar:', erro.message);

            return res.status(500).json({
                erro: 'Não foi possível salvar a mensagem.'
            });
        }

        res.status(201).json({
            mensagem: 'Mensagem enviada com sucesso!',
            id: this.lastID
        });
    });
});

// Rota para consultar mensagens
app.get('/api/mensagens', (req, res) => {

    db.all(
        'SELECT * FROM mensagens ORDER BY id DESC',
        [],
        (erro, resultados) => {

            if (erro) {
                return res.status(500).json({
                    erro: 'Erro ao consultar mensagens.'
                });
            }

            res.json(resultados);
        }
    );
});

// Inicia o servidor
app.listen(PORTA, () => {
    console.log(`Servidor rodando em http://localhost:${PORTA}`);
});
