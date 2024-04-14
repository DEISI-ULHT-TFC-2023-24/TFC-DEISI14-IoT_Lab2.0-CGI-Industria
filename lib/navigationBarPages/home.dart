import 'package:flutter/material.dart';

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
      length: 3,
      child: Scaffold(
        body: Column(
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
                  IngredientsList(),
                  ProcessProgressWidget(),
                  Center(child: Text('Conteúdo do Bloco 3')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlock(String title, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(color: Color(0xFF7A2119)),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildLine(double length, double thickness) {
    return Container(
      height: thickness,
      width: length,
      color: Colors.black,
    );
  }

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

  Widget _buildIconBlock(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Color(0xFF4B140C),
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

class IngredientsList extends StatelessWidget {
  final List<String> ingredients = [
    'Açúcar',
    'Leite',
    'Cacau',
    'Manteiga',
    'Leite Condensado',
    'Amêndoas'
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            ingredients[index],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text('${index + 1}º ingrediente'),
        );
      },
    );
  }
}

class ProcessProgressWidget extends StatefulWidget {
  @override
  _ProcessProgressWidgetState createState() => _ProcessProgressWidgetState();
}

class _ProcessProgressWidgetState extends State<ProcessProgressWidget> {
  double processCompletion = 0.0;
  double currentTemperature = 10.0;
  List<Map<String, dynamic>> processStages = [
    {'title': 'Entrada dos ingredientes', 'isCompleted': false},
    {'title': 'Junção dos Ingredientes', 'isCompleted': false},
    {'title': 'Fase de mistura', 'isCompleted': false},
    {'title': 'finalizado para ser embalado', 'isCompleted': false},
    // Adicione mais fases conforme necessário
  ];

  void _updateProgress() {
    setState(() {
      processCompletion += 0.1;
      if (processCompletion > 1.0) {
        processCompletion = 1.0;
      }
      currentTemperature += 5.0;

      // Atualiza o estado de conclusão das fases
      for (int i = 0; i < processStages.length; i++) {
        processStages[i]['isCompleted'] =
            processCompletion > (i + 1) / processStages.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Conclusão do Processo',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: _updateProgress,
              ),
            ],
          ),
          LinearProgressIndicator(
            value: processCompletion,
            backgroundColor: Colors.grey[300],
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ),
          Text('${(processCompletion * 100).toStringAsFixed(0)}%'),
          ...processStages
              .map((stage) => ProcessStageIndicator(
                    title: stage['title'],
                    isCompleted: stage['isCompleted'],
                  ))
              .toList(),
          SizedBox(height: 35),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.thermostat_outlined, size: 24),
              SizedBox(width: 8),
              Text(
                'Temperatura Atual ${currentTemperature.toInt()}°',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProcessStageIndicator extends StatelessWidget {
  final String title;
  final bool isCompleted;

  const ProcessStageIndicator({
    Key? key,
    required this.title,
    this.isCompleted = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(
            isCompleted
                ? Icons.check_circle_outline
                : Icons.radio_button_unchecked,
            size: 20,
            color: isCompleted ? Colors.green : Colors.grey,
          ),
          SizedBox(width: 8),
          Expanded(child: Text(title)),
        ],
      ),
    );
  }
}
