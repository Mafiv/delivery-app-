import 'package:flutter/material.dart';
import '../Constants/DeliveryConstants.dart' as Styles;

class InformationRow extends StatelessWidget {
  final String rowKey;
  final String rowValue;

  const InformationRow({
    Key? key,
    required this.rowKey,
    required this.rowValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Styles.padding,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              rowKey,
              style: Styles.rowStyle,
            ),
          ),
          const SizedBox(width: 16), 
          Expanded(
            flex: 2,
            child: Text(
              rowValue,
              style: Styles.valueStyle,
            ),
          ),
        ],
      ),
    );
  }
}
