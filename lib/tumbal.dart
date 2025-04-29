import 'package:flutter/material.dart';

class DataBarangPage extends StatefulWidget {
  const DataBarangPage({super.key});

  @override
  State<DataBarangPage> createState() => _DataBarangPageState();
}

class _DataBarangPageState extends State<DataBarangPage> {
  DateTime? selectedDate;
  String? selectedTransactionType;
  String? selectedItemType;
  int itemCount = 0;
  double unitPrice = 0.0;

  final transactionTypes = ['Barang Masuk', 'Barang Keluar'];
  final itemTypes = ['Carrier', 'Sleeping Bag', 'Tenda', 'Sepatu'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Barang'),
        backgroundColor: Color.fromARGB(255, 0, 162, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tanggal Transaksi', style: TextStyle(fontSize: 16)),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  selectedDate == null
                      ? 'Tanggal Transaksi'
                      : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Jenis Transaksi', style: TextStyle(fontSize: 16)),
            DropdownButtonFormField<String>(
              value: selectedTransactionType,
              hint: Text("Pilih jenis transaksi"),
              isExpanded: true,
              onChanged: (newValue) {
                setState(() {
                  selectedTransactionType = newValue;
                });
              },
              items:
                  transactionTypes.map<DropdownMenuItem<String>>((
                    String value,
                  ) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
            ),
            SizedBox(height: 20),
            Text('Jenis Barang', style: TextStyle(fontSize: 16)),
            DropdownButton<String>(
              value: selectedItemType,
              hint: Text("Pilih jenis barang"),
              isExpanded: true,
              onChanged: (newValue) {
                setState(() {
                  selectedItemType = newValue;
                });
              },
              items:
                  itemTypes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  itemCount = int.tryParse(value) ?? 0;
                });
              },
              decoration: InputDecoration(
                labelText: 'Jumlah Barang',
                border: OutlineInputBorder(),
                errorText:
                    itemCount <= 0 ? "Jumlah barang tidak boleh kosong" : null,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  unitPrice = double.tryParse(value) ?? 0.0;
                });
              },
              decoration: InputDecoration(
                labelText: 'Harga Satuan (Rp)',
                border: OutlineInputBorder(),
                errorText:
                    unitPrice <= 0 ? "Harga satuan tidak boleh kosong" : null,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedDate != null &&
                    selectedTransactionType != null &&
                    selectedItemType != null &&
                    itemCount > 0 &&
                    unitPrice > 0.0) {
                  double totalPrice = itemCount * unitPrice;
                  // Handle submission, e.g., show a dialog with totalPrice
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: Text('Total Harga'),
                          content: Text(
                            'Total Harga: Rp. ${totalPrice.toString()}',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                  );
                }
              },
              child: Text('Submit'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Button color
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }
}
