const entrada = require('readline-sync');

console.log("=== Controle de Qualidade de pecas ===");

const peso = entrada.questionFloat("Digite o peso da peca: ");

 if (peso >= 95 && peso <= 105) {
    console.log("PEÇA APROVADA");
 } else {
    console.log("PEÇA REPROVADA");
 }