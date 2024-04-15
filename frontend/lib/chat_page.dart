import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:socket_io_client/socket_io_client.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  const ChatScreen({required this.userName, super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    // TODO: implement initState

    connectToSocket();
    super.initState();
  }

  final socketUrl = "";
  late io.Socket socket;
  TextEditingController messageController = TextEditingController();
  List<String> messages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        TextFormField(
          controller: messageController,
          // onChanged: onSearchTextChanged,
          // cursorColor: Colors.grey,r
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none),
              isDense: true,
              // fillColor: TextfieldColor,
              filled: true,
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              label: const Text("Message"),
              // labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
              suffixIcon: IconButton(
                  onPressed: () {
                    sendMessage();
                  },
                  icon: const Icon(Icons.send))),
        ),
      ],
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Anonymous Group Chat".toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Icons.groups_2_outlined,
              size: 50,
            ),
          ],
        ),
        const Divider(),
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height * 0.7,
          child: ListView.separated(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(tileColor: Colors.teal.shade100,
                      leading: Text(messages[index]),
                      trailing: Text(
                          DateFormat.Hms().format(DateTime.now()).toString()),
                    ),
              ),
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10,);
              },
              itemCount: messages.length),

          // ListView(
          //   children: messages.map(
          //     (e) {
          //       return
          //     },
          //   ).toList(),
          // ),
        )
      ]),
    );
  }

  void sendMessage() {
    socket.emit("chat", "${widget.userName} : ${messageController.text}");
    //  messages.add(messageController.text);
    messageController.clear();
    setState(() {});
  }

  void connectToSocket() {
    log("object");
    // Replace 'https://your_socket_server_url' with the URL of your Socket.IO server.
    socket = io.io(
        'http://127.0.0.1:5000/',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());

    socket.connect();

    socket.onConnect((_) {
      print('Connected to the socket server');
    });

    socket.onDisconnect((_) {
      print('Disconnected from the socket server');
    });

    socket.on('chat', (data) {
      messages.add(data);
      setState(() {});
      print('Received message: $data');
    });

    // Add more event listeners and functionality as needed.

    // To send a message to the server, use:
    // socket.emit('eventName', 'message data');
  }
}
