import 'package:flutter/material.dart';
import 'package:multi_screen_layout/multi_screen_layout.dart';

class TwoPageLayoutExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Two Page Layout Example'),
      ),
      body: TwoPageLayout(
        child: Center(
          child: Text('Hello from page 1! This always displays'),
        ),
        secondChild: Center(
          child: Text(
              'Hello from page 2! This only displays when spanned across 2 displays'),
        ),
      ),
    );
  }
}
