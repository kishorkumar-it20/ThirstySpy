import 'package:flutter/material.dart';
import 'package:thirstspyfront/Dailybasis.dart';
import 'package:thirstspyfront/home_applicancetrack.dart';

class GradientBorderContainer extends StatelessWidget {
  final Gradient gradient;
  final Widget child;
  final VoidCallback? onTap;

  GradientBorderContainer({
    required this.gradient,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(12),
          gradient: gradient,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(8),
          child: child,
        ),
      ),
    );
  }
}

class WaterConsumptionGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      mainAxisSpacing: 10,
      crossAxisCount: 1,
      children: <Widget>[
        GradientBorderContainer(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFF9E12CF),
              Color(0xFFEC01EC),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/ind.png', // Path to your image asset
                height: 100,
              ),
              const SizedBox(height: 10),
              const Text("Individual Consumption", style:TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontSize: 18
              ),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const DailyBasis()));
          },
        ),
        GradientBorderContainer(
          gradient: const  LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFF9E12CF),
              Color(0xFFEC01EC),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/House.png', // Path to your image asset
                height: 100,
              ),
              const SizedBox(height: 10),
              const Text("Home Appliances Consumption",
                  style:TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      fontSize: 18
                  )
              ),
            ],
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeAppliance()));
          },
        ),
      ],
    );
  }
}

class Track extends StatelessWidget {
  const Track({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: CustomAppBar(),
      ),
      body: WaterConsumptionGrid(),
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
            colors: [Color(0xFF9E12CF), Color(0xFFEC01EC)],
          ),
        ),
        child: const FlexibleSpaceBar(
          title: Text(
            'Select Water Consumption Type',
            style: TextStyle(fontSize: 24, color: Colors.white, letterSpacing: 2),
          ),
          centerTitle: true,
        ),
      ),
    );
  }
}
