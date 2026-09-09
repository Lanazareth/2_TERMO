const entrada = require('readline-sync');

console.log("=== Classificador de Temperaturas ===");

const temp = entrada.questionFloat("Digite a Temperatura: ");

if (temp <= 60) {
    console.log(`Situação da temperatura ${temp} esta : NORMAL`);
} else if ( temp >= 61 && temp <= 80){
    console.log(`Situação da temperatura ${temp} esta : ALERTA`);
} else if (temp >= 81 ){
    console.log(`Situação da temperatura ${temp} esta : CRITICO`);
}