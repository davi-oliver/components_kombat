// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobx/mobx.dart';

part 'inicia_visita_store.g.dart';

class IniciaVisitaStore = _IniciaVisitaStore with _$IniciaVisitaStore;

abstract class _IniciaVisitaStore with Store {
  @observable
  bool load = false; // Controla o carregamento da tela

  @observable
  var valorQr = ""; // Valor do Qr code que foi lido
  @observable
  String statusQrcode = ""; // Valor do Qr code que foi lido

  @observable
  int valorQrId = 0; // ID do Qr code que foi lido

  @observable
  bool visibilidaddeBotaoCadastrarImovel = false;

  @action
  void setVisibilidadeBotaoCadastrarImovel(_value) =>
      visibilidaddeBotaoCadastrarImovel = _value;

  @observable
  bool visibilidadeBotaoFechado = true;
  @observable
  bool visibilidadeBotaoRecusado = true;

  @action
  void setVisibilidadeBotaoFechado(_value) => visibilidadeBotaoFechado = _value;
  @action
  void setVisibilidadeBotaoRecusado(_value) =>
      visibilidadeBotaoRecusado = _value;

  @action
//SETA O VALOR DO QR CODE
  setValorQr(value) => valorQr = value;

  @action
//SETA O VALOR DO QR CODE
  setValorQrId(value) => valorQrId = value;

  @action
// ALTERNA A TELA DE CARREGAMENTO
  void setLoad(_value) => load = _value;

  @action
  void setImovelModel(valor, active) {
    valorQr = valor;
    statusQrcode = active;
  }
}
