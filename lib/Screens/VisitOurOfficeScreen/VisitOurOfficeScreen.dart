import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../main.dart';
import 'Widgets/ContactWidget.dart';

class VisitOurOfficeScreen extends StatelessWidget {
  VisitOurOfficeScreen({super.key, required this.backPressedFunction});

  Function(int) backPressedFunction;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8)),
                  child: IconButton(
                      onPressed: () => backPressedFunction(0),
                      icon: const Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.blue,
                      )),
                ),
                const Spacer(),
                Text(
                  "Visit Our Office",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: height * appConstants.fontSize20),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ContactWidget(
              contact: "030000000000",
              icon: const Icon(
                Icons.call,
                color: Colors.white,
              ),
            ),
            ContactWidget(
              contact: "sehatsakoon@gmail.com",
              icon: const Icon(
                Icons.mail,
                color: Colors.white,
              ),
            ),
            ContactWidget(
              contact: "Opposite comsats university Islamabad wah campus",
              icon: const Icon(
                Icons.location_on,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: () {
                      appConstants.commonServices.launchInBrowser(
                          context: context,
                          urlPath:
                              "https://www.facebook.com/profile.php?id=61557565421319&mibextid=ZbWKwL");
                    },
                    child: const Icon(FontAwesomeIcons.facebook,
                        color: Colors.blue, size: 50.0)),
                InkWell(
                    onTap: () {
                      appConstants.commonServices.launchInBrowser(
                          context: context,
                          urlPath:
                              "https://www.linkedin.com/company/sehat-sakoon/");
                    },
                    child: const Icon(FontAwesomeIcons.linkedin,
                        color: Colors.blue, size: 50.0))
              ],
            )
          ],
        ),
      ),
    );
  }
}
