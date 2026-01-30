import 'package:flutter/material.dart';
import 'package:toko_online/widgets/bottom_nav.dart';

class PesanView extends StatefulWidget {
  const PesanView({super.key});

  @override
  State<PesanView> createState() => _PesanViewState();
}

class _PesanViewState extends State<PesanView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaksi Saya"),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF9C27B0),
                Color(0xFF673AB7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          pesananCard(
            toko: "Bloomy Flower",
            status: "Selesai",
            namaProduk: "Bucket Bunga Mawar",
            harga: "Rp100.000",
            jumlah: 1,
            gambar: "assets/bunga1.jpg",
          ),
          pesananCard(
            toko: "Lavender Store",
            status: "Dikirim",
            namaProduk: "Bucket Bunga Lavender",
            harga: "Rp135.000",
            jumlah: 1,
            gambar: "assets/bunga2.jpg",
          ),
          pesananCard(
            toko: "Sunshine Florist",
            status: "Dalam Proses",
            namaProduk: "Bucket Bunga Matahari",
            harga: "Rp90.000",
            jumlah: 2,
            gambar: "assets/bunga3.jpg",
          ),
          pesananCard(
            toko: "Rose Garden",
            status: "Selesai",
            namaProduk: "Bucket Bunga Lily+",
            harga: "Rp105.000",
            jumlah: 1,
            gambar: "assets/bunga4.jpg",
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(1),
    );
  }

  Widget pesananCard({
    required String toko,
    required String status,
    required String namaProduk,
    required String harga,
    required int jumlah,
    required String gambar,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF3E5F5),
            Color(0xFFEDE7F6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header Toko
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  toko,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  status,
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const Divider(),

            /// Produk
            Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(gambar),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        namaProduk,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text("Jumlah: $jumlah"),
                      const SizedBox(height: 6),
                      Text(
                        harga,
                        style: const TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),

            const SizedBox(height: 12),

            /// Tombol
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.deepPurple,
                    side: const BorderSide(color: Colors.deepPurple),
                  ),
                  child: const Text("Lihat Detail"),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFBA68C8),
                        Color(0xFF7E57C2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Beli Lagi"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
