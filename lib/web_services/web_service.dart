// ignore_for_file: camel_case_types, non_constant_identifier_names
import 'dart:convert';
import 'dart:io' as IO;
import 'dart:math';
import 'package:flutter_awesome/models/user.dart';
import 'package:http/http.dart' as http;

class web_service{
  
Future<List<dynamic>> fetch_data()async {
  final result=await http.get(Uri.parse('http://10.0.2.2:3000/users_1'));
  if(result.statusCode==200) {
    return json.decode(result.body);
  } else {
    throw Exception('No data Found');
  }  }
Future<String> delete_data(String id)async {
  final result=await http.delete(Uri.parse('http://10.0.2.2:3000/users_1/$id'));
  if(result.statusCode==200) {
    return 'done';
  } else {
    throw Exception('some thing went error');
  }  }
Future<String> post_data(Map<String,dynamic> user,String path)async {
  String id=Random().nextInt(1000).toString();
  final bytes=IO.File(path).readAsBytesSync();
  String img64=base64Encode(bytes);
  final result1=await http.post(Uri.parse('http://10.0.2.2:3000/users_1'),body:
 {
   "id":id,
   "name":user["name"],
   "job":user["job"],
   "Address":user["Address"],
   "image":img64
 });
  if(result1.statusCode==201 ) {
    return 'done';
  } else {
    throw Exception('some thing went error');
  }
}
Future<String> update_data(Map<String,dynamic> user,String path)async {

  final result1=await http.put(Uri.parse('http://10.0.2.2:3000/users_1/${user['id']}'),body:
  {
    "name":user["name"],
    "job":user["job"],
    "Address":user["Address"],
    "image":path
  });
  if(result1.statusCode==200 ) {
    return 'done';
  } else {
    throw Exception('some thing went error');
  }
}
Future<String> Swipe(User user1,User user2)async {
  final result1=await http.put(Uri.parse('http://10.0.2.2:3000/users_1/${user2.id}'),
      body: {
    "name":user1.name,
     "job":user1.job,
     "Address":user1.Address,
     "image":user1.image},
      encoding: Encoding.getByName('utf-8'));
  final result2=await http.put(Uri.parse('http://10.0.2.2:3000/users_1/${user1.id}'),
      body: {
        "name":user2.name,
        "job":user2.job,
        "Address":user2.Address,
        "image":user2.image},
      encoding: Encoding.getByName('utf-8'));
  if(result1.statusCode==200 && result2.statusCode==200) {
    return 'done';
  } else {
    throw Exception('some thing went error');
  }  }
}