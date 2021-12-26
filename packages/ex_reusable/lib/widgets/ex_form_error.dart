import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ExFormError extends StatelessWidget {
  const ExFormError({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        VStack(<Widget>[
          if (errorMessage.isNotBlank)
            Row(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.info, color: Colors.red, size: 12),
                ),
                const WidthBox(8),
                errorMessage.text.red500.make(),
              ],
            )
          else
            const HeightBox(0),
        ]).scrollHorizontal(),
      ],
    );
  }
}
