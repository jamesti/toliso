class Lancamento {
  final double valor;
  final String categoria;
  final DateTime data_cadastro;

  @override
  String toString() {
    return 'Lançamento {valor: $valor, categoria: $categoria}';
  }

  Lancamento(this.valor, this.categoria, this.data_cadastro);
}