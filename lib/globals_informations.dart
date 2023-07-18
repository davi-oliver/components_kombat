// CONTÉM AS PRINCIPAIS INFORMAÇÕES DO APP

class GlobalsInformations {
  String appName = "Itajubá Digital Servidor";
  String appState = "Minas Gerais";
  String appCodeState = "MG";
  String appCity = "Itajubá";
  int cidadeId = 5; // Itajuba
  int estadoId = 4; // Minas Gerais
  // String urlKombat = "https://apikombate.itajubadigital.com.br";
  String urlKombat = "http://devkombate.itajubadigital.com.br";
  // String urlKombat = "http://192.168.5.113:3001"; => url dev

  // String urlKombat = "http://192.168.3.18:3001";

  String idAppPlayStore = " ";
  String cepCityStarts = "375";
  String nomedoServidor = "Nome Servidor";
}

class GlobalUserInfos {
  String? tokenId;
  String? displayName;
  String? photoUrl;
  String? email;
  String? agenteId;
  var headerRequest;
  atualizaVars(_tokenId, _displayName, _photoUrl, _email, _agenteId) {
    tokenId = _tokenId;
    displayName = _displayName;
    photoUrl = _photoUrl;
    email = _email;
    agenteId = _agenteId;
    // headerRequest = {"Authorization": "token $tokenId"};
    headerRequest = {
      // 'Content-Type': 'application/json',
      "Authorization": "token $tokenId"
    };
  }
}
// visitado 4 5 6 7 
// recusa
// Fechado 
// recuperado


