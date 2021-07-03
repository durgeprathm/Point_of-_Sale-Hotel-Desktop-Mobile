import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:translator/translator.dart';

import 'dashboard.dart';

class LangChange extends StatefulWidget {
  @override
  _LangChangeState createState() => _LangChangeState();
}

class _LangChangeState extends State<LangChange> {
  @override
  Widget build(BuildContext context) {
    void handleClick(String value) {
      switch (value) {
        // case 'Add Printer':
        //   Navigator.push(context,
        //       MaterialPageRoute(
        //           builder: (context) => AddSales()));
        //   break;
        // case 'Profile':
        //   Navigator.push(context, MaterialPageRoute(
        //       builder: (context) => ViewNotes(widget.DBNAME, widget.EID)
        //   ));
        //   break;
        // case 'Forget Password':
        //   Navigator.push(context, MaterialPageRoute(
        //       builder: (context) => ViewNotes(widget.DBNAME, widget.EID)
        //   ));
        //   break;

      }
    }

    GoogleTranslator translator = GoogleTranslator();
    String text = "How Are you";
    void translate() {
      translator.translate(text, to: "hi").then((value) {
        setState(() {
          text = value as String;
        });
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.user),
            SizedBox(
              width: 20.0,
            ),
            Text('Language Change'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return RetailerHomePage();
              }));
            },
          ),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Manage Purchase',
                'Import Purchase',
                'Add Supplier',
                'Manage Suppliers',
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            RaisedButton(onPressed: () {
              setState(() {});
            }),
          ],
        ),
      ),
    );
  }
}
