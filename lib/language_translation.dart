import 'package:flutter/material.dart';
import 'package:translator/translator.dart'; // Required for GoogleTranslator

class LanguageTranslationPage extends StatefulWidget {
  const LanguageTranslationPage({super.key});

  @override
  State<LanguageTranslationPage> createState() => _LanguageTranslationPageState();
}

class _LanguageTranslationPageState extends State<LanguageTranslationPage> {
  var languages = ['Hindi', 'English', 'Arabic','Spanish','French'];
  var originalLanguage = 'English'; // Default
  var destinationLanguage = 'Hindi'; // Default
  var output = "";

  TextEditingController languageController = TextEditingController();

  void translate(String src, String dest, String input) async {
    GoogleTranslator translator = GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = translation.text.toString();
    });

    if (src == '--' || dest == '--') {
      setState(() {
        output = "Failed to translate";
      });
    }
  }

  String getLanguageCode(String language) {
    switch (language) {
      case "English":
        return "en";
      case "Hindi":
        return "hi";
      case "Arabic":
        return "ar";
      case "Spanish":
        return "es";
      case "French":
        return "fr";
      default:
        return "--";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff10223d),
      appBar: AppBar(
        title: const Text("Language Translator"),
        centerTitle: true,
        backgroundColor: const Color(0xff10223d),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              // Dropdowns Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Source Language Dropdown
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("From", style: TextStyle(color: Colors.white)),
                      DropdownButton<String>(
                        dropdownColor: Colors.blueGrey,
                        value: originalLanguage,
                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                        style: const TextStyle(color: Colors.white),
                        underline: Container(height: 1, color: Colors.white),
                        items: languages.map((String lang) {
                          return DropdownMenuItem<String>(
                            value: lang,
                            child: Text(lang),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            originalLanguage = value!;
                          });
                        },
                      ),
                    ],
                  ),

                  const Icon(Icons.arrow_right_alt_outlined, color: Colors.white, size: 40),

                  // Destination Language Dropdown
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("To", style: TextStyle(color: Colors.white)),
                      DropdownButton<String>(
                        dropdownColor: Colors.blueGrey,
                        value: destinationLanguage,
                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                        style: const TextStyle(color: Colors.white),
                        underline: Container(height: 1, color: Colors.white),
                        items: languages.map((String lang) {
                          return DropdownMenuItem<String>(
                            value: lang,
                            child: Text(lang),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            destinationLanguage = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Text Field
              TextFormField(
                cursorColor: Colors.white,
                controller: languageController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Enter text to translate...',
                  labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Translate Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2b3c5a),
                ),
                onPressed: () {
                  translate(
                    getLanguageCode(originalLanguage),
                    getLanguageCode(destinationLanguage),
                    languageController.text,
                  );
                },
                child: const Text("Translate"),
              ),

              const SizedBox(height: 30),

              // Output
              Text(
                output,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
