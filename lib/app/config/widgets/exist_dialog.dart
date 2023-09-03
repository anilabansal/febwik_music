import 'package:flutter/material.dart';
import 'package:music_app/app/config/widgets/small_text.dart';
import 'package:music_app/app/ui/theme/colors.dart';
import '../../../dataBase/app_data_base.dart';
import '../dimensions.dart';

class ExistDialog extends StatelessWidget {
  final String? dialogHeaderText;
  final String? dialogText;
  final String? callFrom;
  const ExistDialog({Key? key, this.dialogHeaderText, this.dialogText, this.callFrom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.orangeColor, width: 2),
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SmallText(
              text: dialogHeaderText??'Exit App',
              weight: FontWeight.w800,
              size: Dimensions.font16,
            ),
            const SizedBox(
              height: 10,
            ),
            SmallText(
              text: dialogText??'Do you want to exit an App?',
              weight: FontWeight.w400,
              size: Dimensions.font16,
              color: Colors.white54,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: AppColor.orangeColor),
                    ),
                    child: Center(
                      child: SmallText(
                        text: 'No',
                        weight: FontWeight.w400,
                        size: Dimensions.font16,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    if(callFrom=="logOut"){
                      Navigator.of(context).pop(false);
                      AppLocalStorage().clearData();
                      AppLocalStorage().setUserId(0);
                    }
                    else{
                      Navigator.of(context).pop(true);
                    }

                  },
                  child: Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: AppColor.orangeColor),
                    ),
                    child: Center(
                      child: SmallText(
                        text: 'Yes',
                        weight: FontWeight.w400,
                        size: Dimensions.font16,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () => Navigator.of(context).pop(false),
                //   //return false when click on "NO"
                //   child:const Text('No'),
                // ),
                // ElevatedButton(
                //   onPressed: () => Navigator.of(context).pop(true),
                //   //return true when click on "Yes"
                //   child: const Text('Yes'),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
