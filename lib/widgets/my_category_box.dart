import 'package:flutter/material.dart';

class MyCategoryBox extends StatelessWidget {
  
  String title;
  String subtitle;
  String imagePath;

  MyCategoryBox({
    @required this.title,
    this.subtitle,
    @required this.imagePath}); // MyCategoryBox(this.title, this.subtitle, this.image);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Material(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          height: width*0.5,
          // width: width*0.45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[100],
            // border: Border.all(color: Colors.grey),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: width*0.35,
                  width: width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      topLeft: Radius.circular(10.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Image.network(imagePath,)),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 10,top: 5),
                child: Text(title,style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            )

            ],
          ),
        ),
      ),
    );
  }
}
