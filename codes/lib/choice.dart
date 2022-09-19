import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'data.dart';
import 'main.dart';
import 'package:clipboard/clipboard.dart';


class ChoiceActivity extends StatelessWidget {
  const ChoiceActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Paste Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: HomePage(),
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'return',
            child: const Icon(Icons.keyboard_return),
            onPressed: () => Get.to(() => HomeActivity()),
          ),
        ),
      )
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}


class HomePageState extends State<HomePage> {

  TextEditingController field = TextEditingController();
  String pasteValue='';

  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.find();
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                const Text(
                    'paste web url, or any text on web which you want to create account or change password.',
                    style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
                ),
                TextFormField(
                  controller: field,
                  decoration: InputDecoration(
                      hintText: 'Input something here'
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      key: const Key('ink1'),
                      onTap: (){
                        FlutterClipboard.paste().then((value) {
                          setState(() {
                            field.text = value;
                            pasteValue = value;
                          });
                        });
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: const Center(child: Text(
                            'PASTE',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                        )),
                      ),
                    ),
                    InkWell(
                      key: const Key('ink2'),
                      onTap: (){
                        controller.addPasswordItem(field.text);
                        Get.to(() => HomeActivity());
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: const Center(
                            child: Text(
                                'SAVE',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                            )),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}