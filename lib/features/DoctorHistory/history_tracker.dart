import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineDefault extends StatefulWidget {
  const LineDefault({Key? key}) : super(key: key);

  @override
  _LineDefaultState createState() => _LineDefaultState();
}

class _LineDefaultState extends State<LineDefault> {
  List<_ChartData> chartData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));
    DateTime daybefyes = now.subtract(Duration(days: 2));

    String formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

    List<String> dates = [
      formatDate(yesterday),
      formatDate(now),
      formatDate(daybefyes)
    ];

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('History Tracker')
          .where('date', whereIn: dates)
          .get();

      List<_ChartData> loadedData = snapshot.docs.map((doc) {
        return _ChartData(
          date: DateTime.parse(doc['date']),
          amount: doc['amount'].toDouble(),
          patients: doc['patients'].toDouble(),
        );
      }).toList();

      setState(() {
        chartData = loadedData;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chart Example'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
            child:
                Container(
                height: 400,
                width: 400,
                child: _buildDefaultLineChart()),

                ),




      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDataDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddDataDialog() {
    final _formKey = GlobalKey<FormState>();
    DateTime selectedDate = DateTime.now();
    TextEditingController amountController = TextEditingController();
    TextEditingController patientsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Data'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: amountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: patientsController,
                  decoration: InputDecoration(labelText: 'Number of Patients'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of patients';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null && pickedDate != selectedDate) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await FirebaseFirestore.instance
                          .collection('History Tracker')
                          .doc(selectedDate.toString()).set({
                        'date': DateFormat('yyyy-MM-dd').format(selectedDate),
                        'amount': double.parse(amountController.text),
                        'patients': double.parse(patientsController.text),
                      });
                      Navigator.of(context).pop();
                      fetchDataFromFirestore();
                    }
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  SfCartesianChart _buildDefaultLineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'History Tracker'),
      legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis: DateTimeAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          intervalType: DateTimeIntervalType.days,
          dateFormat: DateFormat('MMM dd'),
          majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(color: Colors.transparent)),
      series: _getDefaultLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  List<LineSeries<_ChartData, DateTime>> _getDefaultLineSeries() {
    return <LineSeries<_ChartData, DateTime>>[
      LineSeries<_ChartData, DateTime>(
          dataSource: chartData,
          xValueMapper: (_ChartData data, _) => data.date,
          yValueMapper: (_ChartData data, _) => data.amount/100,
          name: 'Amount (in hundreds)',
          markerSettings: MarkerSettings(isVisible: true,
              width: 4,
              height: 4
          )),
      LineSeries<_ChartData, DateTime>(
          dataSource: chartData,
          xValueMapper: (_ChartData data, _) => data.date,
          yValueMapper: (_ChartData data, _) => data.patients,
          name: 'Number of Patients',
          markerSettings: MarkerSettings(isVisible: true,
            )),
    ];
  }

  @override
  void dispose() {
    chartData.clear();
    super.dispose();
  }
}

class _ChartData {
  _ChartData({required this.date, required this.amount, required this.patients});
  final DateTime date;
  final double amount;
  final double patients;
}