import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

enum SingingCharacter { Grad, Fahrenheit }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Temperatur Umrechner',
      home: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final myController = TextEditingController();
  String text = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  SingingCharacter? _character = SingingCharacter.Grad;
  String output = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Temperatur Umrechner'),
        ),
        body: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Wähle aus:", style: TextStyle(fontSize: 25))),
                RadioListTile<SingingCharacter>(
                  title: const Text('Grad Celsius'),
                  value: SingingCharacter.Grad,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                      text = "";
                      myController.text = "";
                    });
                  },
                ),
                RadioListTile<SingingCharacter>(
                  title: const Text('Fahrenheit'),
                  value: SingingCharacter.Fahrenheit,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                      text = "";
                      myController.text = "";
                    });
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(children: [
                const Text("Input:"),
                const SizedBox(width: 30),
                Flexible(
                  child: TextField(
                      controller: myController,
                      onChanged: (content) {
                        if (_character!.index == 0) {
                          if (myController.text.length > 0) {
                            output = (273.15 + double.parse(myController.text))
                                    .toStringAsFixed(2) +
                                " F";
                            setState(() => text = output);
                          }
                        } else {
                          if (myController.text.length > 0) {
                            output = (double.parse(myController.text) - 273.15)
                                    .toStringAsFixed(2) +
                                " C";
                            setState(() => text = output);
                          }
                        }
                      }),
                ),
                if (_character!.index == 0) ...[
                  const Text("C"),
                ] else ...[
                  const Text("F")
                ],
              ]),
            ),
            Text("Output:  " + text,
              style: const TextStyle(fontSize: 20),
            )
          ],
        ));
  }
}
