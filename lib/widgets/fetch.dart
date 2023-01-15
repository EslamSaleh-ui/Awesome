// ignore_for_file: missing_return
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_awesome/constant/constant.dart';
import 'package:flutter_awesome/models/user.dart';
import 'package:flutter_awesome/widgets/create.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:page_transition/page_transition.dart';
import 'package:easy_refresh/easy_refresh.dart';

class fetch extends StatefulWidget{

  @override
  State<fetch> createState() => fetchState();
  }

  class fetchState extends State<fetch>  with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller=AnimationController(vsync: this,duration: const Duration(seconds: 10))..repeat();}
@override
  void dispose() {
   _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
        Stack(children: [ AnimatedBuilder(animation: _controller,builder: (context,child){
          return  Container(color: background.evaluate(AlwaysStoppedAnimation(_controller.value)),);
        }),     Scaffold(
          backgroundColor: Colors.transparent,
        body:EasyRefresh(onRefresh: (){setState(() {});},
            child:  NestedScrollView(
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
                    Colors.blue,Colors.blueAccent,Colors.black], 'Home Page') )
            ], body:FutureBuilder(
            future:api.fetch_data() ,
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting) {
                return  const Center(child: CircularProgressIndicator());
              }else if(snapshot.hasError)
              { return  Center(child: comp.shimmer([Colors.red,
                Colors.redAccent,Colors.black], 'SomeThing Went Error'));   }
              else if(!snapshot.hasData) {
                return  Center(child: comp.shimmer( [Colors.greenAccent,
                  Colors.green,Colors.black],'No Data Found'),
                );
              }
              List<dynamic> details=snapshot.data as  List<dynamic>;
              return  Padding(padding: const EdgeInsets.symmetric(vertical: 10),child:
                ReorderableListView(onReorder: (first,second)async{
                User user1=User.fromMap( details.elementAt(first==details.length?first-1:first));
                User user2=User.fromMap( details.elementAt(second==details.length?second-1:second));
                await api.Swipe(user1, user2);
                setState(() {});
              }, children: details.map((e) {
                User user=User.fromMap(e);
                return  Slidable(
                    key: ValueKey(user.id),
                    enabled: true,
                    endActionPane: ActionPane(motion: const ScrollMotion(), children: [
                      SlidableAction(
                          onPressed: (context)async{ await api.delete_data(e['id'].toString());
                            setState(() {});},
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete')
                    ]),startActionPane:ActionPane(motion: const ScrollMotion(), children: [
                  SlidableAction(
                      onPressed: (context){Navigator.of(context).push(PageTransition(childCurrent: fetch() ,
                          duration: const Duration(milliseconds: 500) ,  child:  create(action: 'Update',
                          user: user),
                          curve: Curves.easeInCirc,
                          type:PageTransitionType.bottomToTopPop ));},
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      icon: Icons.update,
                      label: 'Update')
                ]) , child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration:BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.circular(15)) ,
                    constraints:const BoxConstraints(maxHeight:double.infinity ) ,
                    child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                             comp.text_span('Name: ', user.name),
                              comp.text_span('Job: ', user.job),
                              comp.text_span('Address: ', user.Address)
                            ]
                          ), Container(height:50 ,
                              width: 50, decoration: BoxDecoration(
                            shape:BoxShape.circle ,
                            image: DecorationImage(image:user.image==" "? const AssetImage('assets/download.png'):
                            MemoryImage(base64Decode(user.image))
                                ,fit: BoxFit.fill),
                          ))
                        ]))  );
              }).toList(),
                ));
            })
        )),floatingActionButton:  FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: (){  Navigator.of(context).push(PageTransition(childCurrent: fetch() ,
              duration: const Duration(milliseconds: 500) ,  child: const create(action: 'Create'),
              curve: Curves.easeInCirc,
              type:PageTransitionType.bottomToTopPop ));},
          child: const Icon(Icons.add)
        ))
        ])
  );
  }   }