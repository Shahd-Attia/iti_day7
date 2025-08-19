import 'package:flutter/material.dart';
import 'package:untitled/content.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int stockValue = 5;
  String timePeriod = "WK";

  @override
  void initState(){
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      stockValue = prefs.getInt("stockValue") ??5;
      timePeriod = prefs.getString("timePeriod") ?? "Wk";
    });
  }

  void _openBottomSheet(){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        builder: (context){
          return FractionallySizedBox(
            child: BottomSheetContent(
                stockValue: stockValue,
                timePeriod: timePeriod,
                onApply: (value, period) async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setInt("stockValue",value);
                  await prefs.setString("timePeriod", period);

                  setState(() {
                    stockValue = value;
                    timePeriod = period;
                  });

                },
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Saved Filter:",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text("Stock Performance: $stockValue% or Higher"),
        Text("Time Period: $timePeriod"),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _openBottomSheet,
          child: const Text("Open Filter"),
        ),
      ],
    );
  }
}
