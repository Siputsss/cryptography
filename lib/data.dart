import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

final ctrlText = TextEditingController();
final ctrlKey = TextEditingController();
var cipherText = '';
var plainText = '';
var isShowClearText = false;
var isShowClearKey = false;
bool isVisibleEnc = false;
bool isVisibleDes = false;
bool flag = false;
encrypt.Encrypted? encrypted;

//  final key = encrypt.Key.fromSecureRandom(32);
var key = encrypt.Key.fromUtf8(ctrlKey.text);
final encrypter = encrypt.Encrypter(encrypt.AES(key));
final iv = encrypt.IV.fromSecureRandom(16);
