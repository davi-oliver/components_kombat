// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:componets_kombat/login/widget/components.dart';
import 'package:componets_kombat/theme/theme_mode.dart';

class LoginScreenComponets extends StatefulWidget {
  final BuildContext contextPage;
  final String? tituloTopoLogin;
  final String? pathStringImageAsset;
  final String? labelTextCampoRecuperar;
  final String? textoBotaoRecuperar;
  final bool? loading;
  final TextEditingController? controllerRecuperar;
  final Widget? widgetLoading;
  final Function()? onTapRecuperarSenha;

  // ignore: prefer_const_constructors_in_immutables
  LoginScreenComponets({
    Key? key,
    required this.contextPage,
    this.tituloTopoLogin,
    this.widgetLoading,
    this.loading,
    this.pathStringImageAsset,
    this.labelTextCampoRecuperar,
    this.textoBotaoRecuperar,
    this.controllerRecuperar,
    this.onTapRecuperarSenha,
  }) : super(key: key);

  @override
  State<LoginScreenComponets> createState() => _LoginScreenComponetsState();
}

class _LoginScreenComponetsState extends State<LoginScreenComponets>
    with ValidTexFields {
  bool _carregando = false;

  bool visibilityPass = true;
  TextEditingController controllerRecuperar = TextEditingController();

  final formState = GlobalKey<FormState>();
  @override
  Widget build(contextPage) {
    return Scaffold(
      body: SafeArea(
          bottom: true,
          top: false,
          child: widget.loading ?? _carregando
              ? widget.widgetLoading ??
                  Center(
                    child: CircularProgressIndicator(
                      color: KThemeModeApp.of(contextPage).primary,
                    ),
                  )
              : Container(
                  height: MediaQuery.of(contextPage).size.height,
                  width: MediaQuery.of(contextPage).size.width,
                  color: KThemeModeApp.of(contextPage).primary,
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 30, left: 23, bottom: 43),
                          child: Row(
                            children: [
                              Icon(
                                Icons.login,
                                color: KThemeModeApp.of(contextPage)
                                    .primaryBackground,
                              ),
                              const SizedBox(width: 15),
                              Text(widget.tituloTopoLogin ?? "Recuperar Senha",
                                  style: KThemeModeApp.of(contextPage)
                                      .titleMedium
                                      .copyWith(
                                          color: KThemeModeApp.of(contextPage)
                                              .primaryBackground)),
                            ],
                          ),
                        ),
                        Center(
                          child: Container(
                            height:
                                MediaQuery.of(contextPage).size.height * .78,
                            width: MediaQuery.of(contextPage).size.width * .85,
                            margin: const EdgeInsets.symmetric(vertical: 120),
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(3, 4),
                                      blurRadius: 0.5,
                                      spreadRadius: 0.5)
                                ],
                                borderRadius: BorderRadius.circular(15),
                                color: KThemeModeApp.of(contextPage)
                                    .primaryBackground),
                            child: Column(
                              children: [
                                widget.pathStringImageAsset == null ||
                                        widget.pathStringImageAsset == ""
                                    ? Container(
                                        height: MediaQuery.of(contextPage)
                                                .size
                                                .height *
                                            .15,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 50),
                                      )
                                    : Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 50),
                                        child: Image.asset(
                                          widget.pathStringImageAsset!,
                                          width: MediaQuery.of(contextPage)
                                                  .size
                                                  .width *
                                              .45,
                                        ),
                                      ),
                                Form(
                                  key: formState,
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 25),
                                        height: MediaQuery.of(contextPage)
                                                .size
                                                .height *
                                            .1,
                                        width: MediaQuery.of(contextPage)
                                                .size
                                                .width *
                                            0.8,
                                        child: TextFormField(
                                          onChanged: isNotEmpty,
                                          controller:
                                              widget.controllerRecuperar ??
                                                  controllerRecuperar,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: KThemeModeApp.of(
                                                            contextPage)
                                                        .primary,
                                                    width: 1.0),
                                              ),
                                              labelText: widget
                                                      .labelTextCampoRecuperar ??
                                                  "Email",
                                              floatingLabelStyle: KThemeModeApp
                                                      .of(contextPage)
                                                  .titleLarge
                                                  .copyWith(
                                                      color:
                                                          KThemeModeApp.of(
                                                                  contextPage)
                                                              .primary),
                                              labelStyle:
                                                  const TextStyle(fontSize: 20),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              alignLabelWithHint: true,
                                              border: const OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(width: 1.0),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      KitButton(
                                          width: MediaQuery.of(contextPage)
                                                  .size
                                                  .width *
                                              .45,
                                          height: MediaQuery.of(contextPage)
                                                  .size
                                                  .height *
                                              .065,
                                          decorationButton: BoxDecoration(
                                            color: _carregando
                                                ? KThemeModeApp.of(contextPage)
                                                    .accent4
                                                : KThemeModeApp.of(contextPage)
                                                    .accent2,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(3, 4),
                                                  blurRadius: 0.5,
                                                  spreadRadius: 0.5)
                                            ],
                                          ),
                                          widgetCenter: Text(
                                            widget.textoBotaoRecuperar ??
                                                "Enviar",
                                            style: KThemeModeApp.of(contextPage)
                                                .bodyLarge
                                                .copyWith(
                                                    color: KThemeModeApp.of(
                                                            contextPage)
                                                        .primaryBtnText),
                                          ),
                                          iconSufix: Icon(
                                            Icons.arrow_forward_ios,
                                            color: _carregando
                                                ? Colors.transparent
                                                : KThemeModeApp.of(contextPage)
                                                    .primaryBtnText,
                                          ),
                                          onTap: () async {
                                            await widget
                                                    .onTapRecuperarSenha!() ??
                                                () {};
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
    );
  }
}
