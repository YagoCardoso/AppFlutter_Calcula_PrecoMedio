import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic TextFields',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TextFieldPair> textFieldPairs = [];

  void addTextFieldPair() {
    setState(() {
      textFieldPairs.add(TextFieldPair());
    });
  }

  void removeTextFieldPair(TextFieldPair pair) {
    setState(() {
      textFieldPairs.remove(pair);
    });
  }

  double calculateTotal() {
    double totalQuantity = 0;
    double totalValue = 0;

    for (var pair in textFieldPairs) {
      totalQuantity += pair.quantity;
      totalValue += pair.value * pair.quantity;
    }

    totalValue = totalValue / totalQuantity;

    return totalValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculo Preço Médio'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: addTextFieldPair,
              child: Text('Adicionar'),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.all(16.0),
          //   child: ElevatedButton(
          //     onPressed: calculateTotal,
          //     child: Text('Calcular'),
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: textFieldPairs.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                            signed: false,
                          ),
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.allow(
                          //     RegExp(r'^\d*\.?\d*$'),
                          //   ),
                          // ],
                          decoration: InputDecoration(
                            labelText: 'Quantidade',
                          ),
                          onChanged: (value) {
                            setState(() {
                              textFieldPairs[index].quantity =
                                  double.tryParse(value) ?? 0;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                            signed: false,
                          ),
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.allow(
                          //     RegExp(r'^\d*\.?\d*$'),
                          //   ),
                          // ],
                          decoration: InputDecoration(
                            labelText: 'Valor Unitário',
                          ),
                          onChanged: (value) {
                            setState(() {
                              textFieldPairs[index].value =
                                  double.tryParse(value) ?? 0;
                            });
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            removeTextFieldPair(textFieldPairs[index]),
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Preço Médio: ${NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(calculateTotal())}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class TextFieldPair {
  double quantity = 0;
  double value = 0;
}
