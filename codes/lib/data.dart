import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:encrypt/encrypt.dart' as encrypt_pkg;


class Controller extends GetxController{

  String name = '';   // input args
  String description = '';   // input args
  String sp = "";      // generated include special signs, like ",@#"
  String upper = "";  // generated include upper characters like "ABC"
  String pin = "";    // input args
  Hash hash = null;   // hash methods
  Sync sync = Sync();

  List<Actor> actors = [
    Actor(secret: 'path copy from everywhere', time: DateTime.now().toString()),
  ];


  @override
  void onInit() async{
    var args = await sync.readData();
    pin = args[0];
    name = args[1];
    description = args[2];
    actors = args[3];
    super.onInit();
  }

  pinEqual(String pinCode) {
    String pinMd5 = hash.convert(utf8.encode(pinCode)).toString();
    if (pinMd5 == pin) {
      return true;
    } else {
      return false;
    }
  }

  pinSave(currentText) {
    pin = hash.convert(utf8.encode(currentText)).toString();
  }

  addPasswordItem(String secret) async {
    Actor actor = Actor(
        secret: secret,
        time: DateTime.now().toString()
    );
    actors.add(actor);
    // storage all actors here.
    await sync.writeActors(actor);
  }

  updateNameAndDescription() async {
    if (name != '' && description != ''){
      await sync.writeData(pin, name, description);
    }
  }

  generatePassword(Actor actor) {
      // defined generated password method here
  }
}


class Actor {
  String secret;
  String time;

  Actor({
    required this.secret,
    required this.time,
  });

  @override
  String toString() {
    return "$secret,$time";
  }
}


class Sync {
  final iv = encrypt_pkg.IV.fromUtf8('');   // define your known
  String spMark1 = "";           // define your own
  String spMark2 = "";           // define your own
  final encrypt = encrypt_pkg.Encrypter(encrypt_pkg.AES(
      encrypt_pkg.Key.fromUtf8(''),    // define your own
      mode: encrypt_pkg.AESMode.ctr, padding: null
  ));

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _dataFile async {
    final path = await _localPath;
    return File('$path/strong_pwd_data.bin');
  }

  Future<List> readData() async {
    // defined your own
  }

  Future<File> writeData(String pin, String name, String desc) async {
    // defined your own
  }

  Future<File> writeActors(Actor actor) async {
    // defined your own
  }
}