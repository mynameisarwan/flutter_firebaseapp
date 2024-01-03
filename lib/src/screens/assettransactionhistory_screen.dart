import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
import 'package:flutter_firebaseapp/src/features/controllers/reference_controller.dart';
import 'package:flutter_firebaseapp/src/models/assettransaction.dart';
import 'package:flutter_firebaseapp/src/screens/navigation_screen.dart';
import 'package:intl/intl.dart';

class AssetTransHistory extends StatefulWidget {
  final String assetkey;
  const AssetTransHistory({
    super.key,
    required this.assetkey,
  });

  @override
  State<AssetTransHistory> createState() => _AssetTransHistoryState();
}

class _AssetTransHistoryState extends State<AssetTransHistory> {
  List<AssetTransaction> assetTrans = [];
  String? userEmail;

  getAssetTransaction() async {
    return await AssetTransaction.readAsssetTransaction(widget.assetkey);
  }

  @override
  void initState() {
    getAssetTransaction().then(
      (data) {
        setState(
          () {
            assetTrans = data;
          },
        );
      },
    );

    getReference().then(
      (data) {
        setState(
          () {
            userEmail = data['userEmail'];
          },
        );
      },
    );
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
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Assets ${widget.assetkey}',
          style: const TextStyle(color: Colors.amber),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_basket_outlined,
            ),
            tooltip: 'Open shopping cart',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      NavigationScreen(userEmail: userEmail!, scrIdx: 0),
                ),
              ); // handle the press
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          for (var asset in assetTrans) ...[
            Card(
              color: Colors.black,
              child: ListTile(
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.shopping_bag_outlined,
                              color: Colors.amber,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textFormTemplate(
                                  'Belanja',
                                  true,
                                  10,
                                  Colors.amber,
                                ),
                                textFormTemplate(
                                  DateFormat('dd MMMM yyyy')
                                      .format(asset.transDate!),
                                  true,
                                  10,
                                  Colors.yellow,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textFormTemplate(
                              asset.assetId,
                              true,
                              18,
                              Colors.amber,
                            ),
                            textFormTemplate(
                              '${asset.transQty.toString()} ${asset.transMeasurement}',
                              false,
                              14,
                              Colors.yellow,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        textFormTemplate(
                          'Total Harga',
                          false,
                          14,
                          Colors.amber,
                        ),
                        textFormTemplate(
                          ' ${NumberFormat.simpleCurrency(locale: 'id_ID').format(
                            asset.transTotalPrice.toInt(),
                          )}',
                          true,
                          14,
                          Colors.yellow,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
