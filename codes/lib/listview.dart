import 'dart:async';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'package:get/get.dart';
import 'package:clipboard/clipboard.dart';
import 'package:overlay_support/overlay_support.dart';


class ListViewComp extends StatefulWidget {
  const ListViewComp({Key? key}) : super(key: key);

  @override
  State<ListViewComp> createState() => _ListViewCompState();
}

class _ListViewCompState extends State<ListViewComp> {

  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.find();

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Text('Strong Your Password !', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.lightBlueAccent),),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SearchableList<Actor>(
                /// Callback function invoked each time the listview
                /// reached the bottom
                /// used to create pagination in listview
                onPaginate: null,
                builder: (Actor actor) => ActorItem(actor: actor),
                loadingWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Loading actors...')
                  ],
                ),
                errorWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Error while fetching actors')
                  ],
                ),
                /// Async callback that return list to be displayed with future builder
                asyncListCallback: () async {
                  await Future.delayed(
                    const Duration(
                      milliseconds: 1000,
                    ),
                  );
                  return controller.actors;
                },
                /// Callback invoked when filtring the searchable list
                asyncListFilter: (q, list) {
                  return list
                      .where((element) => element.secret.contains(q))
                      .toList();
                },
                emptyWidget: const EmptyView(),
                onRefresh: () async {},
                /// Function invoked when pressing on item
                onItemSelected: (Actor item) {
                  // here should copy & paste secret to clipboard
                  String realPwd = controller.generatePassword(item);
                  FlutterClipboard.copy(realPwd).then(( value ) =>
                      showSimpleNotification(
                        const Text('Password Copied Successful'),
                        background: Colors.lightGreen
                      ));
                },
                inputDecoration: InputDecoration(
                  labelText: "Search Passwords",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ActorItem extends StatelessWidget {
  final Actor actor;

  const ActorItem({
    Key? key,
    required this.actor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            const Icon(
              Icons.security_rounded,
              color: Colors.lightGreen,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'path: ${actor.secret}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'time: ${actor.time}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.error_outline_rounded,
          color: Colors.red,
        ),
        SizedBox(height: 4),
        Text('no actor is found with this name', style: (TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),),
      ]
    );
  }
}
