import 'package:flutter/material.dart';

import 'timepicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Show Custom Time Picker Demo',
      home: CustomTimePickerDemo(),
    );
  }
}

class CustomTimePickerDemo extends StatefulWidget {
  @override
  _CustomTimePickerDemoState createState() => _CustomTimePickerDemoState();
}

class _CustomTimePickerDemoState extends State<CustomTimePickerDemo> {
  String selectedTime;

  List<int> _availableHours = [1, 4, 6, 8, 12];
  List<int> _availableMinutes = [0, 10, 30, 45, 50];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: InkWell(
        onTap: () =>
        // DEMO --------------
        showCustomTimePicker(
            context: context,
            onFailValidation: (context) =>
                showMessage(context, 'Unavailable selection.'),
            initialTime: TimeOfDay(
                hour: _availableHours.first,
                minute: _availableMinutes.first),
            selectableTimePredicate: (time) =>
            _availableHours.indexOf(time.hour) != -1 &&
                _availableMinutes.indexOf(time.minute) != -1).then(
                (time) =>
                setState(() => selectedTime = time?.format(context))),
        // --------------

        child: Text(
          selectedTime ?? 'Select Time',
          style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );

  showMessage(BuildContext context, String message) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 16,
              ),
              Icon(
                Icons.warning,
                color: Colors.amber,
                size: 56,
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF231F20),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      border:
                      Border(top: BorderSide(color: Color(0xFFE8ECF3)))),
                  child: Text(
                    'Cerrar',
                    style: TextStyle(
                        color: Color(0xFF2058CA),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}