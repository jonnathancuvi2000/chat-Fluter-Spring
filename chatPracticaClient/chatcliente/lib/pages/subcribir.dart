import 'dart:convert';

import 'package:chatcliente/datos.dart';
import 'package:chatcliente/pages/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

// use this if you are using emulator. localhost is mapped to 10.0.2.2 by default.
final socketUrl = 'http://localhost:8080/ws';

class Subcribir extends StatefulWidget {
  const Subcribir({super.key});

  @override
  State<Subcribir> createState() => _SubcribirState();
}

class _SubcribirState extends State<Subcribir> {
  TextEditingController _name = TextEditingController();

  StompClient? stompClient;

  String message = '';

  var chatMessage = {"senderName": "juan", "status": "JOIN"};
  void onConnect( StompFrame frame) {
    print("como");
    stompClient?.subscribe(
      destination: '/chatroom/public',
      callback: (StompFrame frame) {
        if (frame.body != null) {
          print(frame.body);
          print("FUnciona");
          // Map<String, dynamic> result = json.decode(frame.body);
          //print(result['message']);
          // setState(() => message = result['message']);
        }
      },
    );
    stompClient?.send(destination: '/app/message', body: jsonEncode(chatMessage));
  }

  @override
  void initState() {
    super.initState();
    print("hola");
    stompClient = StompClient(
      config: StompConfig.SockJS(
        url: socketUrl,
        onConnect: (p0) => onConnect(p0),
        // onConnect: (p0) => onConnect,
        onWebSocketError: (dynamic error) => print(error.toString()),
      ),
    );

    // stompClient.activate();
    stompClient!.activate();
  }

  @override
  void dispose() {
    if (stompClient != null) {
      stompClient!.deactivate();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _name,
              decoration: InputDecoration(
                hintText: "Su nombre",
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                    borderSide: BorderSide(color: Colors.grey)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                    borderSide: BorderSide(color: Colors.grey.shade400)),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {},
                  child: Text('Conectar'),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {},
                  child: Text('Desconectar'),
                ),
              ],
            ),
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 246, 247, 253),
                        border: Border.all(
                            color: const Color.fromARGB(255, 177, 178, 180),
                            width: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // color: Color.fromARGB(255, 246, 247, 253),
                      child: Center(child: Text("Hola")),
                    ),
                  ),
                  Row(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
