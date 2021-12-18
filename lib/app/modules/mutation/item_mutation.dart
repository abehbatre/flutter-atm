import 'package:ex_reusable/ex_reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_atm/app/common/resource/_index.dart';
import 'package:flutter_atm/app/modules/mutation/mutation_controller.dart';
import 'package:flutter_atm/app/repository/local/database.dart';
import 'package:mock_data/mock_data.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemMutation extends StatelessWidget {
  const ItemMutation({
    Key? key,
    required this.controller,
    required this.i,
    required this.itemClick,
  }) : super(key: key);

  final MutationController controller;
  final int i;
  final Function(TransactionLog data) itemClick;

  @override
  Widget build(BuildContext context) {
    var data = controller.listMutation[i];
    return Container(
      decoration: controller.commonBoxDecoration(),
      child: VStack([
        HStack([
          Container(
            decoration: controller.commonBoxDecoration(fillColor: paleGrey),
            child: 'Type: ${data.description}'.text.uppercase.make().p8(),
          ),
        ]),
        8.heightBox,
        'Waktu transaksi : ${data.createAt.toStringEx(format: 'dd MMM yyyy | HH:mm')}'.text.uppercase.make(),
        'Amount: ${rupiahFormat(data.amount)}'.text.uppercase.make(),
        Divider(),
        'Kode Referensi: \n${mockUUID()}'.text.maxLines(2).overflow(TextOverflow.ellipsis).make(),
      ]).p12(),
    ).pOnly(top: 8, bottom: 8).onInkTap(() {
      itemClick.call(data);
    });
  }
}
