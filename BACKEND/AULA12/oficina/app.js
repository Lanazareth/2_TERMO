const entrada = require('readline-sync');
const oficina = require('./funcoesOficina');

console.log("=== SISTEMA DE GESTAO DE OFICINA 1.0 ===");

const peca = entrada.questionFloat("Preco da peca: R$ ");
const horas = entrada.questionInt("Horas de servico: ");
const tempoUso = entrada.questionInt("Meses desde o ultimo conserto:  ");

const total = oficina.calcularOrcamento(peca, horas);

const garantia = oficina.verificarGarantia(tempoUso);

const desconto = oficina.calcularDesconto(total, 20);

console.log("\n--- RELATORIO DE SERVIÇO ---");
console.log(`orcamento: R$ ${total.toFixed(2)}`);
console.log(`Status Garantia: ${garantia}`);
console.log(`Valor com desconto: R$ ${desconto.toFixed(2)}`);
console.log("----------------------------------------");
  
