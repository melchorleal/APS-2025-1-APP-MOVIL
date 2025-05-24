import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/package_provider.dart';

class FolioPage extends StatelessWidget {
  const FolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController folioController = TextEditingController();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(1),
        margin: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Logo(),
            _FolioTitle(),
            _FolioInput(controller: folioController,),
            _SearchButton(controller: folioController),
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
  final TextEditingController controller;

  const _FolioInput({Key? key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      margin: EdgeInsets.only(bottom: 50),
      child: TextField(
        controller: controller,

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
  final TextEditingController controller;

  const _SearchButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(bottom: 30),
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
//        onPressed: () => Navigator.pushNamed(context, 'tracking_page'),
        
        onPressed: () async {
          final folio = controller.text.trim();
          if (folio.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Por favor ingrese un número de folio.'),
                duration: Duration(seconds: 3),
              ),
            );
            return;
          }
          final packageProvider = Provider.of<PackageProvider>(context, listen: false);
          await packageProvider.fetchPackage(folio);
          if (packageProvider.package != null) {
            Navigator.pushNamed(context, 'tracking_page', arguments: packageProvider.package);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(packageProvider.errorMessage ?? 'Error al buscar el paquete.', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                duration: Duration(seconds: 3),
                backgroundColor:  const Color(0xFFFFA1A1),
              ),
            );
          } 
        },
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