import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeAppliance extends StatelessWidget {
  CalendarFormat format = CalendarFormat.month;
  late DateTime _selectedDate = DateTime.now();
  late DateTime focusedDay = DateTime.now();
  HomeAppliance({super.key});

  @override
  Widget build(BuildContext context) {
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
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,
            selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
            onDaySelected: (selectedDay, focusedDay) {
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
            child:
                 Center(child: Image.asset("assets/no-data.png"),)

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
            style: TextStyle(fontSize: 24, color: Colors.white, letterSpacing: 2),
          ),
          centerTitle: true,
        ),
      ),
    );
  }
}