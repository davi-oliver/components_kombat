// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:js_interop';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:componets_kombat/login/widget/components.dart';
import 'package:componets_kombat/theme/theme_mode.dart';

class LoginScreenComponets extends StatefulWidget {
  final BuildContext contextPage;
  final String? tituloTopoLogin;
  final String? pathStringImageAsset;
  final String? labelTextCampoLogin;
  final String? labelTextCampoSenha;
  final String? textoBotaoEntrar;
  final TextEditingController? controllerLogin;
  final TextEditingController? controllerSenha;
  final Function()? onTapEntrar;
  final Function()? initPage;
  final Function()? onTapSalvarSenha;
  final Function()? onTapEsqueciSenha;

  // ignore: prefer_const_constructors_in_immutables
  LoginScreenComponets({
    Key? key,
    required this.contextPage,
    this.tituloTopoLogin,
    this.pathStringImageAsset,
    this.labelTextCampoLogin,
    this.labelTextCampoSenha,
    this.textoBotaoEntrar,
    this.controllerLogin,
    this.controllerSenha,
    this.onTapEntrar,
    this.initPage,
    this.onTapEsqueciSenha,
    this.onTapSalvarSenha,
  }) : super(key: key);

  @override
  State<LoginScreenComponets> createState() => _LoginScreenComponetsState();
}

class _LoginScreenComponetsState extends State<LoginScreenComponets>
    with ValidTexFields {
  bool _carregando = false;
  bool _storePass = false;
  bool visibilityPass = true;
  TextEditingController controllerLogin = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();

  @override
  void initState() {
    widget.initPage!();

    super.initState();
  }

  final formState = GlobalKey<FormState>();
  @override
  Widget build(contextPage) {
    return Scaffold(
      body: SafeArea(
          bottom: true,
          top: false,
          child: Container(
            height: MediaQuery.of(contextPage).size.height,
            width: MediaQuery.of(contextPage).size.width,
            color: KThemeModeApp.of(contextPage).primary,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only(top: 30, left: 23, bottom: 43),
                    child: Row(
                      children: [
                        Icon(
                          Icons.login,
                          color:
                              KThemeModeApp.of(contextPage).primaryBackground,
                        ),
                        const SizedBox(width: 15),
                        Text(widget.tituloTopoLogin ?? "Login",
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
                      height: MediaQuery.of(contextPage).size.height * .78,
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
                          color:
                              KThemeModeApp.of(contextPage).primaryBackground),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 50),
                            child: Image.asset(
                              widget.pathStringImageAsset ??
                                  "assets/itajuba_contorno.png",
                              width:
                                  MediaQuery.of(contextPage).size.width * .45,
                            ),
                          ),
                          Form(
                            key: formState,
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 25),
                                  height:
                                      MediaQuery.of(contextPage).size.height *
                                          .1,
                                  width: MediaQuery.of(contextPage).size.width *
                                      0.8,
                                  child: TextFormField(
                                    onChanged: isNotEmpty,
                                    controller: widget.controllerLogin ??
                                        controllerLogin,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  KThemeModeApp.of(contextPage)
                                                      .primary,
                                              width: 1.0),
                                        ),
                                        labelText: widget.labelTextCampoLogin ??
                                            "Login",
                                        floatingLabelStyle:
                                            KThemeModeApp.of(contextPage)
                                                .titleLarge
                                                .copyWith(
                                                    color: KThemeModeApp.of(
                                                            contextPage)
                                                        .primary),
                                        labelStyle:
                                            const TextStyle(fontSize: 20),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        alignLabelWithHint: true,
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide(width: 1.0),
                                        )),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 25),
                                  height:
                                      MediaQuery.of(contextPage).size.height *
                                          .1,
                                  width: MediaQuery.of(contextPage).size.width *
                                      0.8,
                                  child: TextFormField(
                                    obscureText: visibilityPass,
                                    onChanged: isNotEmpty,
                                    controller: widget.controllerSenha ??
                                        controllerSenha,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  KThemeModeApp.of(contextPage)
                                                      .primary,
                                              width: 1.0),
                                        ),
                                        labelText: widget.labelTextCampoSenha ??
                                            "Senha",
                                        floatingLabelStyle:
                                            KThemeModeApp.of(contextPage)
                                                .titleLarge
                                                .copyWith(
                                                    color: KThemeModeApp.of(
                                                            contextPage)
                                                        .primary),
                                        labelStyle:
                                            const TextStyle(fontSize: 20),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        alignLabelWithHint: true,
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              visibilityPass = !visibilityPass;
                                            });
                                          },
                                          icon: Icon(
                                            visibilityPass
                                                ? FontAwesomeIcons.eye
                                                : FontAwesomeIcons.eyeSlash,
                                            color: KThemeModeApp.of(contextPage)
                                                .secondaryText,
                                            size: 15,
                                          ),
                                        ),
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide(width: 1.0),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: widget.onTapEsqueciSenha ?? () {},
                                  child: Text(
                                    "Esqueci minha senha",
                                    style: KThemeModeApp.of(contextPage)
                                        .bodySmall
                                        .copyWith(
                                            color: KThemeModeApp.of(contextPage)
                                                .primary),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            child: SwitchListTile(
                                subtitle: Text(
                                  "Selecione para manter senha salva",
                                  style:
                                      KThemeModeApp.of(contextPage).bodySmall,
                                ),
                                title: Text(
                                  "Manter-me conectado",
                                  style:
                                      KThemeModeApp.of(contextPage).bodyMedium,
                                ),
                                value: _storePass,
                                onChanged: (value) async {
                                  setState(() {
                                    _storePass = !_storePass;
                                  });

                                  widget.onTapSalvarSenha ?? () {};
                                }),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                KitButton(
                                    width:
                                        MediaQuery.of(contextPage).size.width *
                                            .45,
                                    height:
                                        MediaQuery.of(contextPage).size.height *
                                            .065,
                                    decorationButton: BoxDecoration(
                                      color: _carregando
                                          ? KThemeModeApp.of(contextPage)
                                              .accent4
                                          : KThemeModeApp.of(contextPage)
                                              .accent2,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(3, 4),
                                            blurRadius: 0.5,
                                            spreadRadius: 0.5)
                                      ],
                                    ),
                                    widgetCenter: _carregando
                                        ? AnimatedTextKit(
                                            animatedTexts: [
                                              WavyAnimatedText('Aguarde ...',
                                                  speed: const Duration(
                                                      milliseconds: 100),
                                                  textStyle: KThemeModeApp.of(
                                                          contextPage)
                                                      .headlineMedium
                                                      .copyWith(
                                                          color: KThemeModeApp.of(
                                                                  contextPage)
                                                              .accent2)),
                                            ],
                                            isRepeatingAnimation: true,
                                            totalRepeatCount: 3,
                                          )
                                        : Text(
                                            widget.textoBotaoEntrar ?? "Entrar",
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
                                      bool click = false;
                                      setState(() {
                                        _carregando = true;
                                        click = !click;
                                      });

                                      if (formState.currentState!.validate()) {
                                        widget.onTapEntrar ?? () {};
                                      } else {
                                        setState(() {
                                          _carregando = false;
                                          click = false;
                                        });
                                      }
                                      setState(() {
                                        _carregando = false;
                                        click = false;
                                      });
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
