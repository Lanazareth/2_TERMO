const entrada = require('readline-sync');

console.log("=== Estoque de Componentes ===");

const componentes = [];

const quantidadeComponentes = 3;
const nomesComponentes = ["lidia", "Bruno", "Celso"];

for (let i = 0; i < quantidadeComponentes; i++) {
    const nomeComponente = nomesComponentes[i];
    const quantidade = entrada.questionInt(`Digite a quantidade do componente ${nomeComponente}: `);
    const estoqueMinimo = entrada.questionInt(`Digite o estoque mínimo do componente ${nomeComponente}: `);

    const componente = {
        nome: nomeComponente,
        quantidade: quantidade,
        estoqueMinimo: estoqueMinimo
    };

    componentes.push(componente);
}

console.log("\n=== Componentes com Estoque Abaixo do Mínimo ===");
for (const componente of componentes) {
    if (componente.quantidade < componente.estoqueMinimo) {
        console.log(`Componente: ${componente.nome} - Quantidade: ${componente.quantidade} - Estoque Mínimo: ${componente.estoqueMinimo}`);
    }
}