import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_button.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
import 'package:flutter_firebaseapp/src/models/assettransaction.dart';
import 'package:flutter_firebaseapp/src/screens/assettransactionhistory_screen.dart';
import 'package:flutter_firebaseapp/src/screens/navigation_screen.dart';
import 'package:intl/intl.dart';

class AssetTransactionScreen extends StatefulWidget {
  final String assetkey;
  final String userEmail;

  const AssetTransactionScreen({
    super.key,
    required this.assetkey,
    required this.userEmail,
  });

  @override
  State<AssetTransactionScreen> createState() => _AssetTransactionScreenState();
}

class _AssetTransactionScreenState extends State<AssetTransactionScreen> {
  TextEditingController tanggalpembelian = TextEditingController();
  TextEditingController jumlah = TextEditingController();
  TextEditingController satuanpembelian = TextEditingController();
  TextEditingController hargasatuan = TextEditingController();
  TextEditingController hargatotal = TextEditingController();
  DateTime tanggal = DateTime.now();
  @override
  void initState() {
    tanggalpembelian = TextEditingController(
      text: DateFormat('dd MMMM yyyy').format(
        tanggal,
      ),
    );
    jumlah = TextEditingController(text: '0');
    hargasatuan = TextEditingController(text: '0');
    hargatotal = TextEditingController(text: '0');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            // var count = 0;
            // Navigator.of(context).popUntil((route) => count++ >= 2);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    NavigationScreen(userEmail: widget.userEmail, scrIdx: 0),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Open shopping cart',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AssetTransHistory(
                    assetkey: widget.assetkey,
                  ),
                ),
              ); // handle the press
            },
          ),
        ],
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Assets ${widget.assetkey}',
          style: const TextStyle(color: Colors.amber),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            textFieldCalendarTemplForm(
              tanggalpembelian,
              'Tanggal',
              Icons.calendar_today,
              TextInputType.text,
              () {
                showDatePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2050),
                ).then(
                  (value) {
                    setState(
                      () {
                        tanggal = value!;
                        tanggalpembelian = TextEditingController(
                          text: DateFormat('dd MMMM yyyy').format(
                            tanggal,
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            textFieldTemplForm(
              jumlah,
              'Jumlah Pembelian',
              Icons.shopify_outlined,
              TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            textFieldTemplForm(
              satuanpembelian,
              'Satuan Pembelian',
              Icons.design_services_outlined,
              TextInputType.text,
            ),
            const SizedBox(
              height: 20,
            ),
            textFieldTemplForm(
              hargasatuan,
              'Harga Satuan',
              Icons.price_change,
              TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            textFieldTemplForm(
              hargatotal,
              'Harga Total',
              Icons.monetization_on_outlined,
              TextInputType.number,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: ButtonTemplate(
          buttonText: 'Submit',
          onPressed: () async {
            final trans = AssetTransaction(
              transDate: tanggal,
              transQty: num.parse(jumlah.text),
              transPrice: num.parse(hargasatuan.text),
              transTotalPrice: num.parse(hargatotal.text),
              transMeasurement: satuanpembelian.text,
              assetId: widget.assetkey,
            );
            AssetTransaction.addAssetTransaction(
                userEmail: widget.userEmail, data: trans);
            // Asset.updateAssetTransaction(
            //   trans: trans,
            //   assettype: widget.assetkey,
            // );
          },
        ),
      ),
    );
  }
}
