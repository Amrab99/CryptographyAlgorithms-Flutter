import 'package:cryptography_algorithms/fileManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'logic.dart';

Logic logic = new Logic();
String result;
String fileName="newFile.txt"; 
String plainText;
String cipehrText;
bool flagForcolor=false;

class Screen extends StatefulWidget {
  final title;

  Screen({this.title});

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  void initState() {
    super.initState();
    setState(() {
      result = '';
    });
  }

  inputFormattin() {
    if (widget.title == 'CAESAR CIPHER || SHIFT CIPHER' || widget.title == 'VIGENERE CIPHER')
      return <TextInputFormatter>[
        new FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))
      ];
  }
  //الاصل بقدر ادخل اي ارقام او حروف بس هنا بحدد عايز ارقام بس او حروف بس 
  keyFormattin() {
    if (widget.title == 'CAESAR CIPHER || SHIFT CIPHER')
      return <TextInputFormatter>[
        new FilteringTextInputFormatter.allow(RegExp("[0-9]"))
      ];
    else if (widget.title == 'VIGENERE CIPHER')
      return <TextInputFormatter>[
        new FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))
      ];
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController input = TextEditingController();
  TextEditingController key = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.deepOrange),
          ),
        ),
        body: ListView(
          children: [
            Form(
              key: formKey,
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                    left: MediaQuery.of(context).size.height * 0.02,
                    right: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: TextFormField(
                    controller: input,
                    inputFormatters: inputFormattin(),
                    validator: (value) {
                      if (value.isEmpty) return 'Required';
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        hintText: 'Entre Plain Text'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                    left: MediaQuery.of(context).size.height * 0.02,
                    right: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: TextFormField(
                    controller: key,
                    inputFormatters: keyFormattin(),
                    validator: (value) {
                      if (value.isEmpty)
                        return 'Required';
                      else if (widget.title == 'PLAYFAIR CIPHER' &&
                          key.text.length < 6)
                        return 'Playfair key size must atleast be 6 characters long.';
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        hintText: 'Entre Key'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton.icon(
                        onPressed: ()async {
                          flagForcolor=true; 
                          if (formKey.currentState.validate())
                            setState(() {
                              if (widget.title == "CAESAR CIPHER || SHIFT CIPHER")
                                result = logic.caesar(
                                    input.text , int.parse(key.text), 1);
                              else if (widget.title == "VIGENERE CIPHER")
                                result =
                                    logic.vigenere(input.text, key.text, 1);
                              else if (widget.title == "PLAYFAIR CIPHER")
                                result =
                                    logic.playfairEncrypt(input.text, key.text);
                            });
                            FileManager c = FileManager();
                           c.saveCipherFile(cipherText: result,filename: 'encrypterdText.txt');
                        },
                        icon: Icon(Icons.lock_outline),
                        label: Text('ENCRYPT'),
                        color: Colors.white,
                        textColor: Colors.deepOrange,
                      ),
                      RaisedButton.icon(
                        onPressed: () {
                          flagForcolor=false;
                          if (formKey.currentState.validate())
                            setState(() {
                              if (widget.title == "CAESAR CIPHER || SHIFT CIPHER")
                                result = logic.caesar(
                                    result, int.parse(key.text), 0);
                              else if (widget.title == "VIGENERE CIPHER")
                                result =
                                    logic.vigenere(result, key.text, 0);
                              else if (widget.title == "PLAYFAIR CIPHER")
                                result =
                                    logic.playfairDecrypt(result, key.text);
                            });
                             FileManager f = FileManager();
                           f.saveFile(plainText: input.text,filename: 'decryptedFile.txt');
                        },
                        icon: Icon(Icons.lock_open_rounded),
                        label: Text('DECRYPT'),
                        color: Colors.white,
                        textColor: Colors.deepOrange,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05),
                  child: ListTile(
                      title: Text(
                    'OUTPUT',
                    style: TextStyle(fontSize: 30, color: Colors.deepOrange),
                    textAlign: TextAlign.center,
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02),
                  child: ListTile(
                      title: Text(result,
                    style: TextStyle(fontSize: 30,color: flagForcolor? Colors.red:Colors.green),
                    textAlign: TextAlign.center,
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.4),
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 15),
                      title: Text(
                    "check internal storage for files !",
                    style: TextStyle(fontSize: 15,color: Colors.deepOrange),
                    textAlign: TextAlign.left,
                    
                  )),
                ),
              ]),
            )
          ],
        ));
  }
}
