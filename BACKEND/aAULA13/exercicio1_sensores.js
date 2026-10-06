const fs = require('fs');

console.log("=== SISTEMAS DE MONITORAMENTOS ===");

const sensores = [
  {codigo: 1001, tipo: "temperatura", leituraAtual : 45.5, status:"operando"},
  {codigo: 1002, tipo: "presao", leituraAtual : 4, status:"operando"},
  {codigo: 1003, tipo: "temperatura", leituraAtual : 145.5, status:"Alerta!"}
];

const valotesGravados = JSON.stringify(sensores, null, 2);

fs.writeFileSync('sensores.json', valotesGravados);

console.log(`\n Valores gravados com sucesso.`);