import 'package:componets_kombat/model/endereco/endereco_model.dart';
import 'package:componets_kombat/model/imovel/imovel_model.dart';
import 'package:componets_kombat/model/qrcode/qrcode_model.dart';
import 'package:componets_kombat/model/questionario/questionario_model.dart';
import 'package:componets_kombat/model/visita/vista_model.dart';
import 'package:mobx/mobx.dart';
part 'view_model_store.g.dart';

// ignore: library_private_types_in_public_api
class ViewModelStore = _ViewModelStoreBase with _$ViewModelStore;

abstract class _ViewModelStoreBase with Store {
  @observable
  ImovelVisita imovelVisita = ImovelVisita();
  @observable
  String? logradoutroAux;
  @observable
  String? numeroAux;
  @observable
  String? complementoAux;
  @observable
  String? bairroAux;
  @observable
  String? situacaoVisitaAux;
  @observable
  String? qrcodeAux;
  @observable
  String? tipoimovelAux;

  @action
  void setAuxDetalhes(
      {logradouro,
      String? numero,
      complemento,
      situacaovisita,
      tipoimovel,
      bairro,
      qrcode}) {
    logradoutroAux = logradouro;
    numeroAux = numero ?? "0";
    complementoAux = complemento;
    situacaoVisitaAux = situacaovisita;
    bairroAux = bairro;
    qrcodeAux = qrcode;
    tipoimovelAux = tipoimovel;
  }

  void setClearAux() {
    logradoutroAux = "";
    numeroAux = "";
    complementoAux = "";
    situacaoVisitaAux = "";
    bairroAux = "";
    qrcodeAux = "";
    tipoimovelAux = "";
  }

  ObservableList<Questionario> listaQuestionarioSemInternet = ObservableList();

  ObservableList<ImovelVisita> listaImoveisVisita =
      ObservableList<ImovelVisita>();

  ObservableList<ImovelVisita> listaImoveisProducaoLocal =
      ObservableList<ImovelVisita>();

  @action
  void setListImoveisProducaoLocal(json) {
    listaImoveisProducaoLocal.clear();
    json.forEach((element) {
      listaImoveisProducaoLocal.add(setImovelVisitaFromJson(element, 1));
    });
  }

  @action
  Future setListaImoveisVisita(lista) async {
    listaImoveisVisita.clear();
    await lista.forEach((element) {
      listaImoveisVisita.add(setImovelVisitaFromJson(element, 1));
    });

    // for (var i = 0; i < lista.length; i++) {
    //   listaImoveisVisita.add(setImovelVisitaFromJson(lista[i], 1));
    //   log("Setou listaImoveisVisita");
    // }
    // log("Lista: ${listaImoveisVisita.length}");
  }

  @action
  void setListaQuestionarioSemInternet(lista) {
    listaQuestionarioSemInternet.addAll(lista);
  }

  // Responsavel por inserir os elementos aos seus respectivos atributos
  // é usado o _switch para poder dividir os tipos de inserção.
  @action
  setImovelVisitaFromJson(Map<String, dynamic> json, [int switchVisita = 0]) {
    // log("jsonVisita: ${json}");

    ImovelVisita imovelVisitaAux = ImovelVisita();

    switch (switchVisita) {
      case 1:
        // Endereco Imovel para uso de validar qrcode imovel - Usado em Cadastro de Imovel
        if (json["imovel"] != null) {
          imovelVisitaAux.id = json['imovel']['id'];
          imovelVisitaAux.enderecoId = json['imovel']['endereco_id'];
          imovelVisitaAux.qrcodeId = json['imovel']['qrcode_id'];
          imovelVisitaAux.tipoImovelId = json['imovel']['tipo_imovel_id'];
          imovelVisitaAux.bairroId = json['imovel']['bairro_id'];
          imovelVisitaAux.quarteiraoId = json['imovel']['quarteirao_id'];
          imovelVisitaAux.lado = json['imovel']['lado'];
          imovelVisitaAux.endereco = json['imovel']['endereco'] != null
              ? Endereco.fromJson(json['imovel']['endereco'])
              : null;
          imovelVisitaAux.bairro = json['imovel']['bairro'] != null
              ? Bairro.fromJson(json['imovel']['bairro'])
              : null;
          imovelVisitaAux.quarteirao = json['imovel']['quarteirao'] != null
              ? Quarteirao.fromJson(json['imovel']['quarteirao'])
              : null;
          imovelVisitaAux.tipoImovel = json['imovel']['tipo_imovel'] != null
              ? TipoImovel.fromJson(json['imovel']['tipo_imovel'])
              : null;
          imovelVisitaAux.visita =
              json['visita'] != null ? Visita.fromJson(json['visita']) : null;
          imovelVisitaAux.qrcode =
              json['qrcode'] != null ? Qrcode.fromJson(json['qrcode']) : null;
        }

        break;
      case 2:
        // caso att endereco
        imovelVisita.endereco = json['endereco'] != null
            ? Endereco.fromJson(json['endereco'])
            : null;
        break;
      case 3:
        // setar qrcode exibição json
        imovelVisita.qrcode =
            json['qrcode'] != null ? Qrcode.fromJson(json['qrcode']) : null;
        break;

      case 4:
        imovelVisita.id = json['id'];
        imovelVisita.enderecoId = json['endereco_id'];
        imovelVisita.qrcodeId = json['qrcode_id'];
        imovelVisita.tipoImovelId = json['tipo_imovel_id'];
        imovelVisita.bairroId = json['bairro_id'];
        imovelVisita.quarteiraoId = json['quarteirao_id'];
        imovelVisita.lado = json['lado'];
        imovelVisita.endereco = json['endereco'] != null
            ? Endereco.fromJson(json['endereco'])
            : null;
        imovelVisita.bairro =
            json['bairro'] != null ? Bairro.fromJson(json['bairro']) : null;
        imovelVisita.quarteirao = json['quarteirao'] != null
            ? Quarteirao.fromJson(json['quarteirao'])
            : null;
        imovelVisita.tipoImovel = json['tipo_imovel'] != null
            ? TipoImovel.fromJson(json['tipo_imovel'])
            : null;
        imovelVisita.qrcode =
            json['qrcode'] != null ? Qrcode.fromJson(json['qrcode']) : null;
        imovelVisita.visita =
            json['visita'] != null ? Visita.fromJson(json['visita']) : null;
        break;

      default:
        imovelVisita.id = json['id'];
        imovelVisita.enderecoId = json['endereco_id'];
        imovelVisita.qrcodeId = json['qrcode_id'];
        imovelVisita.tipoImovelId = json['tipo_imovel_id'];
        imovelVisita.bairroId = json['bairro_id'];
        imovelVisita.quarteiraoId = json['quarteirao_id'];
        imovelVisita.lado = json['lado'];
        imovelVisita.endereco = json['endereco'] != null
            ? Endereco.fromJson(json['endereco'])
            : null;
        imovelVisita.bairro =
            json['bairro'] != null ? Bairro.fromJson(json['bairro']) : null;
        imovelVisita.quarteirao = json['quarteirao'] != null
            ? Quarteirao.fromJson(json['quarteirao'])
            : null;
        imovelVisita.tipoImovel = json['tipo_imovel'] != null
            ? TipoImovel.fromJson(json['tipo_imovel'])
            : null;
        imovelVisita.qrcode =
            json['qrcode'] != null ? Qrcode.fromJson(json['qrcode']) : null;
        imovelVisita.visita =
            json['visita'] != null ? Visita.fromJson(json['visita']) : null;
        break;
    }
    return imovelVisitaAux;
  }

  @action
  void setClearImovelVisita() {
    ImovelVisita imovelVisitaAux = ImovelVisita();
    imovelVisitaAux.id = null;
    imovelVisitaAux.enderecoId = null;
    imovelVisitaAux.qrcodeId = null;
    imovelVisitaAux.tipoImovelId = null;
    imovelVisitaAux.bairroId = null;
    imovelVisitaAux.quarteiraoId = null;
    imovelVisitaAux.lado = null;
    imovelVisitaAux.endereco = null;
    imovelVisitaAux.bairro = null;
    imovelVisitaAux.quarteirao = null;
    imovelVisitaAux.tipoImovel = null;
    imovelVisitaAux.visita = null;
    imovelVisitaAux.qrcode = null;
    imovelVisita = imovelVisitaAux;
  }

  @action
  void setInsertId(value) => imovelVisita.insertId = value;

  @action
//SETA O VALOR DO QR CODE
  setImovelQrCode(Map<String, dynamic> json) {
    if (json.isEmpty) return;
    imovelVisita.qrcode!.id = json['id'];
    imovelVisita.qrcode!.valor = json['valor'];
    imovelVisita.qrcode!.active = json['active'];
  }

  @action
  void setImovelVisita(value) {
    imovelVisita = value;
  }

  @action
  void setVisitaIdCiclo(int id, int ciclo) {
    imovelVisita.id = id;
    // imovelVisita.cicloBairroImovelId = ciclo;
  }

  ObservableList<Endereco> listLogradouroSearch = ObservableList<Endereco>();
  ObservableList<Endereco> listLogradouroOrigin = ObservableList<Endereco>();
  ObservableList<Endereco> listLogradouroSemAcento = ObservableList<Endereco>();

  @action
  void setAddListaLogradouroSearch(value) {
    listLogradouroSearch.add(value);
  }

  @action
  void setaddAllListaLogradouro(value) {
    listLogradouroSearch.clear();
    listLogradouroSearch.addAll(value);
  }
}
