import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.red.shade900,
      accentColor: Colors.red.shade900,
    ),
    debugShowCheckedModeBanner: false,
    title: 'Scientific Calculator',
    home: simpleCalculator(),
  ));
}

class simpleCalculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return calculator();
  }
}

class calculator extends State<simpleCalculator> {
  String name = '';
  String currency = 'Rupees';
  var currencies = ['Rupees', 'Dollars', 'Pounds', 'Yen'];
  TextEditingController principalController = TextEditingController();
  TextEditingController termController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  var displayResult = '';
  var globalKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: Icon(Icons.arrow),
        title: Text('Profit Calculator'),
        backgroundColor: Colors.red.shade900,
      ),
      body: Form(
        key: globalKey,
        child: Padding(
        padding: EdgeInsets.all(20.0),
        //margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            assetImage(),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Expanded(
                child: TextFormField(
                  validator: (String name){
                    if(name.isEmpty){
                      return 'Please Enter A Valid Amount';
                    }
                    else if(double.tryParse(name) == null){
                      return 'Please enter value in numbers';
                    }
                  },
                  controller: principalController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Amount',
                      hintText: 'Enter an amount',
                    errorStyle: TextStyle(
                      color: Colors.red, fontSize: 13.0,
                    ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                  ),
                  style: TextStyle(color: Colors.black),
                  onChanged: (String yourname) {
                    setState(() {
                      name = yourname;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Expanded(
                child: TextFormField(
              validator: (String name) {
                if (name.isEmpty) {
                  return 'Please Enter A Valid Rate Of Profit';
                }
                else if(double.tryParse(name) == null){
                return  'Please enter value in numbers';
                }
              },
                  controller: roiController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Rate Of Profit',
                      hintText: 'In Percentage',
                      errorStyle: TextStyle(
                        color: Colors.red, fontSize: 13.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                  style: TextStyle(color: Colors.black),
                  onChanged: (String yourname) {
                    setState(() {
                      name = yourname;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: (String name) {
                        if (name.isEmpty) {
                          return 'Enter Valid Duration';
                        }
                        else if(double.tryParse(name) == null){
                          return  'Please enter value in numbers';
                        }
                      },
                      controller: termController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Duration',
                          hintText: 'In Years',
                          errorStyle: TextStyle(
                            color: Colors.red, fontSize: 13.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      style: TextStyle(color: Colors.black),
                      onChanged: (String yourname) {
                        setState(() {
                          name = yourname;
                        });
                      },
                    ),
                  ),
                  Container(width: 20.0),
                  Expanded(
                    child: DropdownButton<String>(
                      elevation: 20,
                      items: currencies.map((String naam) {
                        return DropdownMenuItem<String>(
                            value: naam, child: Text(naam));
                      }).toList(),
                      onChanged: (String newCity) {
                        setState(() {
                          this.currency = newCity;
                        });
                      },
                      value: currency,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  child: Expanded(
                      child: RaisedButton(
                    color: Colors.red.shade900,
                    elevation: 6.0,
                    child: Text(
                      'Calculate', textScaleFactor: 1.3,
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        if (globalKey.currentState.validate()) {
                          this.displayResult = calculateTotalReturns();
                        }
                        });
                    },
                  )),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Expanded(
                      child: RaisedButton(
                    color: Colors.red.shade900,
                    elevation: 6.0,
                    child: Text(
                      'Reset', textScaleFactor: 1.3,
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        reset();
                      });
                    },
                  )),
                )
              ],
            ),
            Padding(padding: EdgeInsets.all(20.0),
            child: Text(this.displayResult))
          ],
        ),
      ),
    ));
  }
  String calculateTotalReturns(){
     double principal = double.parse( principalController.text);
     double roi = double.parse( roiController.text);
     double term = double.parse( termController.text);

     double totalAmountPayable =  principal+(principal * roi * term)/100;
     String result = 'After $term years, your investment will be worth $totalAmountPayable $currency';
     return result;
  }
  void reset(){
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';

  }
}

class assetImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('calculator.jpg');
    Image image = Image(image: assetImage, height: 150.0, width: 400.0);
    return Container(child: image);
  }
}
