import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _temperatureController = TextEditingController();

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      controller.text = "${picked.hour}:${picked.minute}";
    }
  }


  Widget _buildTextField(TextEditingController controller, String label, IconData icon,
      {bool isDate = true}) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon: Icon(icon, size: 20),
          labelText: label,
          labelStyle: TextStyle(fontSize: 14),
        ),
        readOnly: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Divider(color: Colors.black),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Data Base',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: Colors.black),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                _buildTextField(_dateStartController, 'Data Inicial', Icons.calendar_today),
                const Text("    --   "),
                _buildTextField(_dateEndController, 'Data Final', Icons.calendar_today),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                _buildTextField(_timeController, 'Hora', Icons.timer, isDate: false),
                SizedBox(width: 10),
                _buildTextField(_temperatureController, 'Temp (°C)', Icons.thermostat, isDate: false),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                print('Pesquisar com: ${_dateStartController.text} - ${_dateEndController.text}, Hora: ${_timeController.text}, Temp: ${_temperatureController.text}');
              },
              child: Text('Pesquisar'),
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 40)),
            ),
            SizedBox(height: 20),
            ...List.generate(
                3,
                    (index) => Card(
                  child: ListTile(
                    leading: Icon(Icons.access_time, size: 40),
                    title: Text('13:00'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('8 Aug 2021'),
                        Text('25°'),
                      ],
                    ),
                    trailing: Icon(Icons.more_vert),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
