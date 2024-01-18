import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
import 'package:flutter_firebaseapp/src/models/asset.dart';
import 'package:intl/intl.dart';

Future<void> mbsProduct(
  BuildContext context,
  List<Asset> assets,
  Function(String selected)? onTap,
) {
  var screenSize = MediaQuery.of(context).size;

  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        height: 300,
        padding: EdgeInsets.fromLTRB(
          screenSize.width * 0.01,
          50,
          screenSize.width * 0.01,
          5,
        ),
        child: ListView(
          children: [
            for (var asset in assets) ...[
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  onTap!('${asset.assetType}');
                  Navigator.pop(context);
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textFormTemplate(
                        '${asset.assetType}',
                        true,
                        20,
                        Colors.black,
                      ),
                      textFormTemplate(
                        'Harga : ${NumberFormat.simpleCurrency(locale: 'id_ID').format(
                          asset.sellingPrice!.toInt(),
                        )} / ${asset.sellingUnit}',
                        false,
                        12,
                        Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                // height: 20,
                thickness: 1,
                // indent: 20,
                endIndent: 0,
                color: Colors.black12.withOpacity(0.1),
              ),
            ]
          ],
        ),
      );
    },
  );
}
