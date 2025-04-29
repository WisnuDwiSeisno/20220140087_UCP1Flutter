import 'package:flutter/material.dart';
import 'package:ucp1/piketgudang.dart';

class DetailPage extends StatelessWidget {
  final TugasPiket tugas;

  const DetailPage({super.key, required this.tugas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEF8F6),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 162, 255),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Detail ${tugas.tugas}',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    tugas.tanggal,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 0, 162, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 0, 162, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(tugas.nama, style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 162, 255),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                tugas.tugas,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
