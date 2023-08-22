import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';


class DemoApp extends StatefulWidget{
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  var  selectedfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:const Text("Share Text, URL, Image or File"),
          backgroundColor: Colors.redAccent,
        ),
        body: Column(

          children: [
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: (){
                    Share.share('Hello Welcome to FlutterCampus', subject: 'Welcome Message');
                    //subject is optional, and it is required for Email App.
                  },
                  child: const Text("Share Plain Text")),
            ),

            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: ()async{
                   await Share.share('Visit FlutterCampus at https://www.fluttercampus.com');
                  },
                  child: const Text("Share text with URL")),
            ),

            // Container(
            //   alignment: Alignment.center,
            //   child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(primary: Colors.redAccent),
            //       onPressed: () async {
            //         selectedfile = await FilePicker.getFile(
            //           type: FileType.custom,
            //           allowedExtensions: ['jpg', 'pdf', 'mp4'],
            //           //allowed extension to choose
            //         );
            //
            //         setState((){});
            //       },
            //       child: Text("Pick File to Share")),
            // ),

            Container(
              alignment: Alignment.center,
              child: Text(selectedfile == null?"No File Selected":selectedfile.path),
            ),


            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                  onPressed: () async {
                    if(selectedfile == null){
                      print("No any file is selected.");
                    }else{
                      Share.shareFiles([selectedfile.path], text: "View File");
                    }

                    setState((){});
                  },
                  child: const Text("Share Picked File")),
            ),


          ],
        )
    );
  }
}