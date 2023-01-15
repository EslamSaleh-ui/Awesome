import 'package:flutter/material.dart';
import 'package:flutter_awesome/widgets/fetch.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Lottie.asset('assets/9465-sdkapi.json',height: MediaQuery.of(context).size.height/2,
                  fit: BoxFit.fill,width: MediaQuery.of(context).size.width) ,
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(PageTransition(childCurrent:const MyHomePage() ,
                 duration: const Duration(milliseconds: 500) ,  child: fetch(),
                    curve: Curves.easeInCirc,
                    type:PageTransitionType.bottomToTopPop ));
              },style: ElevatedButton.styleFrom(
                animationDuration: const Duration(milliseconds: 1000),
                  backgroundColor: Colors.lightBlue,
                  shadowColor: Colors.lightBlueAccent,
                  textStyle: const TextStyle(fontSize:25 ,color: Colors.white),
                  maximumSize:  Size(MediaQuery.of(context).size.width, 200)
                  ,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
              ), child: const Text('Get Started'))       ]
        )
    );
  }  }