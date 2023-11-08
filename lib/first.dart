import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:table_calendar/table_calendar.dart';

class DataItem {
  final DateTime date;
  final String name;
  final String litre;

  DataItem(this.date, this.name, this.litre);
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  CalendarFormat format = CalendarFormat.week;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  late DateTime _selectedDate;
  List<DataItem> _dataItems = [];

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    fetchDataFromMongo().then((data) {
      setState(() {
        _dataItems = data;
      });
    }).catchError((error) {
      print("Error fetching data from MongoDB: $error");
    });
  }

  Future<List<DataItem>> fetchDataFromMongo() async {
    try {
      final db = mongo.Db(" ");
      await db.open();

      final collection = db.collection('People');
      final data = await collection.find().toList();

      await db.close();

      return data.map((item) {
        return DataItem(
          DateTime.parse(item['Date']),
          item['name'],
          item['litre'],
        );
      }).toList();
    } catch (e) {
      // Handle any exceptions that may occur during the database operation
      print("Error fetching data: $e");
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Start Monitoring"),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        actions: const [
          Padding(
            padding: EdgeInsets.all(10),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/profile11.jpg"),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _selectedDate,
            firstDay: DateTime(2023),
            lastDay: DateTime(2090),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
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
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.0),
              ),
              selectedTextStyle: const TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Colors.cyan,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(10.0),
              ),
              formatButtonTextStyle: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _buildDataDisplay(),
          ),
        ],
      ),
    );
  }

  Widget _buildDataDisplay() {
    if (_dataItems.isEmpty) {
      return const Center(child: Image(image: AssetImage("assets/no-data.png")));
    }

    // Display the fetched data
    return ListView.builder(
      itemCount: _dataItems.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Card(
            color: Colors.cyan,
            child: ListTile(
              title: Text(_dataItems[index].name, style: const TextStyle(fontSize: 18)),
              subtitle: Text(_dataItems[index].litre),
              leading: const Icon(Icons.account_circle_rounded, size: 40),
              iconColor: Colors.black,
            ),
          ),
        );
      },
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    ),
  );
}
