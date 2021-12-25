import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:text_recognition_ocr/Screens/Compounent/Const.dart';
import 'package:text_recognition_ocr/Screens/HomeScreen/HomeScreen.dart';

class DetailsScreen extends StatefulWidget {
  String extractedText = '';
  DetailsScreen({Key? key, required this.extractedText}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('your Text '.toUpperCase()),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SelectableText(
                widget.extractedText,
                style: const TextStyle(fontSize: 15),
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: IconButton(
                  onPressed: () {
                    FlutterClipboard.copy(widget.extractedText);
                  },
                  icon: const Icon(
                    Icons.copy,
                    size: 30,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  image = null;
                  imagePicked = false;

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  }));
                },
                child: const Text(
                  'Back To Home Page',
                  style: TextStyle(fontSize: 17),
                ),
                style: ElevatedButton.styleFrom(
                  primary: kDefaultColor,
                  fixedSize: const Size(300, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
