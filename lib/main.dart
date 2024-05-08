import 'package:flutter/material.dart';
import 'package:thirstspyfront/Dailybasis.dart';
import 'package:thirstspyfront/Track_file.dart';

void main()
{
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    )
  );
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.bottomLeft,
            end: FractionalOffset.topCenter,
            colors: [
              Color(0xFFEC01EC),
              Color(0xFF9E12CF),
            ],
          ),
        ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start, // Align content in the center
          children: [
            const SizedBox(height: 260,),
            const Text(
              'THIRST-SPY',
              style: TextStyle(color: Colors.white, fontSize: 30.0,letterSpacing: 2),
            ),
            const SizedBox(height: 40,),
            const Text("Monitor today and live the",style: TextStyle(color: Colors.white70,fontSize: 20,letterSpacing: 1),),
            const SizedBox(height: 10,),
            const Text("life to the fullest",style: TextStyle(color: Colors.white70,fontSize: 20,letterSpacing: 1),),
            const SizedBox(height: 100,),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0.5),
                borderRadius: BorderRadius.circular(100.0)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Transform.translate(
                  offset: const Offset(-2.0, 10.0),
                  child: Image.asset(
                    'assets/Group 1.png'
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            SizedBox(
              height: 70,
              width: 380,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Track()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFECC1EC),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(color: Color(0xFF4301AC), letterSpacing: 1,fontSize: 25,fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
