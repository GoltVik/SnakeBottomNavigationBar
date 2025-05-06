import 'package:flutter/material.dart';

class DemoPage extends StatelessWidget {
  final String? text;
  final String? description;
  final Image? image;

  final _titleStyle = const TextStyle(
    fontSize: 40,
    fontFamily: 'SourceSerifPro',
  );
  final _subtitleStyle = const TextStyle(
    fontSize: 20,
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.w200,
  );

  const DemoPage({
    super.key,
    this.text,
    this.description,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SafeArea(
        child: OrientationBuilder(builder: (_, orientation) {
          return orientation == Orientation.portrait
              ? _portrait()
              : _horizontal();
        }),
      ),
    );
  }

  Widget _portrait() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text.rich(
          TextSpan(
            text: '${text!}\n',
            style: _titleStyle,
            children: [
              WidgetSpan(child: const SizedBox(height: 16)),
              TextSpan(
                text: description!,
                style: _subtitleStyle,
              ),
            ],
          ),
          // textAlign: TextAlign.center,
        ),
        image!
      ],
    );
  }

  Widget _horizontal() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Text.rich(
            TextSpan(
              text: '${text!}\n',
              style: _titleStyle,
              children: [
                WidgetSpan(child: const SizedBox(height: 16)),
                TextSpan(
                  text: description!,
                  style: _subtitleStyle,
                ),
              ],
            ),
            // textAlign: TextAlign.center,
          ),
        ),
        Expanded(child: image!)
      ],
    );
  }
}
