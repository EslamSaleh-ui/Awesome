// ignore_for_file: use_build_context_synchronously
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome/constant/constant.dart';
import 'package:flutter_awesome/models/user.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as IO;
import 'dart:convert';

class create extends StatefulWidget{
  final User user;
  final String action;
  const create({this.user,@required this.action,Key key}) : super(key: key);
  @override
  State<create> createState() => _createState();
}

class _createState extends State<create>  with SingleTickerProviderStateMixin {
  AnimationController _controller1;
  GlobalKey<FormState> key=GlobalKey();
  @override
  void initState() {
    super.initState();
    _controller1=AnimationController(vsync: this,duration: const Duration(seconds: 10))..repeat();
      if(widget.user!=null)
        { tc1.text=widget.user.name;
          tc2.text=widget.user.job;
          tc3.text=widget.user.Address;
        path=widget.user.image;
        image=MemoryImage(base64Decode(path));}
  }
  @override
  void dispose() {
    _controller1.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Stack(children: [ AnimatedBuilder(animation: _controller1,builder: (context,child){
      return  Container(color: background2.evaluate(AlwaysStoppedAnimation(_controller1.value)),);
    }),     Scaffold(
        backgroundColor: Colors.transparent,
        body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>[
              SliverAppBar(centerTitle: true,
                  flexibleSpace:  Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[Colors.black,Colors.white ,Colors.blue]),
                      )), floating: true,
                  title:comp.shimmer([Colors.white,Colors.blueGrey,
                    Colors.blue,Colors.blueAccent,Colors.black], '${widget.action} User') )
            ], body:Form(
            key: key,
            child:SingleChildScrollView(child:  Column(
          children: [
            const Divider(height: 30,color: Colors.transparent),
            GestureDetector(onTap: ()async{
        try{ final f=await ImagePicker().getImage(source: ImageSource.gallery,imageQuality: 50);
          if(f !=null)
       { final rul=await f.readAsBytes();
         if(widget.action=='Update')
           {  final bytes=IO.File(path).readAsBytesSync();
            path=base64Encode(bytes);}
         else {
           path=f.path;}
        image= MemoryImage(rul);
       setState((){});
       }
        }
        on Exception catch(e)
        { if (kDebugMode) {
          print(e);
        }}
        }, child: comp.badge(context)),
            const Divider(height: 30,color: Colors.transparent),
            comp.Text_Field(tc1, TextInputType.name,' Enter Full Name'),
           comp.Text_Field(tc2, TextInputType.text,' Enter Job'),
            comp.Text_Field(tc3, TextInputType.text,' Enter Address'),
            const Divider(height: 60,color: Colors.transparent),
            ElevatedButton(onPressed: () async {
            if(key.currentState.validate())
           {if(widget.action=='Update')
             {await api.update_data({
               "id":widget.user.id,
               "name":tc1.text,
               "job":tc2.text,
               "Address":tc3.text,
             }, path);}else{
            await api.post_data({
                "name":tc1.text,
                "job":tc2.text,
                "Address":tc3.text,
              },path);}
            tc1.clear();tc2.clear(); tc3.clear();
             image=const AssetImage('assets/download.png');
               Navigator.of(context).pop();
            }}
                ,style: ElevatedButton.styleFrom(
                animationDuration: const Duration(milliseconds: 1000),
                backgroundColor: Colors.black,
                textStyle: const TextStyle(fontSize:25 ,color: Colors.white),
                minimumSize:  Size(MediaQuery.of(context).size.width/2, 50)
                ,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
            ), child: const Text('Save'))
          ]
        )) )
        ))
    ])
    );
  }
}