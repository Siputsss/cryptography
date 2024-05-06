import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Aplikasi Encrypt & Decrypt',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Aplikasi Encrypt & Decrypt adalah alat sederhana yang digunakan untuk mengenkripsi dan mendekripsi teks menggunakan algoritma AES (Advanced Encryption Standard). Aplikasi ini cocok digunakan untuk keperluan pengamanan teks rahasia.',
              // style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Fitur Utama:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 10),
            Text('- Enkripsi dan dekripsi teks menggunakan kunci rahasia.'),
            Text('- Penggunaan algoritma AES untuk keamanan yang tinggi.'),
            Text('- Antar muka yang sederhana dan mudah digunakan.'),
            SizedBox(height: 20),
            Text(
              'Dengan Encrypt & Decrypt, Anda dapat dengan mudah mengamankan data rahasia Anda.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
