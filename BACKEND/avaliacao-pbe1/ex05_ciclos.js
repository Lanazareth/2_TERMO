const entrada = require('readline-sync');

console.log("=== Tabela de Produção ===");

const pecas = entrada.questionFloat("Digite a quantidade de peças por ciclo: ");

for (let i = 1; i <= 10; i++) {
    const producaoAcumulada = pecas * i;
    console.log(`Ciclo ${i}: ${producaoAcumulada} peças`);
}