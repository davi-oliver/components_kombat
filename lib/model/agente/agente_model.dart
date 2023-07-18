class Agente {
  int? id;
  String? matricula;
  String? nome;
  String? cpf;
  String? email;
  String? telefone;

  Agente(
      {this.id,
      this.matricula,
      this.nome,
      this.cpf,
      this.email,
      this.telefone});

  Agente.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matricula = json['matricula'];
    nome = json['nome'];
    cpf = json['cpf'];
    email = json['email'];
    telefone = json['telefone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['matricula'] = this.matricula;
    data['nome'] = this.nome;
    data['cpf'] = this.cpf;
    data['email'] = this.email;
    data['telefone'] = this.telefone;
    return data;
  }
}
