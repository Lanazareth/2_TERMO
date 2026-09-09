const entrada = require('readline-sync');

console.log("=== Pedidos de Materia Prima ===");

const nomeMaterial = entrada.question(" Digite o nome do materia: ");
const qntde = entrada.questionFloat("Digite a quantidade: ");
const preco = entrada.questionFloat("digite o valor: ");

const total = qntde * preco;

console.log(`O total do Pedido ficou em: ${total.toFixed(2)}`);