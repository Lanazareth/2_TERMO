const entradas = require('readline-sync');

console.log("-----------------------------------------");
console.log("Controle de Acesso ao Laboratório"); 
console.log("-----------------------------------------");

const nome = entradas.question("Digite o seu nome: ");
const idade = entradas.questionInt("Digite a sua idade: ");
const autorizacao = entradas.keyInYNStrict("Você possui autorização?  "); 
const acompanhado = entradas.keyInYNStrict("Está acompanhado por professor?  "); 
const suspenso = entradas.keyInYNStrict("Está suspenso?  ");


if (idade >= 16 && (autorizacao === 'y' || acompanhado === 'y' ) && !suspenso === 'n') {
    console.log("Acesso permitido ao laboratório.");
} else {
    console.log("Acesso negado ao laboratório.");
}