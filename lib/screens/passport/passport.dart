import 'package:flutter/material.dart';
import 'components/stamps_cabinet.dart';

class PassportWidget extends StatelessWidget {
  const PassportWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: StampsCabinet(),
    );
  }
}
