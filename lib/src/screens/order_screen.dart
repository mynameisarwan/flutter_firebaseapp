import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_buttomsheet.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_button.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
import 'package:flutter_firebaseapp/src/features/controllers/reference_controller.dart';
import 'package:flutter_firebaseapp/src/models/asset.dart';
import 'package:flutter_firebaseapp/src/models/order.dart';
import 'package:flutter_firebaseapp/src/screens/ordertransaction_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Asset> asset = [];
  late String userName;
  TextEditingController product = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController qty = TextEditingController();

  @override
  void initState() {
    getReference().then(
      (data) {
        setState(
          () {
            userName = data['userName'];
          },
        );
      },
    );

    Asset.getAssetsNamed([
      'Botol 1000 ml',
      'Botol 350 ml',
      'Botol 250 ml',
    ]).then(
      (value) => asset = value,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          iconSize: 16,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        title: textFormTemplate(
          'Order',
          true,
          24,
          Colors.white,
        ),
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.amber[900]!,
              Colors.amber[700]!,
              Colors.amber[500]!,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            10,
            screenSize.height * 0.1,
            10,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textFieldTemplFormTap(
                product,
                'Product',
                Icons.production_quantity_limits_rounded,
                TextInputType.none,
                true,
                () {
                  mbsProduct(
                    context,
                    asset,
                    (value) {
                      setState(
                        () {
                          product =
                              TextEditingController(text: value.assetType);
                          price = TextEditingController(
                            text: value.sellingPrice.toString(),
                          );
                        },
                      );
                    },
                  );
                },
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              textFieldTemplFormTap(
                price,
                'Price',
                Icons.attach_money_rounded,
                TextInputType.none,
                true,
                () {},
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              textFieldTemplForm(
                qty,
                'Jumlah pembelian',
                Icons.shopify_outlined,
                TextInputType.number,
                true,
              ),
              const Spacer(),
              ButtonTemplate(
                buttonText: 'Submit',
                onPressed: () {
                  final ins = Order(
                    productType: product.text,
                    orderQty: num.parse(
                      qty.text,
                    ),
                    orderBy: userName,
                    orderDate: DateTime.now(),
                    orderStatus: 'Request',
                    orderPrice: num.parse(
                      price.text,
                    ),
                  );
                  Order.addOrder(ins);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const OrderTransaction(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
