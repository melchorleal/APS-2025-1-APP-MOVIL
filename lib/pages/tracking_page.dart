import 'package:aps_2025_1_app_movil/models/package_model.dart';
import 'package:aps_2025_1_app_movil/utils/my_colors.dart';
import 'package:flutter/material.dart';

final List<String> statuses = [
  'Paquete entregado.',
  'Aduana completada.',
  'Paquete ha sido enviado.',
  'Pedido registrado.',
];

class TrackingPage extends StatelessWidget {

  TrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Package paquete = ModalRoute.of(context)?.settings.arguments as Package;

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FolioNumBox(package: paquete),
            StatusReport(package: paquete),
            TimelineStatusBox(package: paquete),
          ],
        ),
      ),
    );
  }
}



class TimelineStatusBox extends StatelessWidget {
  final Package package;

  const TimelineStatusBox({
    super.key,
    required this.package,
  });


  @override
  Widget build(BuildContext context) {
    final int currentStatus = statuses.indexOf(package.status);
    
    return Expanded( //ocupar todo el epacio restante
      child: Container( //dar margenes
        margin: EdgeInsets.symmetric(horizontal: 36, vertical: 18),
        child: Row( //crear izquierda y derecha
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 60),
                    height: double.infinity,
                    width: 4,
                    decoration: BoxDecoration(
                      color: MyColors.gray,
                      border: Border.all(
                        color: MyColors.gray,
                      ),
                    ),
                  ),
                  _TimelineStatus( currentStatus: currentStatus),
                ]
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(statuses.length, (i) {
                  final bool isActive = i == currentStatus;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        statuses[i],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      isActive ? Row(
                        children: [
                          Text(
                           package.date,
                            style: TextStyle(
                              fontSize: 14,
                              color: MyColors.gray,
                            ),
                          ),
                          SizedBox(width: 16),
                          Text(
                            package.time,
                            style: TextStyle(
                              fontSize: 14,
                              color: MyColors.gray,
                            ),
                          ),
                        ],
                      ) : SizedBox(height: 16,),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class _TimelineStatus extends StatelessWidget {
  final int currentStatus; 
  const _TimelineStatus({ required this.currentStatus});

  @override
  Widget build(BuildContext context) {
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(statuses.length, (i) {
        final bool isActive = i == currentStatus;
        return Container(
          height: 20,
          decoration: BoxDecoration(
            color: isActive ? MyColors.blue : MyColors.gray,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}


class StatusReportBox extends StatelessWidget {
  final Package package;
  late String simpleStatus = 'Desconocido';
  late Color statusColor = Colors.black;

  StatusReportBox({super.key, required this.package,}) {
    final String status = package.status;
    if (status == statuses[0]) {
      simpleStatus = 'Entregado';
      statusColor = MyColors.green;
    } else if (status == statuses[1]) {
      simpleStatus = 'Enviado';
      statusColor = MyColors.blue;
    } else if (status == statuses[2]) {
      simpleStatus = 'Enviado';
      statusColor = MyColors.blue;
    } else if (status == statuses[3]) {
      simpleStatus = 'Pendiente';
      statusColor = MyColors.red;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Estatus: ',
              style: TextStyle(
                fontSize: 16,
                color: MyColors.gray,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              simpleStatus,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Text(
              package.date,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 16),
            Text(
              package.time,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        )
      ],
    );
  
  }
}


class StatusReport extends StatelessWidget {
  final Package package;

  const StatusReport({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 36, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ultima actualización del paquete:',
            style: TextStyle(
              fontSize: 14, 
              fontWeight: FontWeight.bold,
              color: MyColors.gray,
            )
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: MyColors.bg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: MyColors.gray,
              ),
            ),
            child: StatusReportBox(package: package),
          ),
        ],
      ),
    );
  }
}


class FolioNumBox extends StatelessWidget {
  final Package package;

  const FolioNumBox({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 36, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Número de folio:',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.left,
              ),
              Text(
                '#${package.folio}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: MyColors.bg,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 134, 134, 134).withOpacity(0.2),
                  blurRadius: 2,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({ super.key, });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0xFFFEF7FF),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: AppBar(
        title: Text(
          'Segimiento de mi paquete',
          style: TextStyle(fontSize: 17 , fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

