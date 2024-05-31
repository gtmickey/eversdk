import 'dart:convert';

import 'package:eversdk/src/rust/api/ton.dart';
import 'package:flutter/material.dart';
import 'package:eversdk/src/rust/api/simple.dart';
import 'package:eversdk/src/rust/frb_generated.dart';

final config = {
  'network': {
    'endpoints': ["https://gql-testnet.venom.foundation/graphql"],
    'message_retries_count': 5,
    'message_processing_timeout': 40000,
    'wait_for_timeout': 40000,
    'out_of_sync_threshold': 15000,
    'access_key': ''
  },
  'crypto': {'fish_param': ''},
  'abi': {
    'message_expiration_timeout': 40000,
    'message_expiration_timeout_grow_factor': 1.5
  }
};

/// -----------
/// 查余额 参数
const programJson =
    r'{"query":"query getBalance($address: String!) {blockchain {account(address: $address) {info {balance}}}}","variables":{"address":"0:c04a3b76473ae6a33df68a63f41099362062c66893e0064592f14e76656f6b7c"}}';
const functionName = "net.query";

/// -----------

Future<void> main() async {
  await RustLib.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String callbackResult = "";
  String balanceResult = "";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      getBalanceTest();

      callbackTest();
    });
    super.initState();
  }

  void getBalanceTest() async {
    final result = await tonCreateContext(config: jsonEncode(config));

    final context = jsonDecode(result)['result'] as int;

    balanceResult = await tonRequest(
        context: context,
        functionName: functionName,
        functionParamsJson: programJson);

    setState(() {});
  }

  void callbackTest() async {
    await goShopping(
        name: 'mickey',
        location: '太古里',
        onThere: (result) async {
          setState(() {
            callbackResult = result;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ton api')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(callbackResult),
            Text(balanceResult),
          ],
        ),
      ),
    );
  }
}
