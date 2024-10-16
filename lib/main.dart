import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ANOTHER SIMPLE TIMER APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,


      ),
      home: const MyHomePage(title: 'ASTA - ANOTHER SIMPLE TIMER APP'),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int secondscounter=0;
  Duration duration = new Duration();
  Timer? timer;
  bool isRunning = false;
  bool isStopped = false;
  var inputtime = TextEditingController();

  void addTime(int usertime){
    final addSeconds = 1;
    if(secondscounter%(usertime)==0){
      final player = AudioPlayer();
      player.play(AssetSource('Ring.mp3'));
    }
    setState(() {
      int seconds = duration.inSeconds+addSeconds;
      duration = Duration(seconds: seconds);
      if (seconds<60) {
        secondscounter = seconds;
      }else{
        secondscounter = seconds%60;
      }

    });

  }
  void startTimer(int usertime){
    timer = Timer.periodic(Duration(seconds: 1), (_){addTime(usertime);});
    print("Start Timer Called");
  }

  void stopTimer(){
    setState(() {
      timer?.cancel();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),


      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("${duration.inHours}:${duration.inMinutes}:$secondscounter", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),),
              Text("Time to beep (in Secs)", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w200),),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 60,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                          )
                      )
                  ),
                  controller: inputtime,

                ),
              ),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: (){
                    int usertime = int.parse(inputtime.text.toString());
                    startTimer(usertime);
                  }, child: Text(isRunning?"Resume":"Start")),
                  SizedBox(width: 11),
                  ElevatedButton(onPressed: (){
                    stopTimer();
                    isStopped = true;
                    setState(() {
                      if(secondscounter > 0 && isStopped){
                        isRunning = true;
                      }
                    });

                  }, child: Text("Stop")),
                ],
              ),
              ElevatedButton(onPressed: (){
                setState(() {
                  timer?.cancel();
                  duration = Duration();
                  secondscounter = 0;
                  isRunning = false;
                });
              }, child: Text("Reset")),
              SizedBox(height: 50,),
              Text("Made with ❤️ by Subhendu"),
              Container(
                child: Text("V 1.0"),
              ),
            ],
          ),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
