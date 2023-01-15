import 'package:flutter/material.dart';
import 'package:flutter_awesome/components/components.dart';
import 'package:flutter_awesome/web_services/web_service.dart';

final api=web_service();
final comp=Component();
final tc1=TextEditingController();
final tc2=TextEditingController();
final tc3=TextEditingController();
String path='';
ImageProvider image=const AssetImage('assets/download.png');
Animatable<Color> background=TweenSequence<Color>([
  TweenSequenceItem(tween:ColorTween(
    begin: Colors.red,
    end: Colors.green
  ) , weight: 1.0),
  TweenSequenceItem(tween:ColorTween(
      begin: Colors.green,
      end: Colors.blue
  ) , weight: 1.0), TweenSequenceItem(tween:ColorTween(
      begin: Colors.blue,
      end: Colors.pink
  ) , weight: 1.0)
]);
Animatable<Color> background2=TweenSequence<Color>([
  TweenSequenceItem(tween:ColorTween(
      begin: Colors.redAccent,
      end: Colors.yellowAccent
  ) , weight: 1.0),
  TweenSequenceItem(tween:ColorTween(
      begin: Colors.deepPurple,
      end: Colors.blueAccent
  ) , weight: 1.0), TweenSequenceItem(tween:ColorTween(
      begin: Colors.blue,
      end: Colors.pinkAccent
  ) , weight: 1.0)
]);