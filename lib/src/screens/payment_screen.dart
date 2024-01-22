import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_button.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
import 'package:flutter_firebaseapp/src/models/order.dart';
import 'package:flutter_firebaseapp/src/models/payment.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_firebaseapp/src/models/order.dart';

class PaymentScreen extends StatefulWidget {
  final Order ordermdl;
  const PaymentScreen({
    super.key,
    required this.ordermdl,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController paymentDate = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController qty = TextEditingController();
  DateTime tanggal = DateTime.now();
  num paymentprice = 0;
  num maxQty = 0;

  getvalue() {
    Payment.getTotalPaidQTY(widget.ordermdl.orderId!).then(
      (value) {
        for (var dt in value) {
          maxQty = maxQty + dt.paymentQty;
        }
        maxQty = widget.ordermdl.orderQty - maxQty;
      },
    );
  }

  @override
  void initState() {
    getvalue();
    // print('maxqty = $maxQty');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
// TextInputFormatter
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
          'Payment ${widget.ordermdl.productType}',
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
              textFieldCalendarTemplForm(
                paymentDate,
                'Tanggal Pembayaran',
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
                          paymentDate = TextEditingController(
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
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              Focus(
                onFocusChange: (value) {
                  value
                      ? null
                      : qty = TextEditingController(
                          text: maxQty.toString(),
                        );
                },
                child: textFieldTemplFormOnChange(
                  qty,
                  'Jumlah pembayaran',
                  Icons.shopify_outlined,
                  TextInputType.number,
                  false,
                  (values) {
                    setState(
                      () {
                        if (values != '') {
                          if (num.parse(values) > maxQty) {
                            qty = TextEditingController(
                              text: maxQty.toString(),
                            );
                            // maxQty = widget.ordermdl.orderQty;
                          } else {
                            maxQty = num.parse(values);
                          }
                          paymentprice = maxQty * widget.ordermdl.orderPrice;
                        }
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              textFieldTemplForm(
                price = TextEditingController(
                  text: NumberFormat.decimalPattern().format(paymentprice),
                ),
                'Nilai Pembayaran',
                Icons.attach_money_rounded,
                TextInputType.none,
                true,
              ),
              const Spacer(),
              ButtonTemplate(
                buttonText: 'Submit',
                onPressed: () {
                  Payment data = Payment(
                    paymentQty: num.parse(qty.text),
                    paymentDate: tanggal,
                    paymentPrice: paymentprice,
                    paymentStatus: 'Paid',
                  );
                  Payment.paymentAdd(data, widget.ordermdl.orderId!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
