import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/services.dart';
import 'home_data.dart';
import '../b.about/about_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void encryptText(String text) {
    final plainText = text;
    encrypted = encrypter.encrypt(plainText, iv: iv);

    cipherText = encrypted!.base64;
    setState(() {});
  }

  void decryptText() {
    final decrypted = encrypter.decrypt(encrypted!, iv: iv);
    plainText = decrypted;
    setState(() {});
  }

  void clearAll() {
    ctrlText.clear();
    ctrlKey.clear();
    isShowClearText = false;
    isShowClearKey = false;
    isVisibleEnc = false;
    isVisibleDes = false;
    cipherText = '';
    plainText = '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: [
            Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutPage()),
                    );
                  },
                  icon: const Icon(Icons.info));
            })
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/enkripsi.png',
                  height: 100,
                  width: 100,
                ),
                const Center(
                    child: Text(
                  'Encrypt & Decrypt',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textScaler: TextScaler.linear(2),
                )),
                const SizedBox(height: 30),
                SizedBox(
                  width: 425,
                  child: TextField(
                    controller: ctrlText,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Text',
                      hintText: 'Enter the text to be encrypted',
                      prefixIcon: const Icon(Icons.text_snippet),
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
                          isVisibleEnc = false;
                        });
                      }
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 425,
                  child: TextField(
                    controller: ctrlKey,
                    maxLength: 32,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Secret Key',
                      hintText: 'Enter the secret key',
                      prefixIcon: const Icon(Icons.key),
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
                          isVisibleEnc = false;
                        });
                      }
                      key = encrypt.Key.fromUtf8(value);
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: OutlinedButton(
                    onPressed: (ctrlText.text.isNotEmpty) && (ctrlKey.text.length == 32)
                        ? () {
                            encryptText(ctrlText.text);
                            isVisibleEnc = true;
                          }
                        : null,
                    style: OutlinedButton.styleFrom(
                      disabledBackgroundColor: Colors.deepPurple[50],
                      backgroundColor: Colors.deepPurple[200],
                    ),
                    child: const Text(
                      'Encrypt',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: isVisibleEnc,
                  child: Container(
                    height: 50,
                    width: 425,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              cipherText,
                              textScaler: const TextScaler.linear(1.2),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: cipherText));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Text copied to clipboard')),
                            );
                          },
                          icon: const Icon(Icons.copy),
                          tooltip: 'copy text',
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: OutlinedButton(
                    onPressed: () {
                      decryptText();
                      isVisibleDes = true;
                    },
                    style: OutlinedButton.styleFrom(backgroundColor: Colors.deepPurple[200]),
                    child: const Text(
                      "Decrypt",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: isVisibleDes,
                  child: Container(
                    height: 50,
                    width: 425,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              plainText,
                              textScaler: const TextScaler.linear(1.2),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: plainText));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Text copied to clipboard')),
                            );
                          },
                          icon: const Icon(Icons.copy),
                          tooltip: 'copy text',
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    OutlinedButton(
                      onPressed: clearAll,
                      child: const Text(
                        'Clear All',
                      ),
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
