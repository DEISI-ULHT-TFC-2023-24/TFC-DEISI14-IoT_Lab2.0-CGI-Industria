import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';


void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: '--------Control Options--------',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assets'),
        actions: <Widget>[
          // Usando IconButton para permitir toques na imagem, caso necessário.

          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implementar ação de pesquisa
            },
          ),
          IconButton(
            icon: Icon(Icons.precision_manufacturing),
            onPressed: () {
              // Implementar mais opções
            },
          ),
          IconButton(
            icon: const Icon(Icons.message_outlined),
            onPressed: () {
              // Implementar mais opções
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const Divider(thickness: 2), // Divider for Control Options
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              // Espaçamento ao redor do texto
              child: Text('Controll Options',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _buildControlButton(context, 'OK', Icons.check),
                          _buildControlButton(context, 'NOT OK', Icons.close),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.memory_outlined),
            label: 'Base',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad),
            label: 'Controller',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: 'All',
          ),
        ],
        // Implementar a lógica de mudança de estado
      ),
    );
  }

  Widget _buildControlButton(
      BuildContext context, String label, IconData icon) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[300],
        // Define a cor de fundo do botão
        foregroundColor: Colors.black,
        // Define a cor do texto e do ícone
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold, // Deixa o texto em negrito
        ),
        elevation: 0,
        // Remove shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      ),
      onPressed: () {
        // Implementar ação dos botões de controle
      },
    );
  }
}





