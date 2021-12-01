import 'package:flutter/material.dart';
import 'components/stamps_preview.dart';
import 'components/profile.dart';
import 'components/stats_view.dart';

class PassportWidget extends StatelessWidget {
  const PassportWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 36.0),
            Profile(),
            SizedBox(height: 12.0),
            StatsView(),
            StampsPreview(),
          ],
        ),
      )
    );
  }
}
