
const fs = require('fs');

console.log("Sistema de persistencia: leitura de maquinas");

if (!fs.existsSync("maquinas.json")) {
  console.error("Erro: arquivo maquinas.json nao encontrado");
  process.exit(1);
}

const conteudoTexto = fs.readFileSync("maquinas.json", "utf-8");
const maquinasRecuperadas = JSON.parse(conteudoTexto);

function buscaPorId(maquinas, id) {
  return maquinas.find((maquina) => maquina.id === id);
}

function filtrarPorStatus(maquinas, status) {
  return maquinas.filter((maquina) => maquina.status === status);
}

console.log("\nDados carregados com sucesso:");
console.table(maquinasRecuperadas);

console.log(`Total de maquinas: ${maquinasRecuperadas.length}`);
console.log(`Primeira maquina: ${maquinasRecuperadas[0].nome}`);

function executar() {

  console.log("\n=== Busca pelo ID 3 ===");

  const maquinaEncontrada = buscaPorId(maquinasRecuperadas, 3);

  console.log(maquinaEncontrada ?? "Maquina nao encontrada");

  console.log("\n=== Maquinas em manutencao ===");

  const maquinasManutencao = filtrarPorStatus(
    maquinasRecuperadas,
    "manutencao"
  );

  console.table(maquinasManutencao);
}

executar();
