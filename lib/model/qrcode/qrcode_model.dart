class Qrcode {
  int? id;
  String? valor;
  String? active;

  Qrcode({this.id, this.valor, this.active});

  Qrcode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    valor = json['valor'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['valor'] = this.valor;
    data['active'] = this.active;
    return data;
  }
}
