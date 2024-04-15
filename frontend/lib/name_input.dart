import 'package:flutter/material.dart';
import 'package:frontend/chat_page.dart';
import 'package:toastification/toastification.dart';

class NameInput extends StatelessWidget {
  const NameInput({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: nameController,
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
              label: const Text("Enter Name"),
              // labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          MaterialButton(
            color: Colors.teal.shade100,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: () {
              if (nameController.text.isEmpty) {
                errorToast(context);
              }else{
 Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen(
                            userName: nameController.text,
                          )));
              }
             
            },
            child: const Text(
              "Enter Chat-room",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    ));
  }

  errorToast(BuildContext context) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 5),
      title: const Text('Error'),
      // you can also use RichText widget for title and description parameters
      description: RichText(
          text: const TextSpan(text: 'User name cannot be empty!!')),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),

      icon: const Icon(Icons.error),
      primaryColor: Colors.red,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
    );
  }
}
