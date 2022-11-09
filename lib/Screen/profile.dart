import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:food_app_2/helper/firebase_helper.dart';
import 'package:food_app_2/helper/nav_helper.dart';
import 'package:food_app_2/helper/preferenceHelper.dart';
import 'package:food_app_2/helper/profileData_helper.dart';
import 'package:food_app_2/helper/secure_storage_helper.dart';
import 'package:food_app_2/widget/custom_scaffold.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../helper/Style.dart';
import '../helper/app_color.dart';
import '../helper/app_localizations.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var image = DatabaseHelper.getInstance().appUser?.image ?? "";
    return Scafold(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0, // Hi Bro
              horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)?.translate("profile") ?? "",
                      style: FdStyle.sofiaTitle(color: AppColor.titleBlack),
                    ),
                    InkWell(
                      onTap: () async {
                        DatabaseHelper.getInstance().authInstance.signOut();
                        GoogleSignIn().signOut();
                        FacebookAuth.instance.logOut();
                        SecureStorage.deleteAll();
                        PreferenceHelper().clearPreference();
                        openScreen(signUp, requiresAsInitial: true);
                      },
                      child: Wrap(
                        spacing: 3,
                        children: [
                          Icon(
                            Icons.logout,
                            color: AppColor.amber,
                          ),
                          Text(
                            AppLocalizations.of(context)?.translate("logout") ??
                                "",
                            style: FdStyle.sofiaTitle(
                                color: AppColor.titleBlack, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.teal,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child: FutureBuilder(
                            builder: (context, data) {
                              return (data.data.toString().contains("https://"))
                                  ? Image.network(
                                      data.data.toString(),
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/images/empty_profile.png",
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit.cover,
                                    );
                            },
                            future: getUserImage(),
                          )),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FutureBuilder(
                                builder: (context, data) {
                                  return Text(
                                    data.data.toString(),
                                    style: FdStyle.metropolisRegular(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  );
                                },
                                future: getUserName()),
                            FutureBuilder(
                              builder: (context, data) {
                                return Text(
                                  data.data.toString(),
                                  style: FdStyle.metropolisRegular(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.textGrey),
                                );
                              },
                              future: getUserMail(),
                            ),
                            FutureBuilder(
                              builder: (context, data) {
                                return Text(
                                  data.data.toString(),
                                  style: FdStyle.metropolisRegular(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.textGrey),
                                );
                              },
                              future: getMobileNumber(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    getUserName();
                  },
                  child: ListTile(
                    minLeadingWidth: 0,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      AppLocalizations.of(context)?.translate("my_order") ?? "",
                      style: FdStyle.metropolisRegular(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColor.appBlack1),
                    ),
                    subtitle: Text(
                      "${AppLocalizations.of(context)?.translate("already") ?? ""} ${AppLocalizations.of(context)?.translate("orders") ?? ""}",
                      style: FdStyle.metropolisRegular(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColor.textGrey),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
                Divider(
                  color: AppColor.textGrey,
                  thickness: 0.2,
                ),
                ListTile(
                  minLeadingWidth: 0,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    AppLocalizations.of(context)
                            ?.translate("shipping_address") ??
                        "",
                    style: FdStyle.metropolisRegular(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColor.appBlack1),
                  ),
                  subtitle: Text(
                    AppLocalizations.of(context)?.translate("address") ?? "",
                    style: FdStyle.metropolisRegular(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColor.textGrey),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Divider(
                  color: AppColor.textGrey,
                  thickness: 0.2,
                ),
                ListTile(
                  minLeadingWidth: 0,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    AppLocalizations.of(context)?.translate("payment_method") ??
                        "",
                    style: FdStyle.metropolisRegular(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColor.appBlack1),
                  ),
                  subtitle: Text(
                    AppLocalizations.of(context)?.translate("signUp") ?? "",
                    style: FdStyle.metropolisRegular(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColor.textGrey),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Divider(
                  color: AppColor.textGrey,
                  thickness: 0.2,
                ),
                ListTile(
                  minLeadingWidth: 0,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    AppLocalizations.of(context)?.translate("promo_codes") ??
                        "",
                    style: FdStyle.metropolisRegular(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColor.appBlack1),
                  ),
                  subtitle: Text(
                    AppLocalizations.of(context)
                            ?.translate("promoCode_content") ??
                        "",
                    style: FdStyle.metropolisRegular(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColor.textGrey),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Divider(
                  color: AppColor.textGrey,
                  thickness: 0.2,
                ),
                ListTile(
                  minLeadingWidth: 0,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    AppLocalizations.of(context)?.translate("my_review") ?? "",
                    style: FdStyle.metropolisRegular(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColor.appBlack1),
                  ),
                  subtitle: Text(
                    "${AppLocalizations.of(context)?.translate("reviews_content") ?? ""},${AppLocalizations.of(context)?.translate("item") ?? ""}",
                    style: FdStyle.metropolisRegular(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColor.textGrey),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Divider(
                  color: AppColor.textGrey,
                  thickness: 0.2,
                ),
                ListTile(
                  onTap: (){
                    openScreen(settings);
                  },
                  minLeadingWidth: 0,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    AppLocalizations.of(context)?.translate("settings") ?? "",
                    style: FdStyle.metropolisRegular(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColor.appBlack1),
                  ),
                  subtitle: Text(
                    "${AppLocalizations.of(context)?.translate("notification") ?? ""},${AppLocalizations.of(context)?.translate("password") ?? ""}",
                    style: FdStyle.metropolisRegular(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColor.textGrey),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Divider(
                  color: AppColor.textGrey,
                  thickness: 0.2,
                ),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
