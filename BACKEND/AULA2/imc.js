const entrada = require(`readline-sync`);


console.log("--- Sistema De Medição IMC! ---");

const altura = entrada.questionFloat("Qual é a sua altura ? ");
const peso = entrada.questionFloat("Qual é e seu peso ?");

const total = peso / (altura * altura)

console.log("---Resultado---")
console.log(`O seu IMC e igual a: ${total.toFixed(2)}`);

