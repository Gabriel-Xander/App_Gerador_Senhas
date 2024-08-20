import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(GeradorSenhasApp());
}

class GeradorSenhasApp extends StatefulWidget {
  @override
  GeradorSenhasAppState createState() {
    return GeradorSenhasAppState();
  }
}

class GeradorSenhasAppState extends State<GeradorSenhasApp> {
  bool maiuscula = true;
  bool minusculas = true;
  bool caracteresespecial = true;
  bool numeros = true;
  double range = 6;
  String pass = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: tema,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Gerador de senha'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              sizedBoxImg(),
              TextoMaior(),
              TextoMenor(),
              SizedBox(height: 30),
              opcoes(),
              SizedBox(height: 30),
              slider(),
              botao(),
              SizedBox(height: 30),
              resultado(),
              SizedBox(height: 20),
              mostrarForcaSenha(),
            ],
          ),
        ),
      ),
    );
  }

  Widget sizedBoxImg() {
    return SizedBox(
      width: 200,
      height: 200,
      child: Image.network(
          "https://cdn.pixabay.com/photo/2013/04/01/09/02/read-only-98443_1280.png"),
    );
  }

  Widget TextoMaior() {
    return const Text(
      'Gerador automático de senha',
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
      textAlign: TextAlign.center,
    );
  }

  Widget TextoMenor() {
    return const Text(
      'Aqui você pode gerar a sua senha',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    );
  }

  Widget opcoes() {
    return Row(children: [
      Checkbox(
          value: maiuscula,
          onChanged: (bool? value) {
            setState(() {
              maiuscula = value!;
            });
          }),
      const Text('[A-Z]'),
      Checkbox(
          value: minusculas,
          onChanged: (bool? value) {
            setState(() {
              minusculas = value!;
            });
          }),
      const Text('[a-z]'),
      Checkbox(
          value: numeros,
          onChanged: (bool? value) {
            setState(() {
              numeros = value!;
            });
          }),
      const Text('[0-9]'),
      Checkbox(
          value: caracteresespecial,
          onChanged: (bool? value) {
            setState(() {
              caracteresespecial = value!;
            });
          }),
      const Text('[@#!]')
    ]);
  }

  Widget slider() {
    return Slider(
      value: range,
      max: 50,
      divisions: 50,
      label: range.round().toString(),
      onChanged: (double newRange) {
        setState(() {
          range = newRange;
        });
      },
    );
  }

  Widget botao() {
    return Container(
      height: 50,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ElevatedButton(
        child: const Text('Gerar senha'),
        onPressed: geradorPasswordState,
      ),
    );
  }

  Widget resultado() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * .70,
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: Text(
          pass,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }

  void geradorPasswordState() {
    setState(() {
      pass = geradorPassword();
    });
  }

  String geradorPassword() {
    String charList = '';
    if (maiuscula) charList += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    if (minusculas) charList += 'abcdefghijklmnopqrstuvwxyz';
    if (numeros) charList += '0123456789';
    if (caracteresespecial) charList += '!#\$%&()*+,-./:;<=>?@[]^_{|}~';

    Random rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(
        range.round(),
        (_) => charList.codeUnitAt(rnd.nextInt(charList.length)),
      ),
    );
  }

  int calcularForcaSenha(String senha) {
    int forca = 0;

    if (senha.length >= 8) forca += 1;
    if (senha.contains(RegExp(r'[A-Z]'))) forca += 1;
    if (senha.contains(RegExp(r'[a-z]'))) forca += 1;
    if (senha.contains(RegExp(r'[0-9]'))) forca += 1;
    if (senha.contains(RegExp(r'[!@#\$%\^&\*\(\)_\+\-=\[\]\{\};:"\\|,.<>\/?]')))
      forca += 1;

    return forca;
  }

  Widget mostrarForcaSenha() {
    int forca = calcularForcaSenha(pass);
    String textoForca;
    Color corForca;

    switch (forca) {
      case 1:
        textoForca = "Muito Fraca";
        corForca = Colors.red;
        break;
      case 2:
        textoForca = "Fraca";
        corForca = Colors.orange;
        break;
      case 3:
        textoForca = "Média";
        corForca = Colors.yellow;
        break;
      case 4:
        textoForca = "Forte";
        corForca = Colors.lightGreen;
        break;
      case 5:
        textoForca = "Muito Forte";
        corForca = Colors.green;
        break;
      default:
        textoForca = "Muito Fraca";
        corForca = Colors.red;
    }

    return Container(
      width: MediaQuery.of(context).size.width * .70,
      padding: const EdgeInsets.all(8.0),
      color: corForca,
      child: Text(
        textoForca,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  ThemeData get tema => ThemeData(
  primarySwatch: Colors.teal,
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.teal,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: Colors.teal.shade700,
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.teal,
    textTheme: ButtonTextTheme.primary,
  ),
);

}
