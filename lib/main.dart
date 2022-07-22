

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorWidget(),
    );
  }
}

class CalculatorWidget extends StatefulWidget {
  CalculatorWidget({Key? key}) : super(key: key);
  List numbers = [];
  String sentance="" ;

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [


              Expanded(
                  child: Align(

                    alignment: AlignmentDirectional.bottomEnd,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(


                        widget.sentance,
                        style: TextStyle(fontSize: 40 , color:  Color(0xFF51557E)),
                      ),
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(

                      onPressed: () {
                        setState(() {
                          if (!widget.numbers.isEmpty) {
                            String last = widget.numbers.last;


                            widget.numbers.removeLast();
                            if (last.length > 0) {
                              widget.numbers.add(
                                  last.substring(0, last.length - 1));
                            }


                            var res = widget.sentance.substring(
                                0, widget.sentance.length - 1);
                            widget.sentance = res;

                            print('kkkkkkkk' + widget.numbers.toString());
                          }
                        });
                      },
                      icon: Icon(Icons.backspace_outlined, size: 35,
                        color: Color(0xFF51557E),)),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Number(char: '7'),
                        Number(char: '8'),
                        Number(char: '9'),
                        Number(char: 'x')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Number(char: '4'),
                        Number(char: '5'),
                        Number(char: '6'),
                        Number(char: '-')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Number(char: '1'),
                        Number(char: '2'),
                        Number(char: '3'),
                        Number(char: '+')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Number(char: '0'),
                        Number(char: 'C'),
                        Number(char: '/'),
                        Number(char: '=')
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


  Number({required String char}) {
    return TextButton(onPressed: () {
      setState(() {
        //clear
        if (char.toLowerCase() == 'c') {
          widget.sentance = '';
          widget.numbers = [];
          return;
        }


        int? newChar = int.tryParse(char);
        // case to insert operator first
        if (widget.numbers.length == 0 && newChar == null) {
          final snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(20),

            duration: Duration(seconds: 1),
            dismissDirection: DismissDirection.vertical,
            backgroundColor: Colors.red,
            content: const Text('Operator Cant\'t be inserted first',
              style: TextStyle(fontSize: 20),),

          );


          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return;
        }

        //case to insert = while no Mathmatics Operaitors exists
        if (!widget.numbers.contains('+') &&
            !widget.numbers.contains('-') && !widget.numbers.contains('/') &&
            !widget.numbers.contains('x')
            && char == '='
        ) {
          return;
        }


        if (widget.numbers.length != 0) {
          print('ddddd' + widget.numbers.toString());
          int? lastChar = int.tryParse(widget.numbers.last);
          print('lastchar' + lastChar.toString());
          if (lastChar == null && newChar == null &&
              widget.numbers.length != 1) {
            final snackBar = SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(20),

              duration: Duration(seconds: 1),
              dismissDirection: DismissDirection.vertical,
              backgroundColor: Colors.red,
              content: Text('Operators Cant\'t be inserted next To Other',
                style: TextStyle(fontSize: 20),),

            );

            // Find the ScaffoldMessenger in the widget tree
            // and use it to show a SnackBar.
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            return;
          }
        }


        widget.sentance += char.toString();


        if (!widget.numbers.isEmpty && newChar != null &&
            int.tryParse(widget.numbers.last) != null) {
          widget.numbers.last += char;
          print(widget.numbers.last);
          return;
        }
        widget.numbers.add(char);
        print(widget.numbers);


        //Case to see the result
        if (char == '=') {
          double result = double.parse(widget.numbers[0]);


          for (int i = 1; i < widget.numbers.length; i++) {
              print(i);
              print(widget.numbers.length);

              if(widget.numbers[i] =='+'){
                result += int.parse(widget.numbers[i + 1]);
              }
              else if(widget.numbers[i] =='-'){
                result -= int.parse(widget.numbers[i + 1]);
              }
              else if(widget.numbers[i] =='x'){
                result *= int.parse(widget.numbers[i + 1]);
              }
              else if(widget.numbers[i] =='/'){
                result /= int.parse(widget.numbers[i + 1]);
              }


          }

          print(result);
          widget.sentance = result.toString();
          widget.numbers = [];
          widget.numbers.add(result.toString());
        }
      });
    },

        style: TextButton.styleFrom(
            minimumSize: Size.fromRadius(38),


            backgroundColor: Color(0xFFD6D5A8)),

        // maximumSize: Size(100,80)


        child: Text(
          char, style: TextStyle(color: Color(0xFF51557E), fontSize: 30),));
  }



}
