// Primeira Parte

const readline = require("readline-sync"); 

const nome = readline.question("Digite seu nome: "); 
const cidade = readline.question("Digite sua cidade: "); 
const idade = Number(readline.question("Digite sua idade: ")); 
const idadeFutura = idade + 5; 

console.log("Olá,", nome); 
console.log("Você mora em", cidade); 
console.log("Daqui a cinco anos você terá", idadeFutura, "anos.");