import 'package:aps_2025_1_app_movil/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/package_provider.dart';



class FolioPage extends StatelessWidget {
  const FolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    final TextEditingController folioController = TextEditingController();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        margin: EdgeInsets.all(1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Logo(),
            _FolioTitle(),
            _FolioInput(controller: folioController, focusNode: focusNode,),
            _SearchButton(controller: folioController, focusNode: focusNode),
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
  final FocusNode focusNode;


  _FolioInput({required this.controller, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      margin: EdgeInsets.only(bottom: 50),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          hintText: 'Ingrese su número de folio',
          hintStyle: TextStyle(fontSize: 13.5, color: MyColors.gray),
          helperText: 'Ejemplo: 1234567890',
          helperStyle: TextStyle( color: MyColors.gray),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide(color: MyColors.blue, width: 2),
          ),
        ),
      ),
    );
  }
}

class _SearchButton extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controller;

  _SearchButton({required this.controller, required this.focusNode});

  @override
  State<_SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<_SearchButton> {
  bool isLoading = false;

  Future<void> _onSearchPressed(BuildContext context) async {
    if (isLoading) return;
    setState(() => isLoading = true);
    final folio = widget.controller.text.trim();
    final folioInt = int.tryParse(folio);
    if (folio.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor ingrese un número de folio.'),
          duration: Duration(seconds: 3),
        ),
      );
      setState(() => isLoading = false);
      return;
    }
    if (folioInt == null ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('El número de folio debe ser un número entero.'),
          duration: Duration(seconds: 3),
        ),
      );
      setState(() => isLoading = false);
      return;
    }
    final packageProvider = Provider.of<PackageProvider>(context, listen: false);
    await packageProvider.fetchPackage(folio);
    if (packageProvider.package != null) {
      widget.focusNode.unfocus();
      Navigator.pushNamed(
        context, 'tracking_page',
        arguments: {
          'packageArg': packageProvider.package,
          'focusNodeArg': widget.focusNode
        }
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            packageProvider.errorMessage ?? 'Error al buscar el paquete.',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          duration: Duration(seconds: 3),
          backgroundColor: const Color(0xFFFFA1A1),
        ),
      );
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : () => _onSearchPressed(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
          textStyle: null,
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                'Buscar',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
      ),
    );
  }
}