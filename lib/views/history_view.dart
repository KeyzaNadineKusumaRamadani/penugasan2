import 'package:flutter/material.dart';
import 'package:toko_online/services/pesan.dart';
import 'package:toko_online/widgets/bottom_nav.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  Pesan pesan = Pesan();
  List? history;

  getHistorytransaksi() async {
    var result = await pesan.getHistory();
    print(result.data);
    setState(() {
      history = result.data;
    });
  }

  @override
  void initState() {
    super.initState();
    getHistorytransaksi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History Transaksi"),
        backgroundColor: const Color.fromARGB(255, 112, 0, 132),
        foregroundColor: Colors.white,
      ),
      body: history == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: history!.length,
              itemBuilder: (context, index) {
                var transaksi = history![index];
                var detailList = transaksi['detail'];

                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// 🔹 HEADER (USER + TANGGAL)
                        Text(
                          transaksi['nama_user'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Tanggal: ${transaksi['tgl_transaksi']}",
                          style: const TextStyle(color: Colors.grey),
                        ),

                        const Divider(),

                        /// 🔹 LIST BARANG
                        Column(
                          children: List.generate(detailList.length, (i) {
                            var item = detailList[i];

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    item['nama_barang'],
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                Text("x${item['quantity']}"),
                                const SizedBox(width: 10),
                                Text("Rp${item['harga_beli']}"),
                              ],
                            );
                          }),
                        ),

                        const Divider(),

                        /// 🔹 TOTAL HARGA
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Total: Rp${_hitungTotal(detailList)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomNav(2),
    );
  }

  
  int _hitungTotal(List detailList) {
    int total = 0;
    for (var item in detailList) {
      total += (item['harga_beli'] * item['quantity']) as int;
    }
    return total;
  }
}