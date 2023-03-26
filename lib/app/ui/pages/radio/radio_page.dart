import 'package:flutter/material.dart';

import '../../../config/widgets/text_base.dart';


class RadioPage extends StatefulWidget {
  const RadioPage({Key? key}) : super(key: key);

  @override
  State<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextBase('RadioPage'),
        centerTitle: true,
      ),
      body: Center(
        child: TextBase(
          'RadioPage is working',
        ),
      ),
    );
  }
}
