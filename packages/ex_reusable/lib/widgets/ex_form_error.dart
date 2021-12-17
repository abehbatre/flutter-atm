import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ExFormError extends StatelessWidget {
  final String errorMessage;

  const ExFormError({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VStack([
          errorMessage.isNotBlank
              ? Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(Icons.info, color: Colors.red, size: 12),
                    ),
                    WidthBox(8),
                    errorMessage.text.red500.make(),
                  ],
                )
              : HeightBox(0),
        ]).scrollHorizontal(),
      ],
    );
  }
}
