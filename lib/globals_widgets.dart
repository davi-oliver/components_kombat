import 'package:componets_kombat/theme/theme_mode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GlobalsWidgets {
  BuildContext context;
  GlobalsWidgets(this.context);

// APPBAR GLOBAL
  Widget appBar(String texto, bool voltar, [bool home = false]) {
    return Container(
      margin: EdgeInsets.only(top: 23, left: 23, bottom: 43),
      child: Row(
        children: [
          voltar
              ? GestureDetector(
                  child: Image.asset(
                    "assets/icons/seta_1.png",
                    width: 25,
                    height: 25,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  })
              : Container(),
          SizedBox(width: 15),
          Text(
            texto,
            style: KThemeModeApp.of(context)
                .bodyLarge
                .copyWith(color: KThemeModeApp.of(context).secondaryText),
          ),
        ],
      ),
    );
  }

// CARREGAMENTO PRINCIPAL
  Widget loadingPrincipal() {
    final spinkit = SpinKitCubeGrid(
      itemBuilder: (_, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven
                ? KThemeModeApp.of(context).accent1
                : KThemeModeApp.of(context).accent4,
          ),
        );
      },
    );
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: KThemeModeApp.of(context).primaryBackground,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(child: spinkit),
              const SizedBox(
                height: 20,
              ),
              Text("Aguarde...", style: KThemeModeApp.of(context).titleLarge),
            ],
          ),
        ],
      ),
    );
  }

// LOGO DO PARTE INFERIOR DO APP
  Widget logoBottomBar() {
    return Container(
      height: MediaQuery.of(context).size.height * .1,
      color: KThemeModeApp.of(context).primaryBackground,
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            "assets/itajuba_contorno.png",
            width: MediaQuery.of(context).size.width * 0.3,
          ),
        ],
      ),
    );
  }
}

// SOMBRA GLOBAL
const kDefaultShadow = BoxShadow(
    color: Colors.black26,
    offset: Offset(4, 4),
    blurRadius: 4,
    spreadRadius: -2);
