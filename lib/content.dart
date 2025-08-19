import 'package:flutter/material.dart';

class BottomSheetContent extends StatefulWidget {
  final int stockValue;
  final String timePeriod;
  final Function(int, String) onApply;

  const BottomSheetContent({
    super.key,
    required this.stockValue,
    required this.timePeriod,
    required this.onApply
  });

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  late int currentValue;
  late String selectedPeriod;
  String arrow = "↑";
  final List<String> periods = ["Wk", "30D", "90D", "Year"];

  @override
  void initState(){
    super.initState();
    currentValue = widget.stockValue;
    selectedPeriod = widget.timePeriod;
  }

  void increment() {
    setState(() {
      currentValue += 5;
      arrow = "↑";
    });
  }

  void decrement() {
    if (currentValue > 5) {
      setState(() {
        currentValue -= 5;
        arrow = "↓";
      });
    }
  }

  void reset() {
    setState(() {
      currentValue = 5;
      selectedPeriod = "Wk";
      arrow = "↑";
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Stock Performance",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

            const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(decoration:BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.grey[200]),child: IconButton(onPressed: decrement, icon: Icon(Icons.remove))),
              SizedBox(width: 60,),
              Container(width:110,decoration:BoxDecoration(border: Border.all(color: Colors.grey , width: 2),borderRadius: BorderRadius.circular(20)),child: Text("$arrow $currentValue or Higher",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold ))),
              SizedBox(width: 60,),
              Container(decoration:BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.grey[200]),child: IconButton(onPressed: increment, icon: Icon(Icons.add)))
            ],
          ),
          const Divider(height: 30,thickness: 1,),

          const Text("Time Period",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: periods.map((p) {
              final bool isSelected = p == selectedPeriod;
              return GestureDetector(
                onTap: () => setState(() => selectedPeriod = p),
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                    border: isSelected
                        ? Border.all(color: Colors.deepPurple, width: 2)
                        : null,
                  ),
                  child: Text(
                    p,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color:
                      isSelected ? Colors.deepPurple : Colors.grey[800],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const Divider(height: 30, thickness: 1,),

          Center(
            child: TextButton(
              onPressed: reset,
              style: TextButton.styleFrom(
                foregroundColor: Colors.deepPurple,
              ),
              child: const Text("Reset"),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                widget.onApply(currentValue, selectedPeriod);
                Navigator.pop(context);
              },
              child: const Text(
                "Apply",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          )

        ],
      ),
    );
  }
}











