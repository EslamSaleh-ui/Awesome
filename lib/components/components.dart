import 'package:flutter_awesome/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:badges/badges.dart';

class Component {
  Widget shimmer(List<Color> colors,String child){
    return  Shimmer(gradient:LinearGradient(
    begin:Alignment.topLeft ,
  end: Alignment.bottomRight,
  colors: colors
  ) , enabled: true, period: const Duration(milliseconds: 2000),child: Text(child),
  );
  }
 Widget Text_Field(TextEditingController tec,TextInputType tit,String ht){
    return Padding(padding: const EdgeInsets.only(top: 10,left: 5,right: 5,bottom: 5),child:TextFormField(
        controller: tec,
        keyboardType: tit,
        validator:(f){
          if( f.isEmpty) {
            return 'This Field is needed';
          }
          return null;
        } ,
        strutStyle: const StrutStyle(height: 3)
        ,autovalidateMode:AutovalidateMode.onUserInteraction  ,
        style:const TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w500,decoration: TextDecoration.underline) ,
        decoration: InputDecoration(hintText :ht,
            filled: true,
            alignLabelWithHint: false,
            contentPadding: const EdgeInsets.all(9),
            fillColor: Colors.white,
            hintStyle:const TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w500) ,
            enabledBorder:OutlineInputBorder(borderSide:const BorderSide(width: 1.5,color: Colors.blue),borderRadius: BorderRadius.circular(10))
            , focusedErrorBorder: OutlineInputBorder(borderSide:const BorderSide(width: 0.5,color: Colors.red),borderRadius: BorderRadius.circular(10) )
            ,errorBorder:OutlineInputBorder(borderSide:const BorderSide(width: 0.5,color: Colors.red),borderRadius: BorderRadius.circular(10) )
            ,focusedBorder: OutlineInputBorder(borderSide:const BorderSide(width: 1.5,color: Colors.black),borderRadius: BorderRadius.circular(10) ))
    ));
 }
 Widget badge(BuildContext context)
 {
   return Badge(alignment:AlignmentDirectional.topEnd,badgeColor: Colors.blue,badgeContent: const Icon(Icons.add,color: Colors.white),
       child:Container(height:(MediaQuery.of(context).size.height/10)+5 ,width:  (MediaQuery.of(context).size.width/10)+30
           ,decoration: BoxDecoration(color:Colors.redAccent ,shape: BoxShape.circle, image: DecorationImage(image:image ,fit: BoxFit.fill)  ))  );
 }
 Widget text_span(String first,String second)
  {
    return  Text.rich(TextSpan(children: [
       TextSpan(text:first,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w900) ),
      TextSpan(text:second,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w400) ),
    ]));
  }
}