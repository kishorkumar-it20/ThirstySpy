// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async';
//
// class DailyData {
//   final int day;
//   final double litres;
//
//   DailyData({required this.day, required this.litres});
// }
//
// class WeekWiseGraph extends StatefulWidget {
//   @override
//   _WeekWiseGraphState createState() => _WeekWiseGraphState();
// }
//
// class _WeekWiseGraphState extends State<WeekWiseGraph> {
//   List<charts.Series<DailyData, int>> _seriesList = []; // List of series for the chart
//   bool _isLoading = true; // To handle loading state
//   String _errorMessage = ''; // To handle error messages
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchData(); // Fetch data when the widget initializes
//   }
//
//   Future<void> _fetchData() async {
//     try {
//       final response = await http.get(
//         Uri.parse("http://192.168.0.193:3000/daily-data"),
//       );
//
//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData = json.decode(response.body);
//         final List<DailyData> data = jsonData.map((e) => DailyData(
//           day: e["day"],
//           litres: double.tryParse(e["litres"].toString()) ?? 0.0,
//         )).toList();
//
//         _seriesList = [
//           charts.Series<DailyData, int>(
//             id: 'Litres',
//             colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//             domainFn: (DailyData data, _) => data.day,
//             measureFn: (DailyData data, _) => data.litres,
//             data: data,
//           ),
//         ];
//       } else {
//         throw Exception("Failed to fetch data. Status code: ${response.statusCode}");
//       }
//     } catch (error) {
//       _errorMessage = "Error fetching data: ${error.toString()}"; // Set error message
//     } finally {
//       setState(() {
//         _isLoading = false; // Loading is complete
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _isLoading
//         ? const Center(child: CircularProgressIndicator()) // Display loading indicator
//         : _errorMessage.isNotEmpty // Display error message if there's an error
//         ? Center(child: Text(_errorMessage)) // Show the error message
//         : _seriesList.isNotEmpty // Ensure there's data to show
//         ? charts.LineChart(
//       _seriesList,
//       animate: true,
//       defaultRenderer: charts.LineRendererConfig(
//         includeArea: true,
//       ),
//       domainAxis: const charts.NumericAxisSpec(
//         tickProviderSpec: charts.StaticNumericTickProviderSpec(
//           [
//             charts.TickSpec(1, label: "Mon"),
//             charts.TickSpec(2, label: "Tue"),
//             charts.TickSpec(3, label: "Wed"),
//             charts.TickSpec(4, label: "Thu"),
//             charts.TickSpec(5, label: "Fri"),
//             charts.TickSpec(6, label: "Sat"),
//             charts.TickSpec(7, label: "Sun"),
//           ],
//         ),
//       ),
//       behaviors: [
//         charts.ChartTitle(
//           '',
//           behaviorPosition: charts.BehaviorPosition.top,
//           titleOutsideJustification: charts.OutsideJustification.start,
//         ),
//       ],
//     )
//         : const Center(child: Text("No data available")); // If there's no data
//   }
// }
//
// class IndividualProfile extends StatelessWidget {
//   final String name;
//   final String image;
//
//   const IndividualProfile({
//     Key? key,
//     required this.name,
//     required this.image,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(), // Use the custom AppBar
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 120),
//             child: Container(
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.0),
//                 image: DecorationImage(
//                   image: AssetImage(image), // Ensure the asset exists
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 15),
//           Text(
//             name,
//             style: const TextStyle(
//               color: Colors.black,
//               letterSpacing: 2,
//               fontSize: 25,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           const SizedBox(height: 20),
//           Expanded(
//             child: WeekWiseGraph(), // Graph with defined height
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       elevation: 0,
//       flexibleSpace: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//             colors: [
//               Color(0xFF9E12CF),
//               Color(0xFFEC01EC),
//             ],
//           ),
//         ),
//         child: const FlexibleSpaceBar(
//           title: Text(
//             'Track Daily Basis',
//             style: TextStyle(fontSize: 30, color: Colors.white, letterSpacing: 2),
//           ),
//           centerTitle: true,
//         ),
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
