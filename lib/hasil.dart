import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ucp1/home.dart';

class HasilPage extends StatelessWidget {
  final String tanggal;
  final String jenisTransaksi;
  final String jenisBarang;
  final int jumlahBarang;
  final int hargaSatuan;
  final int totalHarga;

  const HasilPage({
    super.key,
    required this.tanggal,
    required this.jenisTransaksi,
    required this.jenisBarang,
    required this.jumlahBarang,
    required this.hargaSatuan,
    required this.totalHarga,
  });

  String formatCurrency(int amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: 0,
    ).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEF9F7),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              SizedBox(height: 40),
              Image.asset('images/succes.png', width: 120, height: 120),
              SizedBox(height: 20),
              Text(
                "Data Berhasil Disimpan",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              detailRow("Tanggal", tanggal),
              Divider(color: Colors.grey.shade300, thickness: 1, height: 20),
              detailRow("Jenis Transaksi", jenisTransaksi),
              Divider(color: Colors.grey.shade300, thickness: 1, height: 20),
              detailRow("Jenis Barang", jenisBarang),
              Divider(color: Colors.grey.shade300, thickness: 1, height: 20),
              detailRow("Jumlah Barang", jumlahBarang.toString()),
              Divider(color: Colors.grey.shade300, thickness: 1, height: 20),
              detailRow("Jenis Harga Satuan", formatCurrency(hargaSatuan)),
              Divider(color: Colors.grey.shade300, thickness: 1, height: 20),
              detailRow("Total Harga", formatCurrency(totalHarga)),
              Divider(color: Colors.grey.shade300, thickness: 1, height: 20),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 0, 162, 255),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text("Selesai", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
