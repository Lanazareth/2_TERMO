// Importando a bibioteca 
const entrada = require(`readline-sync`);

console.log("--- Sistema De Vendas Padaria ---");

// 1. Entrada dadados plo terminal 
// O computador para e espera o usuario digitar 
const nomeProduto = entrada.question("qual o nome do produto? ");
const precoUnitario = entrada.question("qual o preço unitario?");
const quantidade = entrada.questionInt("Quantas unidades foram vendidas? ");

// 2. Processamento (A conta)
const total = precoUnitario * quantidade;

// 3. Saída de dados personalizada
console.log("\n--- RECIBO DE VENDA ---");
console.log(`Produto: ${nomeProduto}`);
console.log(`Total a pagar: R$ ${total.toFixed(2)}`); // O .toFixed(2) coloca 2 casas decimais



