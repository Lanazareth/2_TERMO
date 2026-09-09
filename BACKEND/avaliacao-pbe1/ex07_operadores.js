const entrada = require('readline-sync');

console.log("=== Lista de Operadores ===");

const operadores = [];
const quantidadeOperadores = 5;

for (let i = 0; i < quantidadeOperadores; i++) {
    const nomeOperador = entrada.question(`Digite o nome do operador ${i + 1}: `);
    operadores.push(nomeOperador);
}

for (let i = 0; i < operadores.length; i++) {
    console.log(`${i + 1} - ${operadores[i]}`);
}
console.log("=================================================")
