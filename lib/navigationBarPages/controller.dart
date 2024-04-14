import 'package:flutter/material.dart';
import 'mqttConfigure.dart';

class ControllerPage extends StatelessWidget {
  ControllerPage({super.key});

  final MQTTManager _myClient = MQTTManager(
      host: 'loalhost ', topic: '22205245/anawen/device/test');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text(navigationsBarList[2].title),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Controller',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildControllerButton('Subscribe', Icons.holiday_village,
                    () => _myClient.subscribe()),
                SizedBox(
                  width: 15,
                  height: 20,
                ),
                buildControllerButton(
                    'Unsubscrib',
                    Icons.accessibility_new_rounded,
                    () => _myClient.unsubscribe())
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildControllerButton('  OK        ', Icons.holiday_village,
                    () => _myClient.publishMessage('Corre função 2 modo OK')),
                SizedBox(
                  width: 20,
                  height: 20,
                ),
                buildControllerButton(
                    'NOT OK     ',
                    Icons.maps_home_work,
                    () =>
                        _myClient.publishMessage('Corre função 3 modo NOT OK')),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildControllerButton(
                    'Disconnect',
                    Icons.accessibility_new_rounded,
                    () => _myClient.disconnect())
              ],
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildControllerButton(
      String label, IconData iconData, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // Ajuste o preenchimento conforme necessário
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.0),
        // Aumenta o espaço dentro do botão
        decoration: BoxDecoration(
          color: Colors.grey[200], // Define a cor de fundo cinza
          borderRadius: BorderRadius.circular(10.0), // Cantos arredondados
          border: Border.all(
              color: Colors.black,
              width:
                  2), // Mantém a borda como está, mas ajusta a largura conforme necessário
        ),
        child: TextButton(
          onPressed: () {
            onPressed.call();
            debugPrint('Pressed $label');
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            minimumSize: Size(95, 15), // Largura e altura mínimas do botão
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            // Para garantir que o conteúdo não estique além do necessário
            children: [
              Icon(iconData), // O ícone que você deseja
              SizedBox(width: 10), // Um pequeno espaço entre o ícone e o texto
              Text(label), // O texto que você deseja exibir
            ],
          ),
        ),
      ),
    );
  }
}
