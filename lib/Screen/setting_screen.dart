
import 'package:flutter/material.dart';
import 'package:food_app_2/helper/dialog_helper.dart';
import 'package:food_app_2/helper/profileData_helper.dart';
import 'package:food_app_2/widget/container_button.dart';
import 'package:food_app_2/widget/textFieldWidget.dart';

import '../helper/Style.dart';
import '../helper/app_color.dart';
import '../helper/app_localizations.dart';
import '../helper/firebase_helper.dart';
import '../helper/nav_helper.dart';
import '../helper/utlis.dart';

class SettingScreen extends StatefulWidget {
   SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
TextEditingController fullName=TextEditingController();

   TextEditingController dob=TextEditingController();

   TextEditingController password=TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                loginHeader(context),
                personalInformation(context),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                passwordChange(context),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),

              ],
            ),
          ),
        ),
      ),
      bottomSheet:   FutureBuilder(
        builder: (context,data) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ContainerButton(
              backGroundColor: AppColor.appBlack1,
              buttonTitle: AppLocalizations.of(context)?.translate("upload") ?? "",
              buttonSize: 50,
              onTap:() async {

              await  DatabaseHelper().updateUserData(
                  name: fullName.text,
                  image: imageURL,
                  uid: data.data.toString()

              );
              DatabaseHelper().getUserDetails();

              },
            ),
          );

        },
        future: getUiD(),
      ),
    );
  }

   Widget loginHeader(BuildContext context) {
     return Column(crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         InkWell(
           onTap: () {
             back(null);
           },
           child:Icon(Icons.arrow_back_ios),
         ),
         SizedBox(
           height: MediaQuery.of(context).size.height * 0.004,
         ),
         Text(
           AppLocalizations.of(context)?.translate("settings") ?? "",
           style: FdStyle.sofiaTitle(color: AppColor.titleBlack),
         ),
         SizedBox(
           height: MediaQuery.of(context).size.height * 0.008,
         ),
       ],
     );
   }

   Widget personalInformation(BuildContext context) {
     return Column(crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Text(
           AppLocalizations.of(context)?.translate("personal_information") ?? "",
           style: FdStyle.sofiaTitle(color: AppColor.titleBlack,fontSize: 16),
         ),
         SizedBox(
           height: MediaQuery.of(context).size.height * 0.006,
         ),
         Card(
           elevation: 2,
           child: Padding(
             padding: const EdgeInsets.only(left: 10.0,
                 top: 6,
                 bottom: 6),
             child: TextFieldButton(
               controller: fullName,
               textAlign: TextAlign.start,
               labelText: AppLocalizations.of(context)?.translate("full_name") ?? "",
               fontsize: 14,
               borderRadius: 10,
               color: AppColor.textGrey,
               fontweight: FontWeight.w400,
             ),
           ),
         ),
         SizedBox(
           height: MediaQuery.of(context).size.height * 0.01,
         ),
         Card(
           elevation: 2,
           child: Padding(
             padding: const EdgeInsets.only(left: 10.0,
                 top: 6,
                 bottom: 6),
             child: TextFieldButton(
               onTap: () async {
                 var date = await showDatePicker(
                     builder: (context, child) {
                       return Padding(
                         padding: const EdgeInsets.all(20.0),
                         child: Theme(
                           data: Theme.of(context).copyWith(
                             colorScheme:  ColorScheme.light(
                               primary: AppColor.amber,
                               // header background color
                               onPrimary: AppColor.appBackground,
                               // header text color
                               onSurface: Colors.black, // body text color
                             ),
                           ),
                           child: child ?? Container(),
                         ),
                       );
                     },
                     context: context,
                     initialDate: DateTime.now(),
                     firstDate: DateTime(1900),
                     lastDate: DateTime.now());
                 dob.text = formatedDate("dd/MM/yyyy", date.toString());
                 setState(() {});
               },
               controller: dob,
               onChange: (val){
               },
               textAlign: TextAlign.start,
               labelText: AppLocalizations.of(context)?.translate("date_birth") ?? "",
               fontsize: 14,
               borderRadius: 10,
               color: AppColor.textGrey,
               fontweight: FontWeight.w400,
             ),
           ),
         ),
         SizedBox(
           height: MediaQuery.of(context).size.height * 0.01,
         ),
         InkWell(
           onTap: (){
             DialogueHelper().imagePicker(context);
           },
           child: Container(
             color: AppColor.textGrey,
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text(
                 AppLocalizations.of(context)?.translate("click_Upload") ?? "",
                 style: FdStyle.sofiaTitle(color: AppColor.appBlack1,fontSize: 12,
                   fontWeight: FontWeight.w400,),
               ),
             ),
           ),
         )
       ],
     );
   }

   Widget passwordChange(BuildContext context) {
     return Column(crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(
               AppLocalizations.of(context)?.translate("password") ?? "",
               style: FdStyle.sofiaTitle(color: AppColor.titleBlack,fontSize: 16),
             ),
             Text(
               AppLocalizations.of(context)?.translate("change") ?? "",
               style: FdStyle.sofiaTitle(color: AppColor.textGrey,fontSize: 16,
                 fontWeight: FontWeight.w400,),
             ),
           ],
         ),
         SizedBox(
           height: MediaQuery.of(context).size.height * 0.006,
         ),
         Card(
           elevation: 2,
           child: Padding(
             padding: const EdgeInsets.only(left: 10.0,
                 top: 6,
                 bottom: 6),
             child: TextFieldButton(
               controller: password,
               textAlign: TextAlign.start,
               labelText: AppLocalizations.of(context)?.translate("password") ?? "",
               fontsize: 14,
               borderRadius: 10,
               color: AppColor.textGrey,
               fontweight: FontWeight.w400,
             ),
           ),
         ),

       ],
     );
   }



}
