import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lengo/screen/admin_screen/show_questions_screen.dart';
import 'package:lengo/screen/admin_screen/view_admin_operation/view_delete_question.dart';


class ShowCategoreyToDeleteQuestionScreen extends StatelessWidget {
  const ShowCategoreyToDeleteQuestionScreen({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
       stream: FirebaseFirestore.instance.collection("Category").snapshots(),
       builder: (context, snapshot) {
         if(!snapshot.hasData)
         return Center(child: CircularProgressIndicator(),);
         return ListView(
           children: snapshot.data.docs.map((doc) {
             return Card(
               child: ListTile(
                 onTap: (){
                   Get.put(ViewDeleteQuestion());
                   Get.to(ShowQuestionsScreen(id: doc.id,));
                 },
                 leading: CircleAvatar(
                   radius: 24,
                   backgroundImage: NetworkImage(doc["image"]),                 
                 ),
                 title: Text(doc["name"].toString()),
               ),
             );
           }).toList(),
         );
       }, 
        ),
    );
  }
}