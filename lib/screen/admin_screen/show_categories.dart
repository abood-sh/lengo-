import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lengo/screen/admin_screen/add_question_screen.dart';
import 'package:lengo/screen/admin_screen/view_admin_operation/auth_operation_admin.dart';

class ShowCatergoriesScreen extends StatelessWidget {
  const ShowCatergoriesScreen({ Key key }) : super(key: key);

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
                   Get.put(AuthOperationAdmin());
                   Get.to(AddQuestionScreen(docId: doc.id,));
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