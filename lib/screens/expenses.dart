// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  List<Map<String, dynamic>> expenses = [
    {"date": DateTime(2024, 1, 1), "amount": 20000},
    {"date": DateTime(2024, 5, 12), "amount": 12000},
    {"date": DateTime(2024, 5, 16), "amount": 6000},
    {"date": DateTime(2024, 4, 1), "amount": 9000},
  ];

  @override
  Widget build(BuildContext context) {
    // Group expenses by month
    Map<String, num> monthlyTotals = {};
    for (var expense in expenses) {
      String monthYear = "${expense['date'].month}-${expense['date'].year}";
      if (!monthlyTotals.containsKey(monthYear)) monthlyTotals[monthYear] = 0;
      monthlyTotals[monthYear] = monthlyTotals[monthYear]! + (expense['amount'] as num);
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
          "Expense Analysis",
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

            // Bar Chart for monthly expenses
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
              "Recent Expenses",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ...expenses.map((expense) => _AmountTile(
                  "${expense['date'].day} ${_monthName(expense['date'].month)} ${expense['date'].year}",
                  expense['amount'].toString(),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddExpenseDialog(context),
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
    );
  }

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
      "", // placeholder
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

  void _showAddExpenseDialog(BuildContext context) {
    final TextEditingController dateController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Expense"),
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
                  hintText: "e.g., 5000",
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
                    expenses.add({
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
