import 'package:flutter/material.dart';

class FolioPage extends StatelessWidget {
  const FolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(1),
        margin: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Logo(),
            _FolioTitle(),
            _FolioInput(),
            _SearchButton(),
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom:50),
      child: Image.asset(
        'assets/logo-dark.png',
        width: 200,
      ),
    );
  }
}

class _FolioTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: 5),
      child: Text(
        'Numero de Folio:',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _FolioInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      margin: EdgeInsets.only(bottom: 50),
      child: TextField(
        
        decoration: InputDecoration(
          hintText: 'Ingrese su número de folio',
          hintStyle: TextStyle(fontSize: 13.5, color: const Color(0xFFB8B8B8)),
          helperText: 'Ejemplo: 1234567890',
          helperStyle: TextStyle( color: const Color(0xFFB8B8B8)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide(color: const Color(0xFF355F88), width: 2),
          ),
        ),
      ),
    );
  }
}

class _SearchButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, 'tracking_page'),
        
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF355F88),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
          textStyle: null,
        ),
        child: Text(
          'Buscar',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}