import 'package:flutter/material.dart';
import 'package:mappu/screens/passport/components/level_bar.dart';
import 'package:mappu/screens/passport/components/user_statistics.dart';
import 'components/stamps_preview.dart';
import 'components/profile.dart';
import 'components/stats.dart';

class PassportWidget extends StatelessWidget {
  const PassportWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            // Padding(
            //   padding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
            //   child: Align(
            //     alignment: Alignment.topLeft,
            //     child: Text(
            //       "Hello!",
            //       style: TextStyle(fontSize: 56.0, fontWeight: FontWeight.w600)
            //     ),
            //   ),
            // ),
            SizedBox(height: 36.0),
            Profile(),
            SizedBox(height: 12.0),
            Stats(),
            StampsPreview(),
            // LevelBar(),
            // UserStatistics()
          ],
        ),
      )
    );
  }
}
