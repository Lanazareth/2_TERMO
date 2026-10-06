const fs = require('fs');

console.log(" === SISTEMA DE PERSISTENCIA : REGISTRO DE MAQUINA ===")

const maquinasindustriais = [
  {id : 101, nome: "torno mecanica universal", setor: "usinagem", operacional : true},
  {id : 102, nome: "fresadora ferramenteira", setor: "usinagem", operacional : false},
  {id : 103, nome: "prensa hidraulica 50T", setor: "estamparia", operacional : true},
  {id : 104, nome: "compressor", setor: "utilidades", operacional : false}
]
const dadosParaGravar = JSON.stringify(maquinasindustriais, null, 2);

const nomeDoArquivo = "maquinas.json";
fs.writeFileSync(nomeDoArquivo, dadosParaGravar);
console.log(`\nGravacao concluida com susseso.`);
console.log(`verifique o arquivo '${nomeDoArquivo}' gerado`)