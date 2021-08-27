import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lengo/screen/admin_screen/add_categorey.dart';
import 'package:lengo/screen/admin_screen/show_categories.dart';
import 'package:lengo/screen/admin_screen/show_category_to_delete_question.dart';
import 'package:lengo/utils/firebase-manager.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
         FirebaseManger().logout(context);
        },
        child: Icon(Icons.logout),
      ),
     body: Column(
       children: [
         const SizedBox(height: 40,),
         Card(
           child: ListTile(   
             title: Row(
               children: [
                 Icon(Icons.add),
                 const SizedBox(width: 12,),
                 Text("Add Categorey"),
               ],
             ),
             onTap: (){
               Navigator.push(context,
               MaterialPageRoute(builder: (_)=> AddCategorey()));
             },
           ),
         ),
         const SizedBox(height: 12,), 
         Card(
           child: ListTile(   
             title: Row(
               children: [
                 Icon(Icons.add),
                 const SizedBox(width: 12,),
                 Text("Add Question"),
               ],
             ),
             onTap: (){
             Get.to(ShowCatergoriesScreen());
             },
           ),
         ),
         const SizedBox(height: 12,), 
         Card(
           child: ListTile(   
             title: Row(
               children: [
                 Icon(Icons.edit),
                 const SizedBox(width: 12,),
                 Text("Update Or Delete Question"),
               ],
             ),
             onTap: (){
               
               Get.to(ShowCategoreyToDeleteQuestionScreen());
             },
           ),
         )
       ],
     ),
    );
  }
}