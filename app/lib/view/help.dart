import 'package:flutter/material.dart';
import 'package:mouse_phone/widget/dropdown.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
          child: Column(
            spacing: 25,
            children: <Widget>[
              Dropdown(
                title: "Como conectar",
                description:
                    "Para conectar o mouse, você pode usar o IP do mouse ou escanear o QR Code.",
              ),
              Dropdown(
                title: "Onde encontrar o software para computador?",
                description:
                    "Você pode encontrar o software para computador no site oficial do Mouse Phone.",
              ),
              Dropdown(
                title: "Quais sistemas operacionais?",
                description:
                    "O software é compatível com Windows, macOS e Linux.",
              ),
              Dropdown(
                title: "Não consigo conectar com o computador",
                description:
                    "Certifique-se de que o software está instalado e rodando no computador. Verifique também se o firewall não está bloqueando a conexão.",
              ),
              Dropdown(
                title: "É pago para usar?",
                description:
                    "Não, o Mouse Phone é completamente gratuito e de código aberto.",
              ),
              Dropdown(
                title: "Onde encontro o contato para o suporte?",
                description:
                    "Você pode encontrar o contato para suporte na seção de ajuda do site oficial do Mouse Phone.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
