function calcularOrcamento(precoPeca, horasTrabalho){
  const valorHora = 85.00;
  const totalMaodeObra = horasTrabalho * valorHora;
  return precoPeca + totalMaodeObra;

}

function verificarGarantia(meses) {
  if (meses <=3){
    return "Dentro daGarantia"
  }else{
    return "Garantia expirada"
  }
}

function calcularDesconto(valor, percentual){
  const desconto = valor * (percentual / 100);
  return valor - desconto;
}

module.exports = {
  calcularOrcamento,
  verificarGarantia,
  calcularDesconto
}