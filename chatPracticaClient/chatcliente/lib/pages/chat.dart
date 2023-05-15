import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class Chat extends StatefulWidget {
  final String text;
  const Chat({super.key, required this.text});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  StompClient? client;
  var userData = {
    "username": '',
    "receivername": '',
    "connected": false,
    "message": ''
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // connect();
    onConnect();
  }

  StompClient? stompClient;
  final socketUrl = 'http://localhost:8080/ws';

  void onConnect() {
    client!.subscribe(
        destination: '/chatroom/public',
        callback: (StompFrame frame) {
          if (frame.body != null) {}
        });
    client!.send(destination: '/app/message', body: "dimuthu");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Atras"),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  child: Container(),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Escriba aqui ...",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100.0),
                                borderSide: BorderSide(color: Colors.grey)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100.0),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.teal,
                        radius: 25,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.send),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
