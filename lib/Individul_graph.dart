import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'dart:convert';

class IndividualData {
  final int day;
  final double litres;

  IndividualData({required this.day, required this.litres});
}

class IndividualGraph extends StatefulWidget {
  final String name;

  const IndividualGraph({required this.name, Key? key}) : super(key: key);

  @override
  _IndividualGraphState createState() => _IndividualGraphState();
}

class _IndividualGraphState extends State<IndividualGraph> {
  List<charts.Series<IndividualData, int>> _seriesList = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchData(); // Fetch data when the widget initializes
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.get(Uri.parse("API/${widget.name}"));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final List<IndividualData> data = jsonData.map((e) => IndividualData(
          day: e["day"],
          litres: double.tryParse(e["litres"].toString()) ?? 0.0,
        )).toList();

        _seriesList = [
          charts.Series<IndividualData, int>(
            id: 'Litres',
            colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
            domainFn: (IndividualData data, _) => data.day,
            measureFn: (IndividualData data, _) => data.litres,
            data: data,
          ),
        ];
      } else {
        throw Exception("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (error) {
      _errorMessage = "Error fetching data: ${error.toString()}";
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _errorMessage.isNotEmpty
        ? Center(child: Text(_errorMessage))
        : _seriesList.isNotEmpty
        ? charts.LineChart(
      _seriesList,
      animate: true,
      defaultRenderer: charts.LineRendererConfig(
        includeArea: true,
      ),
      domainAxis: const charts.NumericAxisSpec(
        tickProviderSpec: charts.StaticNumericTickProviderSpec(
          [
            charts.TickSpec(1, label: "Mon"),
            charts.TickSpec(2, label: "Tue"),
            charts.TickSpec(3, label: "Wed"),
            charts.TickSpec(4, label: "Thu"),
            charts.TickSpec(5, label: "Fri"),
            charts.TickSpec(6, label: "Sat"),
            charts.TickSpec(7, label: "Sun"),
          ],
        ),
      ),
      behaviors: [
        charts.ChartTitle(
          '',
          behaviorPosition: charts.BehaviorPosition.top,
          titleOutsideJustification: charts.OutsideJustification.start,
        ),
      ],
    )
        : const Center(child: Text("No data available"));
  }
}
