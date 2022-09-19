import 'package:flutter/material.dart';
import 'listview.dart';
import 'data.dart';
import 'choice.dart';
import 'pin.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;
import 'package:overlay_support/overlay_support.dart';


void notice(context) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text('Oops! your platform not supported.'),
    duration: Duration(milliseconds: 3000),
    backgroundColor: Colors.orange,
  ));
}

void main() {
  runApp(GetMaterialApp(home: PinApp()));
}

class HomeActivity extends StatelessWidget {
  const HomeActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.put(Controller());
    final textFieldController = TextEditingController(text: controller.name);
    final text2FieldController = TextEditingController(text: controller.description);
    return OverlaySupport.global(child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Builder(
          builder: (context) => Scaffold(
              body: const SafeArea(
                child: ListViewComp(),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButton: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FloatingActionButton(
                          heroTag: 'btn1',
                          onPressed: () => {
                            if (controller.name == '' || controller.description == ''){
                              showDialog(context: context, builder: (context) {
                                return const AlertDialog(
                                  title: Text('Warning'),
                                  content: Text('input name tag and description first !!!')
                                );
                              })
                            }else{
                              Get.to(() => ChoiceActivity())
                            }
                          },
                          tooltip: 'New',
                          child: const Icon(
                              Icons.add,
                          )),
                      const SizedBox(height: 4),
                      FloatingActionButton(
                          heroTag: 'btn2',
                          onPressed: () => {
                                // Input controller.name
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text(
                                            'Input Your Special Name'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              'If changed, All password will regenerated.',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.deepOrange
                                              ),
                                            ),
                                            TextField(
                                              controller: textFieldController,
                                              decoration: const InputDecoration(
                                                  hintText: "e.g: batman"),
                                            ),
                                          ],
                                        ),
                                        actions: <Widget>[
                                          ElevatedButton(
                                              onPressed: () =>
                                                  {Navigator.pop(context)},
                                              child: const Text('Back')),
                                          ElevatedButton(
                                              onPressed: () => {
                                                    controller.name =
                                                        textFieldController
                                                            .text,
                                                    controller.updateNameAndDescription(),
                                                    Navigator.pop(context)
                                                  },
                                              child: const Text('Sure'))
                                        ],
                                      );
                                    })
                              },
                          tooltip: 'Name',
                          child: const Text('Name')),
                      const SizedBox(height: 4),
                      FloatingActionButton(
                          heroTag: 'btn3',
                          onPressed: () => {
                                // Input controller.description
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text(
                                            'Input Your Special Description'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              'If changed, All password will regenerated.',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Colors.deepOrange
                                              ),
                                            ),
                                            TextField(
                                              controller: text2FieldController,
                                              decoration: const InputDecoration(
                                                  hintText: "e.g: i am strong superhero"),
                                            ),
                                          ],
                                        ),
                                        actions: <Widget>[
                                          ElevatedButton(
                                              onPressed: () =>
                                                  {Navigator.pop(context)},
                                              child: const Text('Back')),
                                          ElevatedButton(
                                              onPressed: () => {
                                                    controller.description =
                                                        text2FieldController
                                                            .text,
                                                    controller.updateNameAndDescription(),
                                                    Navigator.pop(context)
                                                  },
                                              child: const Text('Sure'))
                                        ],
                                      );
                                    })
                              },
                          tooltip: 'Description',
                          child: const Text('Desc')),
                    ],
                  ))),
        )));
  }
}
