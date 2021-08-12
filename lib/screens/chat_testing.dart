import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatTesting extends StatefulWidget {
  const ChatTesting({Key? key}) : super(key: key);

  @override
  _ChatTestingState createState() => _ChatTestingState();
}

class _ChatTestingState extends State<ChatTesting> {

  Future<void> _askedToLead() async {
    await showDialog<Department>(
        context: context,barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select assignment'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () { Navigator.pop(context, Department.treasury); },
                child: const Text('Treasury department'),
              ),
              SimpleDialogOption(
                onPressed: () { Navigator.pop(context, Department.state); },
                child: const Text('State department'),
              ),
            ],
          );
        }
    );
    // {
    //   case Department.treasury:
    //   // Let's go.
    //   // ...
    //     break;
    //   case Department.state:
    //   // ...
    //     break;
    //   case null:
    //   // dialog dismissed
    //     break;
    // }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {},
              child: Icon(Icons.check),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.height),
              color: Colors.red,
              // disabledColor: Colors.green,
              // focusColor: Colors.blue,
              highlightColor: Colors.orangeAccent,
              // hoverColor: Colors.deepPurple,
              splashColor: Colors.tealAccent,
            )
          ],
          leading: Icon(Icons.arrow_back),
          title: Text('ChatSettings'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),
            ),
          ),
          elevation: 10.0,
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(10.0))),
          automaticallyImplyLeading: false,
          actionsIconTheme:
              IconThemeData(size: 30.0, color: Colors.black, opacity: 10.0),
        ),
        body: Column(children: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: null,
            child: const Text('Disabled'),
          ),
          const SizedBox(height: 30),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {_askedToLead(); },
            child: const Text('Enabled'),
          ),
          const SizedBox(height: 30),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {},
                  child: const Text('Gradient'),
                ),
              ],
            ),
          )
        ]));
  }
}
class Department{
  static const int treasury = 0;
  static const int state = 1;
}
