const entrada = require('readline-sync');

console.log("=== Estoque de Componentes ===");

const componentes = [];

const quantidadeComponentes = 3


for (let i = 0; i < quantidadeComponentes; i++) {
    const nomeComponente = entrada.question(`Digite o nome do componente ${i + 1}: `);
    const quantidadeComponente = entrada.questionInt(`Digite a quantidade em estoque do componente ${i + 1}: `);
    componentes.push({ nome: nomeComponente, quantidade: quantidadeComponente });
}   
