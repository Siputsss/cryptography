import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

final ctrlText = TextEditingController();
final ctrlKey = TextEditingController();

var cipherText = 'empty text';
var plainText = 'empty text';
var isShowClearText = false;
var isShowClearKey = false;
encrypt.Encrypted? encrypted;

//  final key = encrypt.Key.fromSecureRandom(32);
var key = encrypt.Key.fromUtf8(ctrlKey.text);
final encrypter = encrypt.Encrypter(encrypt.AES(key));
final iv = encrypt.IV.fromSecureRandom(16);

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void encryptText(String text) {
    final plainText = text;
    encrypted = encrypter.encrypt(plainText, iv: iv);

    cipherText = encrypted!.base64;
    setState(() {});
    // debugPrint(encrypted.base64);
    // debugPrint(cipherText);
  }

  void decryptText() {
    final decrypted = encrypter.decrypt(encrypted!, iv: iv);
    plainText = decrypted;
    setState(() {});
    // debugPrint(decrypted);
  }

  void clearAll() {
    ctrlText.clear();
    ctrlKey.clear();
    isShowClearText = false;
    isShowClearKey = false;
    cipherText = 'empty text';
    plainText = 'empty text';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //   title: const Text('Cryptography Modern'),
        // ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/images/enkripsi.png',
                  height: 100,
                  width: 100,
                ),
                const Center(child: Text('Encrypt & Decrypt')),
                const SizedBox(height: 10),
                TextField(
                  controller: ctrlText,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Text',
                    hintText: 'Input Text',
                    suffixIcon: isShowClearText
                        ? IconButton(
                            onPressed: () {
                              ctrlText.clear();
                              setState(() {
                                isShowClearText = false;
                              });
                            },
                            icon: const Icon(Icons.clear),
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        isShowClearText = false;
                      });
                    } else {
                      setState(() {
                        isShowClearText = true;
                      });
                    }
                    setState(() {});
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: ctrlKey,
                  maxLength: 32,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Secret Key',
                    hintText: 'Input secret key',
                    suffixIcon: isShowClearKey
                        ? IconButton(
                            onPressed: () {
                              ctrlKey.clear();
                              setState(() {
                                isShowClearKey = false;
                              });
                            },
                            icon: const Icon(Icons.clear),
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        isShowClearKey = false;
                      });
                    } else {
                      setState(() {
                        isShowClearKey = true;
                      });
                    }
                    key = encrypt.Key.fromUtf8(value);
                    setState(() {});
                  },
                ),
                // const SizedBox(height: 20),
                // Text(encrypt.Key.fromUtf8(ctrlKey.text).base64),
                // const SizedBox(height: 20),
                // Text(iv.base64),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: (ctrlText.text.isNotEmpty) && (ctrlKey.text.length == 32)
                      ? () {
                          encryptText(ctrlText.text);
                        }
                      : null,
                  child: const Text('Encrypt'),
                ),
                const SizedBox(height: 20),
                Text(
                  'cipher text: $cipherText',
                  textScaler: const TextScaler.linear(2),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () {
                    decryptText();
                  },
                  child: const Text(
                    "Decrypt",
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'plain text: $plainText',
                  textScaler: const TextScaler.linear(2),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    OutlinedButton(
                      onPressed: clearAll,
                      child: const Text('Clear All'),
                    ),
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
