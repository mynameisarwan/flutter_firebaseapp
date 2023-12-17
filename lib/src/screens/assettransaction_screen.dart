import 'package:flutter/material.dart';

class AssetTransactionScreen extends StatefulWidget {
  final String assetkey;
  const AssetTransactionScreen({
    super.key,
    required this.assetkey,
  });

  @override
  State<AssetTransactionScreen> createState() => _AssetTransactionScreenState();
}

class _AssetTransactionScreenState extends State<AssetTransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(
          'Assets ${widget.assetkey}',
          style: const TextStyle(color: Colors.amber),
        ),
      ),
    );
  }
}
