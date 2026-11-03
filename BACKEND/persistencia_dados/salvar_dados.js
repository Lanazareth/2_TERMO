
const fs = require('fs');

console.log("=== Sistemas de registro de maquinas ===");

const maquinasIndustriais = [
  { id: 101, nome: "torno revolver", setor: "usinagem", operacional: true },
  { id: 102, nome: "furadeira de bancada", setor: "manutencao", operacional: false },
  { id: 103, nome: "prensa hidraulica 40 t", setor: "estamparia", operacional: true }
];

const dadosParaGravar = JSON.stringify(maquinasIndustriais, null, 2);

const nomeDoArquivo = "maquinas.json";

fs.writeFileSync(nomeDoArquivo, dadosParaGravar);

console.log("\nGravacao concluida com sucesso.");
console.log(`Verifique o arquivo '${nomeDoArquivo}' gerado.`);
