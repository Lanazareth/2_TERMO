const entrada = require('readline-sync');

console.log("=== Média de Medições ===");

const quantidadeMedicoes = 5;
let somaMedicoes = 0;

for (let i = 1; i <= quantidadeMedicoes; i++) {
    const valorMedicao = entrada.questionFloat(`Digite o valor da medição ${i}: `);
    somaMedicoes += valorMedicao;
}

const mediaMedicoes = somaMedicoes / quantidadeMedicoes;

console.log(`Soma das medições: ${somaMedicoes}`);
console.log(`Média das medições: ${mediaMedicoes}`);
