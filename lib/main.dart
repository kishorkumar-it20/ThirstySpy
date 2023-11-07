import 'package:flutter/material.dart';
import 'package:thirst_spy/first.dart';
void main()
{
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    )
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Image(image: AssetImage("assets/Frame 1.jpg")),
          const SizedBox(
            width: double.infinity,
          ),
          const Padding(
            padding: EdgeInsets.all(0.0),
            child: Text("Thirst spy",style: TextStyle(fontSize: 80,fontWeight: FontWeight.w300),),
          ),
          const Padding(
              padding: EdgeInsets.all(50),
              child: Text("Monitor Today and Live the life to the fullest", style: TextStyle(fontSize: 20))
          ),

          const SizedBox(
            height: 100,
            width: 150,
            child: CircleAvatar(
              radius: 500,
              backgroundImage: AssetImage("assets/logo.jpg"),
              backgroundColor: Colors.transparent,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 169,vertical: 110),
            child: SizedBox(
              height: 100,
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding:  const EdgeInsets.all(10),
                        child: ElevatedButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>  const FirstPage()));
                        },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            primary: Colors.lightBlueAccent,
                            padding: const EdgeInsets.all(20),
                          ),
                          child:const Icon(Icons.arrow_forward_rounded),
                        ),
                      ),
                    ],
                  ),
                  const Text("Start Monitoring")
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
