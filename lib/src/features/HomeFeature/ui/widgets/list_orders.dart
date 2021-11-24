import 'package:aleena/src/bloc/models/order.dart';
import 'package:aleena/src/ui/widgets/cards/card_finish_order.dart';
import 'package:aleena/src/ui/widgets/cards/card_order.dart';
import 'package:flutter/material.dart';
import '/src/core/utils/extensions.dart';

class ListOrders extends StatelessWidget {
  final List<Order> orders;
  final int tabIndex;
  ListOrders({required this.orders,this.tabIndex=0});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => tabIndex==0 ? CardOrder(order: orders[index],) : CardFinishOrder(),
      separatorBuilder: (context, index) => 16.0.ESH(),
      itemCount: orders.length,
      shrinkWrap: true,
    );
  }
}
