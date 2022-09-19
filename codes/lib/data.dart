import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:encrypt/encrypt.dart';


class Controller extends GetxController{

  String name = '';
  String description = '';
  String sp = "";
  String upper = "";
  String pin = "";
  Hash hash = md5;
  Sync sync = Sync();

  List<Actor> actors = [
    Actor(secret: 'path copy from everywhere', time: DateTime.now().toString()),
  ];


  @override
  void onInit() async{
    pin = await sync.readPin();
    if (pin == '') {
      await sync.writeDesc('', '');
      await sync.writeActors([]);
    }
    String descs = await sync.readDesc();
    try {
      var args = descs.split(",");
      name = args[0];
      description = args[1];
    } catch (e) {
      e.printError();
    }
    actors = await sync.readActors();
    super.onInit();
  }

  pinEqual(String pinCode) {
  }

  pinSave() async {
  }

  addPasswordItem(String secret) async {
    actors.add(Actor(
      secret: secret,
      time: DateTime.now().toString()
    ));
    // storage all actors here.
    await sync.writeActors(actors);
  }

  updateNameAndDescription() async {
    await sync.writeDesc(name, description);
  }

  generatePassword(Actor actor) {
  }
}


class Actor {
  String secret;
  String time;

  Actor({
    required this.secret,
    required this.time,
  });
}


class Sync {
  final iv = IV.fromUtf8('');

  final encrypt = ''

  Future<String> get _localPath async {
  }

  Future<File> get _contentFile async {
  }

  Future<File> get _pinFile async {
  }

  Future<File> get _descFile async {
  }

  Future<File> writePin(String pin) async {
  }

  Future<String> readPin() async {
  }

  Future<File> writeDesc(String name, String desc) async {
  }

  Future<String> readDesc() async {
  }

  Future<File> writeActors(List<Actor> actors) async {
  }


  Future<List<Actor>> readActors() async {
  }
}