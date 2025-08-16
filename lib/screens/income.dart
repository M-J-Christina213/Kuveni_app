import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  List<Map<String, dynamic>> incomes = [
    {"date": DateTime(2024, 6, 12), "amount": 50000},
    {"date": DateTime(2024, 6, 10), "amount": 25000},
    {"date": DateTime(2024, 6, 8), "amount": 36000},
    {"date": DateTime(2024, 6, 5), "amount": 180000},
    {"date": DateTime(2024, 7, 3), "amount": 45000},
  ];

  @override
  Widget build(BuildContext context) {
    // Group incomes by month
    Map<String, int> monthlyTotals = {};
    for (var income in incomes) {
      String monthYear = "${income['date'].month}-${income['date'].year}";
      if (!monthlyTotals.containsKey(monthYear)) monthlyTotals[monthYear] = 0;
      monthlyTotals[monthYear] = monthlyTotals[monthYear]! + (income['amount'] as int);

    }

    List<String> sortedMonths = monthlyTotals.keys.toList()
      ..sort((a, b) {
        List<int> aParts = a.split('-').map(int.parse).toList();
        List<int> bParts = b.split('-').map(int.parse).toList();
        return DateTime(aParts[1], aParts[0]).compareTo(DateTime(bParts[1], bParts[0]));
      });

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Income Analysis",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hello, Bhagya 👋",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Bar Chart for monthly income
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: (monthlyTotals.values.reduce((a, b) => a > b ? a : b) * 1.2),
                  barGroups: sortedMonths.map((month) {
                    return BarChartGroupData(
                      x: sortedMonths.indexOf(month),
                      barRods: [
                        BarChartRodData(
                          toY: monthlyTotals[month]!.toDouble(),
                          color: Colors.deepPurple,
                          width: 18,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ],
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index >= 0 && index < sortedMonths.length) {
                            List<String> parts = sortedMonths[index].split('-');
                            return Text("${_monthName(int.parse(parts[0]))} ${parts[1]}");
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                  ),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              "Recent Incomes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ...incomes.map((income) => _AmountTile(
                  "${income['date'].day} ${_monthName(income['date'].month)} ${income['date'].year}",
                  income['amount'].toString(),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddIncomeDialog(context),
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _AmountTile(String date, String amount) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(date, style: const TextStyle(fontSize: 16)),
        trailing: Text(
          "Rs. $amount",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  String _monthName(int month) {
    const names = [
      "", // 0 placeholder
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return names[month];
  }

  void _showAddIncomeDialog(BuildContext context) {
    final TextEditingController dateController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Income"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: dateController,
                decoration: const InputDecoration(
                  labelText: "Date (dd-mm-yyyy)",
                  hintText: "e.g., 16-08-2025",
                ),
              ),
              TextField(
                controller: amountController,
                decoration: const InputDecoration(
                  labelText: "Amount",
                  hintText: "e.g., 50000",
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (dateController.text.isNotEmpty &&
                    amountController.text.isNotEmpty) {
                  List<String> parts = dateController.text.split('-');
                  DateTime date = DateTime(
                    int.parse(parts[2]),
                    int.parse(parts[1]),
                    int.parse(parts[0]),
                  );

                  setState(() {
                    incomes.add({
                      "date": date,
                      "amount": int.parse(amountController.text)
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
