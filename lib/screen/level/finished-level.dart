import 'package:flutter/material.dart';
import 'package:lengo/model/category-model.dart';
import 'package:lengo/widgets/btn-main.dart';
import 'package:lengo/utils/extensions.dart';

class FinishedLevel extends StatelessWidget {

  final CategoryModel categoryModel;

  const FinishedLevel({Key key, this.categoryModel}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                width: MediaQuery.of(context).size.width * (224 / 375),
                height: MediaQuery.of(context).size.width * (224 / 375),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Image.network(categoryModel.image, fit: BoxFit.cover,),
              ),
              SizedBox(height: 20),
              Icon(Icons.check, color: Theme.of(context).primaryColor, size: 62,),
              SizedBox(height: 35),
              Text("${categoryModel.name} level ${categoryModel.currentlyLevel != null ? categoryModel.currentlyLevel + 1 : 1} completed!", style: TextStyle(color: "#333333".toHexa(), fontSize: 19),),
              SizedBox(height: MediaQuery.of(context).size.height * (77 / 812)),
              BtnMain(title: "Continue", onTap: () => Navigator.of(context).pop()),
            ],
          ),
        ),
      ),
    );
  }
}
