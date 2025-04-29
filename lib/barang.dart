import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ucp1/hasil.dart';

class DataBarangPage extends StatefulWidget {
  const DataBarangPage({super.key});

  @override
  State<DataBarangPage> createState() => _DataBarangPageState();
}

class _DataBarangPageState extends State<DataBarangPage> {
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController jumlahController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();

  String? selectedTransactionType;
  String? selectedItemType;

  final transactionTypes = ['Barang Masuk', 'Barang Keluar'];
  final itemTypes = ['Carrier', 'Sleeping Bag', 'Tenda', 'Sepatu'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 162, 255),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Pendataan Barang',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              'Tanggal Transaksi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: tanggalController,
              readOnly: true,
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  locale: const Locale('id', 'ID'),
                );
                if (picked != null) {
                  tanggalController.text = DateFormat(
                    "EEEE, dd MMMM yyyy",
                    "id_ID",
                  ).format(picked);
                }
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.calendar_today),
                labelText: 'Tanggal Transaksi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedTransactionType,
              items:
                  transactionTypes.map((e) {
                    return DropdownMenuItem(value: e, child: Text(e));
                  }).toList(),
              onChanged: (val) => setState(() => selectedTransactionType = val),
              decoration: InputDecoration(
                labelText: 'Jenis Transaksi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedItemType,
              items:
                  itemTypes.map((e) {
                    return DropdownMenuItem(value: e, child: Text(e));
                  }).toList(),
              onChanged: (val) => setState(() => selectedItemType = val),
              decoration: InputDecoration(
                labelText: 'Jenis Barang',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: jumlahController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Jumlah Barang',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: hargaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixText: 'Rp. ',
                      labelText: 'Harga Satuan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                int jumlah = int.tryParse(jumlahController.text) ?? 0;
                int harga = int.tryParse(hargaController.text) ?? 0;
                int total = jumlah * harga;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => HasilPage(
                          tanggal: tanggalController.text,
                          jenisTransaksi: selectedTransactionType ?? '',
                          jenisBarang: selectedItemType ?? '',
                          jumlahBarang: jumlah,
                          hargaSatuan: harga,
                          totalHarga: total,
                        ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 162, 255),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('Submit', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
