import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_button.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
import 'package:flutter_firebaseapp/src/models/asset.dart';

class AssetScreen extends StatelessWidget {
  final String assetKey;
  const AssetScreen({
    super.key,
    required this.assetKey,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController hargajual = TextEditingController();
    TextEditingController satuanJual = TextEditingController();
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
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Assets $assetKey',
          style: const TextStyle(color: Colors.amber),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
          future: Asset.getAssetbyType(assetKey),
          builder: (BuildContext context, AsyncSnapshot<Asset> snapshot) {
            return snapshot.hasData
                ? Column(
                    children: [
                      textFieldTemplForm(
                        hargajual = TextEditingController(
                          text: snapshot.data!.sellingPrice == null
                              ? '0'
                              : snapshot.data!.sellingPrice!.toString(),
                        ),
                        'Harga Jual',
                        Icons.shopify_outlined,
                        TextInputType.number,
                        true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      textFieldTemplForm(
                        satuanJual = TextEditingController(
                          text: snapshot.data!.sellingUnit ?? '',
                        ),
                        'Satuan Penjualan',
                        Icons.design_services_outlined,
                        TextInputType.text,
                        true,
                      ),
                    ],
                  )
                : snapshot.hasError
                    ? Text('Error ${snapshot.error}')
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
          },
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: ButtonTemplate(
          buttonText: 'Submit',
          onPressed: () {
            Asset data = Asset(
              sellingPrice: num.parse(hargajual.text),
              sellingUnit: satuanJual.text,
              assetType: assetKey,
            );
            Asset.updateAsset(data);
          },
        ),
      ),
    );
  }
}
