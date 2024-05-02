import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:thirstspyfront/Individual%20Data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataItems {
  final String name;
  final String image;
  final String date;
  final String litre;

  DataItems({
    required this.name,
    required this.image,
    required this.date,
    required this.litre,
  });
}

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DailyBasis(),
    ),
  );
}

class DailyBasis extends StatefulWidget {
  const DailyBasis({Key? key}) : super(key: key);

  @override
  State<DailyBasis> createState() => _DailyBasisState();
}

class _DailyBasisState extends State<DailyBasis> {
  CalendarFormat format = CalendarFormat.month;
  late DateTime _selectedDate = DateTime.now();
  late DateTime focusedDay = DateTime.now();
  List<DataItems> data = [];

  List<DataItems> getDataForSelectedDate(DateTime selectedDate) {
    return data.where((item) => item.date == _formatDate(selectedDate)).toList();
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
  Future<void> fetchData() async{
    try{
      final response = await http.get(Uri.parse("http://192.168.0.193:3000/peopledata"));
      if(response.statusCode == 200)
        {
          print("Response Success");
          final List<dynamic> jsondata =json.decode(response.body);
          final List<DataItems> fetchedData =jsondata.map((e) =>
              DataItems(name: e['name'], image: e['image'], date: e['date'], litre: e['litre']),
          ).toList();
          setState(() {
            data = fetchedData;
          });
        }
      else {
        print('Received status code: ${response.statusCode}');
        throw Exception(const AssetImage("assets/no-data.png"));
      }
    }catch(error){
      const AssetImage("assets/no-data.png");
    }
  }


  @override
  void initState(){
    super.initState();
    late DateTime _selectedDay;
    _selectedDay = DateTime.now();
    fetchData();
  }
  Widget build(BuildContext context) {
    List<DataItems> selectedData = getDataForSelectedDate(_selectedDate);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: CustomAppBar(),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _selectedDate,
            firstDay: DateTime(2023),
            lastDay: DateTime(2090),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat format) {
              setState(() {
                format = format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,
            selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
              });
            },
            calendarStyle: const CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.green,
                    Colors.black,
                  ],
                ),
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF9E12CF),
                    Color(0xFFEC01EC),
                  ],
                ),
                shape: BoxShape.circle,

              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF9E12CF),
                    Color(0xFFEC01EC),
                  ],
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              formatButtonTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: selectedData.isEmpty
                ? Center(child: Image.asset("assets/no-data.png"),)
                : ListView(
              children: getDataForSelectedDate(_selectedDate).map((item) {
                return GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => IndividualProfile(
                    //       name: item.name,
                    //       image: item.image,
                    //     ),
                    //   ),
                    // );
                  },
                  child: Container(
                    height: 80, // Set the height of each item as needed
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF9E12CF),
                          Color(0xFFEC01EC),
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(item.image),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.name,
                              style:const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Litre: ${item.litre}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFF9E12CF),
              Color(0xFFEC01EC),
            ], // Adjust colors as per your preference
          ),
        ),
        child: const FlexibleSpaceBar(
          title: Text(
            'Track Daily Basis',
            style: TextStyle(fontSize: 30, color: Colors.white, letterSpacing: 2),
          ),
          centerTitle: true,
        ),
      ),
    );
  }
}
