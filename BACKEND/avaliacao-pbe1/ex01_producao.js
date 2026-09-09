const entrada = require('readline-sync');

console.log("Calculadora de produção de peças por turno");

const pecasPorHora = entrada.question("Digite a quantidade de peças produzidas por hora: ");
const horasPorTurno = entrada.question("Digite a quantidade de horas por turno: ");

const totalPecas = pecasPorHora * horasPorTurno;

console.log(`Producao por Horas: ${pecasPorHora}`);
console.log(`Horas de turno: ${horasPorTurno}`);
console.log(`Total de peças produzidas por turno: ${totalPecas}`); 

