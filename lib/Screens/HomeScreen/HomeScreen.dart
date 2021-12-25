import 'dart:io';

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:text_recognition_ocr/Screens/Compounent/Const.dart';
import 'package:text_recognition_ocr/Screens/DetailsScreen/DetailsScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final picker = ImagePicker();

  String extractedText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text From Images'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.89,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              !imagePicked
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 350,
                        child: Image(
                          image:
                              AssetImage('assets/Image-removebg-preview.png'),
                        ),
                      ),
                    )
                  : BuildCondition(
                      condition: image != null,
                      builder: (context) {
                        return Center(
                          child: Image(
                            image: FileImage(image!),
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 15,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      imagePicked = true;
                    });
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);
                    extractedText =
                        await FlutterTesseractOcr.extractText(pickedFile!.path);

                    if (pickedFile != null) {
                      setState(() {
                        imagePicked = true;
                        image = File(pickedFile.path);
                      });
                    }
                  },
                  child: const Text(
                    'select image from gallery',
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
              ),
              if (image != null)
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return DetailsScreen(
                        extractedText: extractedText,
                      );
                    }));
                  },
                  child: Text(
                    'Extract Text',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blue[700],
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
