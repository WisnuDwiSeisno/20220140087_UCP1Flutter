import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ucp1/detail.dart';

class PiketPage extends StatefulWidget {
  const PiketPage({super.key});

  @override
  State<PiketPage> createState() => _PiketPageState();
}

class _PiketPageState extends State<PiketPage> {
  final TextEditingController namaController = TextEditingController(
    text: 'Admin',
  );
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController taskController = TextEditingController();

  List<TugasPiket> tugasList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 162, 255),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 35),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Piket Gudang',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama Anggota',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: namaController,
                  decoration: InputDecoration(
                    labelText: 'Nama Anggota',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Pilih Tanggal',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: tanggalController,
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      locale: const Locale('id', 'ID'),
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        tanggalController.text = DateFormat(
                          "EEEE, dd MMMM yyyy",
                          "id_ID",
                        ).format(pickedDate);
                      });
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.calendar_today),
                    labelText: 'Pilih Tanggal',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tugas Piket',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: taskController,
                            decoration: InputDecoration(
                              labelText: 'Tugas Piket',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Tugas tidak boleh kosong!';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 36),
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(
                                  255,
                                  0,
                                  162,
                                  255,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    tugasList.add(
                                      TugasPiket(
                                        nama: namaController.text,
                                        tanggal: tanggalController.text,
                                        tugas: taskController.text,
                                      ),
                                    );
                                    taskController.clear();
                                  });
                                }
                              },
                              child: Text(
                                'Tambah',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    'Daftar Tugas Piket',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 12),
                if (tugasList.isNotEmpty) ...[
                  ListView.builder(
                    itemCount: tugasList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final tugas = tugasList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailPage(tugas: tugas),
                            ),
                          );
                        },
                        child: Card(
                          color: Color.fromARGB(255, 0, 162, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            title: Text(
                              tugas.tugas,
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ] else ...[
                  SizedBox(height: 200),
                  Center(
                    child: Text(
                      'Tidak ada tugas piket',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TugasPiket {
  final String nama;
  final String tanggal;
  final String tugas;

  TugasPiket({required this.nama, required this.tanggal, required this.tugas});

  @override
  String toString() {
    return '$nama - $tanggal - $tugas';
  }
}
