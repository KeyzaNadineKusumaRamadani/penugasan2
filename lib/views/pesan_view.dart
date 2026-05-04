import 'package:flutter/material.dart';
import 'package:toko_online/controllers/cartProvider.dart';
import 'package:toko_online/models/cart.dart';
import 'package:toko_online/services/DBHelper.dart';
import 'package:toko_online/services/toko_service.dart';
import 'package:badges/badges.dart' as badges;
import 'package:toko_online/widgets/bottom_nav.dart';


class PesanView extends StatefulWidget {
  const PesanView({super.key});


  @override
  State<PesanView> createState() => _PesanViewState();
}


class _PesanViewState extends State<PesanView> {
  var dBHelper = DBHelper();
  final cartProvider = CartProvider();
  List? barang;
  getbarang() async {
    var result = await TokoService().getbarangUser();
    setState(() {
      barang = result.data;
    });
  }


  void updateCount() async {
    await cartProvider.getData();
    setState(() {
      cartProvider.counter = cartProvider.cart.length;
    });
  }


  void saveData(int index) async {
    var detail = await dBHelper.getCartListDetail(index);
    var qty = 0;
    if (detail.length > 0) {
      qty = detail[0].quantity;
    }


    dBHelper
        .insert(
          Cart(
            id: index,
            id_barang: barang![index].id.toString(),
            nama_barang: barang![index].namaBarang,
            deskripsi: barang![index].deskripsi,
            harga: barang![index].harga,
            quantity: qty + 1,
            image: barang![index].image,
          ),
        )
        .then((value) {
          updateCount();
          print('Product Added to cart');
        })
    // .onError((error, stackTrace) {
    //   print(error.toString());
    // })
    ;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getbarang();
    updateCount();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: const Color.fromARGB(255, 90, 0, 120),
        foregroundColor: Colors.white,
        title: const Text('Product List'),
        actions: [
          badges.Badge(
            badgeContent: ListenableBuilder(
              listenable: cartProvider,
              builder: (context, child) {
                if (cartProvider.cart.isEmpty) {
                  return Text(
                    '0',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else {
                  return Text(
                    '${cartProvider.counter}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
              },
            ),


            position: badges.BadgePosition.topEnd(top: 0, end: 2),


            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/cartScreen");
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(width: 20.0),
        ],
      ),
      body:
          barang != null
              ? ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 8.0,
                ),
                shrinkWrap: true,
                itemCount: barang!.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.blueGrey.shade200,
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image(
                            height: 80,
                            width: 80,
                            image: NetworkImage("${barang![index].image}"),
                          ),
                          SizedBox(
                            width: 130,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5.0),
                                RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  text: TextSpan(
                                    text: 'Name: ',
                                    style: TextStyle(
                                      color: Colors.blueGrey.shade800,
                                      fontSize: 16.0,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            '${barang![index].namaBarang.toString()}\n',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  maxLines: 1,
                                  text: TextSpan(
                                    text: 'deskripsi: ',
                                    style: TextStyle(
                                      color: Colors.blueGrey.shade800,
                                      fontSize: 16.0,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            '${barang![index].deskripsi.toString()}\n',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  maxLines: 1,
                                  text: TextSpan(
                                    text:
                                        'harga: '
                                        r"$",
                                    style: TextStyle(
                                      color: Colors.blueGrey.shade800,
                                      fontSize: 16.0,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '${barang![index].harga.toString()}\n',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              iconColor: Colors.blueGrey.shade900,
                            ),
                            onPressed: () {
                              saveData(index);
                              // daga(index);
                            },
                            child: const Text('Add to Cart'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
              : Center(child: Text("data kosong")),
      bottomNavigationBar: BottomNav(1),
    );
  }
}
