import 'package:flutter/material.dart';

import '../../../Models/OrderMedicines.dart';
import '../../../main.dart';

class OrderDetailsDialogWidget extends StatelessWidget {
  OrderDetailsDialogWidget({super.key, required this.orderMedicineModel});

  OrderMedicineModel orderMedicineModel;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order Details",
              style: TextStyle(
                  fontSize: height * appConstants.fontSize20,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Name",
              style: TextStyle(
                  fontSize: height * appConstants.fontSize14,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              orderMedicineModel.name,
              style: TextStyle(
                fontSize: height * appConstants.fontSize14,
              ),
            ),
            const Divider(),
            Text(
              "Address",
              style: TextStyle(
                  fontSize: height * appConstants.fontSize14,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              orderMedicineModel.address,
              style: TextStyle(
                fontSize: height * appConstants.fontSize14,
              ),
            ),
            const Divider(),
            Text(
              "Status",
              style: TextStyle(
                  fontSize: height * appConstants.fontSize14,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              orderMedicineModel.status,
              style: TextStyle(
                fontSize: height * appConstants.fontSize14,
              ),
            ),
            const Divider(),
            for (int index = 0;
                index < orderMedicineModel.medicines.length;
                index++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Medicine ${index + 1}",
                    style: TextStyle(
                        fontSize: height * appConstants.fontSize14,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    orderMedicineModel.medicines[index]['name'],
                    style:
                        TextStyle(fontSize: height * appConstants.fontSize14),
                  ),
                  const Divider(),
                  Text(
                    "Quantity ${index + 1}",
                    style: TextStyle(
                        fontSize: height * appConstants.fontSize14,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    orderMedicineModel.medicines[index]['quantity'],
                    style:
                        TextStyle(fontSize: height * appConstants.fontSize14),
                  ),
                  const Divider(),
                  Text(
                    "Price ${index + 1}",
                    style: TextStyle(
                        fontSize: height * appConstants.fontSize14,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    orderMedicineModel.medicines[index]['price'].toString(),
                    style:
                        TextStyle(fontSize: height * appConstants.fontSize14),
                  ),
                  const Divider(),
                ],
              ),
            Text(
              "Total",
              style: TextStyle(
                  fontSize: height * appConstants.fontSize14,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              orderMedicineModel.total,
              style: TextStyle(fontSize: height * appConstants.fontSize14),
            ),
          ],
        ),
      ),
    );
  }
}
