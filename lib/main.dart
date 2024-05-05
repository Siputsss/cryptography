import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

final ctrlText = TextEditingController();
final ctrlKey = TextEditingController();

var cipherText = '';
var plainText = '';
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
  bool _isVisibleEnc = false;
  bool _isVisibleDes = false;

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
    _isVisibleEnc = false;
    _isVisibleDes = false;
    cipherText = '';
    plainText = '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
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
                const Center(
                    child: Text(
                  'Encrypt & Decrypt',
                  textScaler: TextScaler.linear(2),
                )),
                const SizedBox(height: 30),
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
                        _isVisibleEnc = false;
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
                        _isVisibleEnc = false;
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
                          _isVisibleEnc = true;
                        }
                      : null,
                  child: const Text('Encrypt'),
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: _isVisibleEnc,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        cipherText,
                        textScaler: const TextScaler.linear(1.2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    decryptText();
                    _isVisibleDes = true;
                  },
                  child: const Text(
                    "Decrypt",
                  ),
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: _isVisibleDes,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        plainText,
                        textScaler: const TextScaler.linear(1.5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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
