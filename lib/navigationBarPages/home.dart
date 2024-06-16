import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Configurações de tamanho
    double blockSize = 60.0;
    double iconBlockSize = 40.0;
    double lineWidth = 30.0;
    double lineThickness = 2.0;
    double parallelLineLength = 50.0;
    double parallelLineSpacing = 4.0;
    double spaceBetweenBlocksAndTabs = 40.0;

    return DefaultTabController(
      length: 3, // Número de abas
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 55.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildBlock('Bloco 1', blockSize),
                  _buildLine(lineWidth, lineThickness),
                  _buildBlock('Bloco 2', blockSize),
                  _buildLine(lineWidth, lineThickness),
                  _buildBlock('Bloco 3', blockSize),
                  _buildParallelLines(
                      parallelLineLength, lineThickness, parallelLineSpacing),
                  _buildIconBlock(iconBlockSize),
                ],
              ),
            ),
            SizedBox(height: spaceBetweenBlocksAndTabs),
            Material(
              color: Colors.white,
              child: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Color(0xFFC2BABA),
                indicatorColor: Colors.red[900],
                tabs: [
                  Tab(text: 'Bloco 1'),
                  Tab(text: 'Bloco 2'),
                  Tab(text: 'Bloco 3'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  FirebaseDataList(), // Conteúdo da aba "Bloco 1"
                  TaskTemperatureWidget(), // Conteúdo da aba "Bloco 2"
                  Center(child: Text('Conteúdo do Bloco 3')), // Conteúdo da aba "Bloco 3"
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir um bloco
  Widget _buildBlock(String title, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Color(0xFF7A2119)),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 14, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // Método para construir uma linha
  Widget _buildLine(double length, double thickness) {
    return Container(
      height: thickness,
      width: length,
      color: Colors.black,
    );
  }

  // Método para construir linhas paralelas
  Widget _buildParallelLines(double length, double thickness, double spacing) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: thickness,
          width: length,
          color: Colors.black,
        ),
        SizedBox(height: spacing),
        Container(
          height: thickness,
          width: length,
          color: Colors.black,
        ),
      ],
    );
  }

  // Método para construir um bloco com ícone
  Widget _buildIconBlock(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Color(0xFF4B140C),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Color(0xFF7A2119)),
      ),
      child: Center(
        child: Icon(
          Icons.card_giftcard_outlined,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}

// Widget para ler dados do Firebase Realtime Database para a aba "Bloco 1"
class FirebaseDataList extends StatefulWidget {
  @override
  _FirebaseDataListState createState() => _FirebaseDataListState();
}

class _FirebaseDataListState extends State<FirebaseDataList> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  Map<dynamic, dynamic> _data = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
        _databaseReference.child("listNode").onChildAdded.listen((data){
        print(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _data.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          String key = _data.keys.elementAt(index);
          return ListTile(
            title: Text('$key: ${_data[key]}'),
          );
        },
      ),
    );
  }
}

// Widget da lista de tarefas e temperatura para a aba "Bloco 2"
class TaskTemperatureWidget extends StatefulWidget {
  @override
  _TaskTemperatureWidgetState createState() => _TaskTemperatureWidgetState();
}

class _TaskTemperatureWidgetState extends State<TaskTemperatureWidget> {
  final List<String> tasks = [
    'O laaa',
    'Leite',
    'Cacau',
    'Manteiga',
    'Leite Condensado',
    'Amêndoas'
  ];
  final List<bool> _isChecked = List<bool>.filled(6, false);
  int _completedTasks = 0;
  double currentTemperature = 10.0;
  bool isIncreasing = true;
  late Timer _temperatureTimer;
  late Timer _taskTimer;

  @override
  void initState() {
    super.initState();
    _startTemperatureUpdate();
    _startTaskUpdate();
  }

  // Método para iniciar a atualização da temperatura
  void _startTemperatureUpdate() {
    _temperatureTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (isIncreasing) {
          currentTemperature += 1.0;
          if (currentTemperature >= 250.0) {
            isIncreasing = false;
          }
        } else {
          currentTemperature -= 1.0;
          if (currentTemperature <= 10.0) {
            isIncreasing = true;
          }
        }
      });
    });
  }

  // Método para iniciar a atualização das tarefas
  void _startTaskUpdate() {
    _taskTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        if (_completedTasks < tasks.length) {
          _isChecked[_completedTasks] = true;
          _completedTasks++;
        }
      });
    });
  }

  @override
  void dispose() {
    _temperatureTimer.cancel();
    _taskTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(tasks[index]),
                  value: _isChecked[index],
                  onChanged: null, // Desativado para tornar automático
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: _completedTasks / tasks.length,
                ),
                SizedBox(height: 10),
                Text(
                  '${(_completedTasks / tasks.length * 100).toInt()}% Completo',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  _completedTasks == tasks.length ? 'Mix Completo!' : '',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: _completedTasks == tasks.length ? Colors.green : Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.red),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.thermostat_outlined, size: 24, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  'Temperatura Atual: ${currentTemperature.toInt()}°',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
