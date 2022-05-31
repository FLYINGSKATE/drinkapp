import 'package:drinkapp/modals/DrinkModal.dart';
import 'package:flutter/material.dart';
class DrinksDetailsScreen extends StatefulWidget {

  final DrinkModal drinkModal;

  const DrinksDetailsScreen({Key? key, required this.drinkModal}) : super(key: key);
  @override
  _DrinksDetailsScreenState createState() => _DrinksDetailsScreenState();
}

class _DrinksDetailsScreenState extends State<DrinksDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.drinkModal.strDrink??""),),
      body: Center(
        child: Text(
          widget.drinkModal.toJson().toString()??"",
        ),
      ),
    );
  }
}
