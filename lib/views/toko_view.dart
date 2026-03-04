import 'package:flutter/material.dart';
import 'package:toko_online/models/response_data_list.dart';
import 'package:toko_online/services/toko_service.dart';
import 'package:toko_online/widgets/bottom_nav.dart';

class tokoView extends StatefulWidget {
  const tokoView({super.key});

  @override
  State<tokoView> createState() => _tokoViewState();
}

class _tokoViewState extends State<tokoView> {
  TokoService tokoService = TokoService();
  List? barang; 

  getbarang() async { 
    ResponseDataList getbarang = await tokoService.getbarang(); 
    setState(() { 
      barang = getbarang.data; 
    }); 
  } 

  final Color primaryPurple = Color(0xFF9C27B0);
  final Color softPurple = Color(0xFF673AB7);

  @override
  void initState() {
    super.initState();
    getbarang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// BACKGROUND GRADIENT
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryPurple.withOpacity(0.15),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Column(
          children: [
            /// APPBAR GRADIENT
            Container(
              padding: const EdgeInsets.only(
                top: 10,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryPurple,
                    softPurple,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Text(
                  "Toko",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            

            /// GRID PRODUK (DITAMBAHKAN CEK NULL)
            Expanded(
              child: barang != null
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: GridView.builder(
                        itemCount: barang!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.62,
                        ),
                        itemBuilder: (context, index) {
                          final item = barang![index];

                          return Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white,
                                  softPurple.withOpacity(0.3),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryPurple.withOpacity(0.15),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                
                                /// GAMBAR PRODUK
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                            top: Radius.circular(14),
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                item.image),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        left: 8,
                                        child: Container(
                                          padding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                primaryPurple,
                                                softPurple,
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Text(
                                            "PROMO",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight:
                                                  FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                /// INFO PRODUK
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.namaBarang,
                                        maxLines: 2,
                                        overflow:
                                            TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight:
                                              FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "${item.harga}",
                                        style: TextStyle(
                                          color: primaryPurple,
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "0",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )

                 
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNav(1),
    );
  }
}




