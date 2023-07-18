import 'package:componets_kombat/theme/theme_mode.dart';
import 'package:flutter/material.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

// ALERT DE ERRO PADRÃO
class GlobalsAlerts {
  BuildContext context;
  GlobalsAlerts(this.context);
  // alertSucessQrCode(
  //   titulo,
  //   texto,
  // ) {
  //   var alertStyle = AlertStyle(
  //     animationType: AnimationType.fromTop,
  //     isCloseButton: true,
  //     isOverlayTapDismiss: false,
  //     descStyle: const TextStyle(fontWeight: FontWeight.bold),
  //     animationDuration: const Duration(milliseconds: 400),
  //     alertBorder: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10.0),
  //       side: const BorderSide(
  //         color: Colors.grey,
  //       ),
  //     ),
  //     titleStyle: KThemeModeApp.of(context)
  //         .bodyLarge
  //         .copyWith(fontWeight: FontWeight.bold),
  //     overlayColor: const Color(0x55000000),
  //   );
  //   Alert(
  //     context: context,
  //     style: alertStyle,
  //     closeIcon: Icon(
  //       Icons.close,
  //       color: Colors.black,
  //     ),
  //     image: Image.asset("assets/alerts/sucesso.jpg"),
  //     title: titulo,
  //     content: Column(
  //       children: [
  //         Text(
  //           texto,
  //           style: KThemeModeApp.of(context).bodyMedium,
  //         ),
  //       ],
  //     ),
  //     buttons: [
  //       DialogButton(
  //         child: Text(
  //           "ENTENDI",
  //           style: KThemeModeApp.of(context)
  //               .bodyLarge
  //               .copyWith(color: KThemeModeApp.of(context).primaryBtnText),
  //         ),
  //         onPressed: () async {
  //           Navigator.of(context, rootNavigator: true).pop();
  //           await FormularioImovelFunctions(context).getImoveisPeloQrCode();
  //         },
  //         gradient: LinearGradient(
  //           begin: Alignment.topRight,
  //           end: Alignment.bottomLeft,
  //           colors: [
  //             KThemeModeApp.of(context).primary,
  //             KThemeModeApp.of(context).accent1,
  //           ],
  //         ),
  //         radius: BorderRadius.circular(6.0),
  //       ),
  //     ],
  //   ).show();
  // }

  // alertSucessQrCodeOffline(
  //   titulo,
  //   texto,
  // ) {
  //   var alertStyle = AlertStyle(
  //     animationType: AnimationType.fromTop,
  //     isCloseButton: true,
  //     isOverlayTapDismiss: false,
  //     descStyle: const TextStyle(fontWeight: FontWeight.bold),
  //     animationDuration: const Duration(milliseconds: 400),
  //     alertBorder: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10.0),
  //       side: const BorderSide(
  //         color: Colors.grey,
  //       ),
  //     ),
  //     titleStyle: KThemeModeApp.of(context)
  //         .bodyLarge
  //         .copyWith(fontWeight: FontWeight.bold),
  //     overlayColor: const Color(0x55000000),
  //   );
  //   Alert(
  //     context: context,
  //     style: alertStyle,
  //     closeIcon: Icon(
  //       Icons.close,
  //       color: Colors.black,
  //     ),
  //     image: Image.asset("assets/alerts/sucesso.jpg"),
  //     title: titulo,
  //     content: Column(
  //       children: [
  //         Text(
  //           texto,
  //           style: KThemeModeApp.of(context).bodyMedium,
  //         ),
  //       ],
  //     ),
  //     buttons: [
  //       DialogButton(
  //         child: Text(
  //           "ENTENDI",
  //           style: KThemeModeApp.of(context)
  //               .bodyLarge
  //               .copyWith(color: KThemeModeApp.of(context).primaryBtnText),
  //         ),
  //         onPressed: () async {
  //           Navigator.of(context, rootNavigator: true).pop();
  //           Navigator.push(context,
  //               MaterialPageRoute(builder: (_) => DetalhesImovelPage()));
  //         },
  //         gradient: LinearGradient(
  //           begin: Alignment.topRight,
  //           end: Alignment.bottomLeft,
  //           colors: [
  //             KThemeModeApp.of(context).primary,
  //             KThemeModeApp.of(context).accent1,
  //           ],
  //         ),
  //         radius: BorderRadius.circular(6.0),
  //       ),
  //     ],
  //   ).show();
  // }

  // alertSucess(titulo, texto, [bool volta = false]) {
  //   var alertStyle = AlertStyle(
  //     animationType: AnimationType.fromTop,
  //     isCloseButton: false,
  //     isOverlayTapDismiss: false,
  //     descStyle: const TextStyle(fontWeight: FontWeight.bold),
  //     animationDuration: const Duration(milliseconds: 400),
  //     alertBorder: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10.0),
  //       side: const BorderSide(
  //         color: Colors.grey,
  //       ),
  //     ),
  //     titleStyle: KThemeModeApp.of(context)
  //         .bodyLarge
  //         .copyWith(fontWeight: FontWeight.bold),
  //     overlayColor: const Color(0x55000000),
  //   );
  //   Alert(
  //     context: context,
  //     style: alertStyle,
  //     closeIcon: Icon(
  //       Icons.close,
  //       color: Colors.black,
  //     ),
  //     image: Image.asset("assets/alerts/sucesso.jpg"),
  //     title: titulo,
  //     content: Column(
  //       children: [
  //         Text(
  //           texto,
  //           style: KThemeModeApp.of(context).bodyMedium,
  //         ),
  //       ],
  //     ),
  //     buttons: [
  //       DialogButton(
  //         child: Text(
  //           "ENTENDI",
  //           style: KThemeModeApp.of(context)
  //               .bodyLarge
  //               .copyWith(color: KThemeModeApp.of(context).primaryBtnText),
  //         ),
  //         onPressed: () {
  //           Navigator.of(context, rootNavigator: true).pop();

  //           Navigator.pushReplacement(context,
  //               MaterialPageRoute(builder: (_) => ProducaoDiariaPage()));
  //         },
  //         gradient: LinearGradient(
  //           begin: Alignment.topRight,
  //           end: Alignment.bottomLeft,
  //           colors: [
  //             KThemeModeApp.of(context).primary,
  //             KThemeModeApp.of(context).accent1,
  //           ],
  //         ),
  //         radius: BorderRadius.circular(6.0),
  //       ),
  //     ],
  //   ).show();
  // }

  alertErro(titulo, texto, [bool redirecionamento = false]) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: true,
      isOverlayTapDismiss: false,
      descStyle: const TextStyle(fontWeight: FontWeight.bold),
      animationDuration: const Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: KThemeModeApp.of(context)
          .bodyLarge
          .copyWith(fontWeight: FontWeight.bold),
      overlayColor: const Color(0x55000000),
    );
    Alert(
      context: context,
      style: alertStyle,
      closeIcon: Icon(
        Icons.close,
        color: Colors.black,
      ),
      image: Image.asset("assets/alerts/erro.png"),
      title: titulo,
      content: Column(
        children: [
          Text(
            texto,
            style: KThemeModeApp.of(context).bodyMedium,
          ),
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            redirecionamento ? "CADASTRAR" : "ENTENDI",
            style: KThemeModeApp.of(context)
                .bodyLarge
                .copyWith(color: KThemeModeApp.of(context).primaryBtnText),
          ),
          onPressed: () {
            if (redirecionamento) {
              Navigator.of(context, rootNavigator: true).pop();

              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (_context) => FormularioImovelPage()));
            } else {
              Navigator.of(context, rootNavigator: true).pop();
            }
          },
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              KThemeModeApp.of(context).primary,
              KThemeModeApp.of(context).accent1,
            ],
          ),
          radius: BorderRadius.circular(6.0),
        ),
      ],
    ).show();
  }

  // alertErroConexaoCadastro() {
  //   var alertStyle = AlertStyle(
  //     animationType: AnimationType.fromTop,
  //     isCloseButton: true,
  //     isOverlayTapDismiss: false,
  //     descStyle: const TextStyle(fontWeight: FontWeight.bold),
  //     animationDuration: const Duration(milliseconds: 400),
  //     alertBorder: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10.0),
  //       side: const BorderSide(
  //         color: Colors.grey,
  //       ),
  //     ),
  //     titleStyle: KThemeModeApp.of(context)
  //         .bodyLarge
  //         .copyWith(fontWeight: FontWeight.bold),
  //     overlayColor: const Color(0x55000000),
  //   );
  //   Alert(
  //     context: context,
  //     style: alertStyle,
  //     closeIcon: Icon(
  //       Icons.close,
  //       color: Colors.black,
  //     ),
  //     image: Image.asset("assets/alerts/erro.png"),
  //     title: "Informação",
  //     content: Column(
  //       children: [
  //         Text(
  //           "Verifique a sua conexão com a internet. Os dados cadastrados serão salvos em seu dispositivo e enviados automaticamente quando sua conexão estiver estável!",
  //           style: KThemeModeApp.of(context).bodyLarge,
  //         ),
  //       ],
  //     ),
  //     buttons: [
  //       DialogButton(
  //         child: Text(
  //           "FECHAR",
  //           style: KThemeModeApp.of(context)
  //               .bodyLarge
  //               .copyWith(color: KThemeModeApp.of(context).primaryBtnText),
  //         ),
  //         onPressed: () {
  //           Navigator.of(context, rootNavigator: true).pop();
  //           Navigator.pushAndRemoveUntil(
  //               context,
  //               MaterialPageRoute(builder: (_) => InfoSalvaPage()),
  //               (route) => false);
  //         },
  //         gradient: LinearGradient(
  //           begin: Alignment.topRight,
  //           end: Alignment.bottomLeft,
  //           colors: [
  //             KThemeModeApp.of(context).primary,
  //             KThemeModeApp.of(context).accent1,
  //           ],
  //         ),
  //         radius: BorderRadius.circular(6.0),
  //       ),
  //     ],
  //   ).show();
  // }

  // alertErroGeo(
  //   titulo,
  //   texto,
  // ) {
  //   var alertStyle = AlertStyle(
  //     animationType: AnimationType.fromTop,
  //     isCloseButton: true,
  //     isOverlayTapDismiss: false,
  //     descStyle: const TextStyle(fontWeight: FontWeight.bold),
  //     animationDuration: const Duration(milliseconds: 400),
  //     alertBorder: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10.0),
  //       side: const BorderSide(
  //         color: Colors.grey,
  //       ),
  //     ),
  //     titleStyle: KThemeModeApp.of(context)
  //         .bodyLarge
  //         .copyWith(fontWeight: FontWeight.bold),
  //     overlayColor: const Color(0x55000000),
  //   );
  //   Alert(
  //     context: context,
  //     style: alertStyle,
  //     closeIcon: Icon(
  //       Icons.close,
  //       color: Colors.black,
  //     ),
  //     image: Image.asset("assets/alerts/erro.png"),
  //     title: titulo,
  //     content: Column(
  //       children: [
  //         Text(
  //           texto,
  //           style: KThemeModeApp.of(context).bodyMedium,
  //         ),
  //       ],
  //     ),
  //     buttons: [
  //       DialogButton(
  //         child: Text(
  //           "ENTENDI",
  //           style: KThemeModeApp.of(context).bodyMedium,
  //         ),
  //         onPressed: () async {
  //           Navigator.of(context, rootNavigator: true).pop();
  //           await Geolocator.openAppSettings();
  //         },
  //         gradient: LinearGradient(
  //           begin: Alignment.topRight,
  //           end: Alignment.bottomLeft,
  //           colors: [
  //             KThemeModeApp.of(context).primary,
  //             KThemeModeApp.of(context).accent1,
  //           ],
  //         ),
  //         radius: BorderRadius.circular(6.0),
  //       ),
  //     ],
  //   ).show();
  // }

  // alertErroQr(titulo, texto, botaoText, {required bool inciaVisita}) {
  //   var alertStyle = AlertStyle(
  //     animationType: AnimationType.fromTop,
  //     isCloseButton: true,
  //     isOverlayTapDismiss: false,
  //     descStyle: const TextStyle(fontWeight: FontWeight.bold),
  //     animationDuration: const Duration(milliseconds: 400),
  //     alertBorder: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10.0),
  //       side: const BorderSide(
  //         color: Colors.grey,
  //       ),
  //     ),
  //     titleStyle: KThemeModeApp.of(context)
  //         .bodyLarge
  //         .copyWith(fontWeight: FontWeight.bold),
  //     overlayColor: const Color(0x55000000),
  //   );
  //   Alert(
  //     context: context,
  //     style: alertStyle,
  //     closeIcon: Icon(
  //       Icons.close,
  //       color: Colors.black,
  //     ),
  //     image: Image.asset("assets/alerts/erro.png"),
  //     title: titulo,
  //     content: Column(
  //       children: [
  //         Text(
  //           texto,
  //           style: KThemeModeApp.of(context).bodyMedium,
  //         ),
  //       ],
  //     ),
  //     buttons: [
  //       DialogButton(
  //         child: Text(
  //           botaoText,
  //           style: KThemeModeApp.of(context)
  //               .bodyLarge
  //               .copyWith(color: KThemeModeApp.of(context).primaryBtnText),
  //         ),
  //         onPressed: () async {
  //           Navigator.of(context, rootNavigator: true).pop();
  //           // ignore: use_build_context_synchronously
  //           await DetalhesImovelFunctions(context).vinculaQrcodeImovel();
  //         },
  //         gradient: LinearGradient(
  //           begin: Alignment.topRight,
  //           end: Alignment.bottomLeft,
  //           colors: [
  //             KThemeModeApp.of(context).primary,
  //             KThemeModeApp.of(context).accent1,
  //           ],
  //         ),
  //         radius: BorderRadius.circular(6.0),
  //       ),
  //     ],
  //   ).show();
  // }

  // alertInfoProducao() {
  //   var alertStyle = AlertStyle(
  //     animationType: AnimationType.fromTop,
  //     isCloseButton: false,
  //     isOverlayTapDismiss: false,
  //     descStyle: const TextStyle(fontWeight: FontWeight.bold),
  //     animationDuration: const Duration(milliseconds: 400),
  //     alertBorder: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10.0),
  //       side: const BorderSide(
  //         color: Colors.grey,
  //       ),
  //     ),
  //     titleStyle: KThemeModeApp.of(context)
  //         .bodyLarge
  //         .copyWith(fontWeight: FontWeight.bold),
  //     overlayColor: const Color(0x55000000),
  //   );
  //   Alert(
  //     context: context,
  //     style: alertStyle,
  //     closeIcon: Icon(
  //       Icons.close,
  //       color: Colors.black,
  //     ),
  //     image: Image.asset("assets/alerts/erro.png"),
  //     title: "Atenção",
  //     content: WillPopScope(
  //       onWillPop: () async => await onwillpop(),
  //       child: Column(
  //         children: [
  //           Text(
  //             "Você possui imoveis para sincronizar com o sistema, deseja enviar a produção?",
  //             style: KThemeModeApp.of(context).bodyMedium,
  //           ),
  //         ],
  //       ),
  //     ),
  //     buttons: [
  //       DialogButton(
  //         child: Text(
  //           "NÃO",
  //           style: KThemeModeApp.of(context)
  //               .bodyLarge
  //               .copyWith(color: KThemeModeApp.of(context).primaryBtnText),
  //         ),
  //         onPressed: () async {
  //           Navigator.of(context, rootNavigator: true).pop();
  //         },
  //         gradient: LinearGradient(
  //           begin: Alignment.topRight,
  //           end: Alignment.bottomLeft,
  //           colors: [
  //             KThemeModeApp.of(context).primary,
  //             KThemeModeApp.of(context).accent1,
  //           ],
  //         ),
  //         radius: BorderRadius.circular(6.0),
  //       ),
  //       DialogButton(
  //         child: Text(
  //           "SIM",
  //           style: KThemeModeApp.of(context)
  //               .bodyLarge
  //               .copyWith(color: KThemeModeApp.of(context).primaryBtnText),
  //         ),
  //         onPressed: () async {
  //           Navigator.of(context, rootNavigator: true).pop();
  //           Navigator.push(context,
  //               MaterialPageRoute(builder: (_) => ProducaoDiariaPage()));
  //         },
  //         gradient: LinearGradient(
  //           begin: Alignment.topRight,
  //           end: Alignment.bottomLeft,
  //           colors: [
  //             KThemeModeApp.of(context).accent1,
  //             KThemeModeApp.of(context).primary,
  //           ],
  //         ),
  //         radius: BorderRadius.circular(6.0),
  //       ),
  //     ],
  //   ).show();
  // }

  // onwillpop() => false;

  // alertInfoQrCode(titulo) {
  //   var alertStyle = AlertStyle(
  //     animationType: AnimationType.fromTop,
  //     isCloseButton: true,
  //     isOverlayTapDismiss: false,
  //     descStyle: const TextStyle(fontWeight: FontWeight.bold),
  //     animationDuration: const Duration(milliseconds: 400),
  //     alertBorder: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10.0),
  //       side: const BorderSide(
  //         color: Colors.grey,
  //       ),
  //     ),
  //     titleStyle: KThemeModeApp.of(context)
  //         .bodyLarge
  //         .copyWith(fontWeight: FontWeight.bold),
  //     overlayColor: const Color(0x55000000),
  //   );
  //   Alert(
  //     context: context,
  //     style: alertStyle,
  //     closeIcon: Icon(
  //       Icons.close,
  //       color: Colors.black,
  //     ),
  //     image: Image.asset("assets/alerts/erro.png"),
  //     title: titulo,
  //     content: Column(
  //       children: [
  //         Text(
  //           "Imóvel a visitar necessita de um novo QR Code?",
  //           style: KThemeModeApp.of(context).bodyMedium,
  //         ),
  //       ],
  //     ),
  //     buttons: [
  //       DialogButton(
  //         child: Text(
  //           "NÃO",
  //           style: KThemeModeApp.of(context)
  //               .bodyLarge
  //               .copyWith(color: KThemeModeApp.of(context).primaryBtnText),
  //         ),
  //         onPressed: () async {
  //           Navigator.of(context, rootNavigator: true).pop();
  //           await DetalhesImovelFunctions(context).iniciaVisita();
  //         },
  //         gradient: LinearGradient(
  //           begin: Alignment.topRight,
  //           end: Alignment.bottomLeft,
  //           colors: [
  //             KThemeModeApp.of(context).primary,
  //             KThemeModeApp.of(context).accent1,
  //           ],
  //         ),
  //         radius: BorderRadius.circular(6.0),
  //       ),
  //       DialogButton(
  //         child: Text(
  //           "SIM",
  //           style: KThemeModeApp.of(context)
  //               .bodyLarge
  //               .copyWith(color: KThemeModeApp.of(context).primaryBtnText),
  //         ),
  //         onPressed: () async {
  //           Navigator.of(context, rootNavigator: true).pop();
  //           Navigator.push(
  //               context, MaterialPageRoute(builder: (_) => ValidaQrCodePage()));
  //         },
  //         gradient: LinearGradient(
  //           begin: Alignment.topRight,
  //           end: Alignment.bottomLeft,
  //           colors: [
  //             KThemeModeApp.of(context).accent1,
  //             KThemeModeApp.of(context).primary,
  //           ],
  //         ),
  //         radius: BorderRadius.circular(6.0),
  //       ),
  //     ],
  //   ).show();
  // }

  // alertFuncionamento(i) {
  //   var alertStyle = AlertStyle(
  //     animationType: AnimationType.fromTop,
  //     backgroundColor: KThemeModeApp.of(context).primaryBackground,
  //     isCloseButton: false,
  //     isOverlayTapDismiss: false,
  //     descStyle: TextStyle(fontWeight: FontWeight.bold),
  //     animationDuration: Duration(milliseconds: 400),
  //     alertBorder: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10.0),
  //       side: BorderSide(
  //         color: Colors.grey,
  //       ),
  //     ),
  //     titleStyle: KThemeModeApp.of(context)
  //         .bodyLarge
  //         .copyWith(fontWeight: FontWeight.bold),

  //     //constraints: BoxConstraints.expand(width: 300),
  //     //First to chars "55" represents transparency of color
  //     overlayColor: Color(0x55000000),
  //   );

  //   // Alert dialog using custom alert style
  //   Alert(
  //     context: context,
  //     style: alertStyle,
  //     image: Image.asset("assets/images/emcontrucao.png"),
  //     title: "Ops!",
  //     content: Column(
  //       crossAxisAlignment: CrossAxisAlignment.end,
  //       children: [
  //         Text("Disponivel em breve!",
  //             style: KThemeModeApp.of(context).bodyMedium),
  //       ],
  //     ),
  //     buttons: [
  //       DialogButton(
  //         child: Text(
  //           "OK",
  //           style: KThemeModeApp.of(context).bodyLarge.copyWith(
  //                 color: KThemeModeApp.of(context).primaryBtnText,
  //               ),
  //         ),
  //         onPressed: () {
  //           // 1 => navigator pop
  //           //
  //           if (i == 1) {
  //             Navigator.of(context, rootNavigator: true).pop();
  //           } else if (i == 0) {
  //             // vai pra home
  //             Navigator.of(context, rootNavigator: true).pop();
  //             Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
  //                 MaterialPageRoute(builder: (context) => HomeVigPage()),
  //                 (route) => false);
  //           }
  //         },
  //         color: KThemeModeApp.of(context).accent1,
  //         radius: BorderRadius.circular(10.0),
  //       ),
  //     ],
  //   ).show();
  // }

  // alertErroSairVisita(titulo, texto) {
  //   var alertStyle = AlertStyle(
  //     animationType: AnimationType.fromTop,
  //     isCloseButton: true,
  //     isOverlayTapDismiss: false,
  //     descStyle: const TextStyle(fontWeight: FontWeight.bold),
  //     animationDuration: const Duration(milliseconds: 400),
  //     alertBorder: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10.0),
  //       side: const BorderSide(
  //         color: Colors.grey,
  //       ),
  //     ),
  //     titleStyle: KThemeModeApp.of(context)
  //         .bodyLarge
  //         .copyWith(fontWeight: FontWeight.bold),
  //     overlayColor: const Color(0x55000000),
  //   );
  //   Alert(
  //     context: context,
  //     style: alertStyle,
  //     closeIcon: const Icon(
  //       Icons.close,
  //       color: Colors.black,
  //     ),
  //     image: Image.asset("assets/alerts/erro.png"),
  //     title: titulo,
  //     content: Column(
  //       children: [
  //         Text(
  //           texto,
  //           style: KThemeModeApp.of(context).bodyMedium,
  //         ),
  //       ],
  //     ),
  //     buttons: [
  //       DialogButton(
  //         // ignore: sort_child_properties_last
  //         child: Text(
  //           "Sair",
  //           style: KThemeModeApp.of(context)
  //               .bodyLarge
  //               .copyWith(color: KThemeModeApp.of(context).primaryBtnText),
  //         ),
  //         onPressed: () {
  //           Navigator.of(context, rootNavigator: true).pop();
  //         },
  //         gradient: LinearGradient(
  //           begin: Alignment.topRight,
  //           end: Alignment.bottomLeft,
  //           colors: [
  //             KThemeModeApp.of(context).primary,
  //             KThemeModeApp.of(context).accent1,
  //           ],
  //         ),
  //         radius: BorderRadius.circular(6.0),
  //       ),
  //       DialogButton(
  //         // ignore: sort_child_properties_last
  //         child: Text(
  //           "Não",
  //           style: KThemeModeApp.of(context)
  //               .bodyLarge
  //               .copyWith(color: KThemeModeApp.of(context).primaryBtnText),
  //         ),
  //         onPressed: () {
  //           Navigator.of(context, rootNavigator: true).pop();
  //         },
  //         gradient: LinearGradient(
  //           begin: Alignment.topRight,
  //           end: Alignment.bottomLeft,
  //           colors: [
  //             KThemeModeApp.of(context).primary,
  //             KThemeModeApp.of(context).accent1,
  //           ],
  //         ),
  //         radius: BorderRadius.circular(6.0),
  //       ),
  //     ],
  //   ).show();
  // }
}
