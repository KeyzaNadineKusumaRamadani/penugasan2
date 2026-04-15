import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toko_online/widgets/alert.dart';
import 'package:toko_online/models/toko_models.dart';
import 'package:toko_online/services/toko_service.dart';

class TambahTokoView extends StatefulWidget {
  String title;
  TokoModel? item;

  TambahTokoView({required this.title, required this.item});

  @override
  State<TambahTokoView> createState() => _TambahTokoViewState();
}

class _TambahTokoViewState extends State<TambahTokoView> {
  TokoService toko = TokoService();
  final formKey = GlobalKey<FormState>();

  TextEditingController nama_barang = TextEditingController();
  TextEditingController stok = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  TextEditingController harga = TextEditingController();

  File? selectedImage; // variabel untuk menyimpan gambar
  bool isLoading = false;

  Future getImage() async {
    setState(() {
      isLoading = true;
    });

    var img = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (img != null) {
      setState(() {
        selectedImage = File(img.path);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.item != null) {
      nama_barang.text = widget.item!.namaBarang ?? '';
      stok.text = widget.item!.stok.toString();
      deskripsi.text = widget.item!.deskripsi ?? '';
      harga.text = widget.item!.harga.toString();
      selectedImage = null;
    } else {
      nama_barang.clear();
      stok.clear();
      deskripsi.clear();
      harga.clear();
      selectedImage = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color.fromARGB(255, 211, 139, 255),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nama_barang,
                  decoration: InputDecoration(labelText: "Nama Barang"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'harus diisi';
                    }
                    return null;
                  },
                ),

                TextFormField(
                  controller: deskripsi,
                  decoration: InputDecoration(labelText: "Deskripsi"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'harus diisi';
                    }
                    return null;
                  },
                ),

                TextFormField(
                  controller: harga,
                  decoration: InputDecoration(labelText: "Harga"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'harus diisi';
                    }
                    return null;
                  },
                ),

                TextFormField(
                  controller: stok,
                  decoration: InputDecoration(labelText: "Stok"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'harus diisi';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 10),

                TextButton(
                  onPressed: () {
                    getImage();
                  },
                  child: Text("Select Picture"),
                ),

                SizedBox(height: 10),

                selectedImage != null
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.file(selectedImage!),
                      )
                    : isLoading
                        ? CircularProgressIndicator()
                        : Center(child: Text("Please Get the Images")),

                SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 102, 23, 112),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      var data = {
                        "nama_barang": nama_barang.text,
                        "deskripsi": deskripsi.text,
                        "harga": harga.text,
                        "stok": stok.text,
                      };

                      var result;

                      if (widget.item != null) {
                        result = await toko.insertBarang(
                          data,
                          selectedImage,
                          widget.item!.id!,
                        );
                      } else {
                        result = await toko.insertBarang(
                          data,
                          selectedImage,
                          null,
                        );
                      }

                      if (result.status == true) {
                        AlertMessage().showAlert(
                          context,
                          result.message,
                          true,
                        );

                        
                        Navigator.pushReplacementNamed(context, '/toko');
                      } else {
                        AlertMessage().showAlert(
                          context,
                          result.message,
                          false,
                        );
                      }
                    }
                  },
                  child: Text("Simpan"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}