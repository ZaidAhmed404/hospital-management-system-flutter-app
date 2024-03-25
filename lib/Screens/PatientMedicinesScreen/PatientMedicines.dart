import 'package:doctor_patient_management_system/cubit/LoadingCubit/loading_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../main.dart';
import 'Widgets/OrderMedicineDialogWidget.dart';

class PatientMedicinesScreen extends StatelessWidget {
  PatientMedicinesScreen({super.key, required this.onBackPressed});

  Function(int) onBackPressed;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<LoadingCubit, LoadingState>(
      builder: (context, state) {
        return LoadingOverlay(
          isLoading: state.loading,
          color: Colors.black,
          opacity: 0.5,
          progressIndicator: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: const CircularProgressIndicator(
                color: Colors.blue,
              )),
          child: Container(
              width: width,
              height: height,
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () => onBackPressed(0),
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.blue.withOpacity(0.2)),
                              child: const Icon(
                                Icons.arrow_back_outlined,
                                color: Colors.blue,
                              )),
                        ),
                        const Spacer(),
                        Text(
                          "Medicines",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: height * appConstants.fontSize20),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => const Dialog(
                                    insetPadding: EdgeInsets.all(20),
                                    child: OrderMedicineDialogWidget()));
                          },
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.blue.withOpacity(0.2)),
                              child: const Icon(
                                Icons.add,
                                color: Colors.blue,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
