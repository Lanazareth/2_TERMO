const entradas = require('readline-sync');

console.log('========================================');
console.log('=== Sistema De Classificação : Natação ===');
console.log('========================================');

const nome = entradas.question('Digite o nome do atleta: ');
const idade = entradas.questionInt('Digite a idade do atleta: ');

console.log(`\nAtleta: ${nome}`);

if (idade < 5) {
    console.log('Situação: Muito jovem para competição.');
} else if (idade >= 5 && idade <= 10) {
    console.log('Categoria Infantil 👶');
} else if (idade >= 11 && idade <= 17) {
    console.log('Categoria Juvenil 👦.');
} else if (idade >= 18 && idade <= 60) {
    console.log('Categoria  Adulto 🧑.');
} else {
    console.log('Categoria Sênior 👴.');
}

console.log('========================================');