class Logradouro {
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;

  Logradouro(
      {this.cep,
       this.logradouro,
       this.complemento,
       this.bairro,
       this.localidade,
       this.uf});

  factory Logradouro.fromJson(Map<String, dynamic> json) {
    return Logradouro(
        cep: json['cep'],
        logradouro: json['logradouro'],
        complemento: json['complemento'],
        bairro: json['bairro'],
        localidade: json['localidade'],
        uf: json['uf']
    );
  }
}
