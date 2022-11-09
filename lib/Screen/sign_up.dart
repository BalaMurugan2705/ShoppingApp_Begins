import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app_2/authendication/fb_auth.dart';
import 'package:food_app_2/authendication/google_auth.dart';
import 'package:food_app_2/cubit/userdata_cubit.dart';
import 'package:food_app_2/helper/Style.dart';
import 'package:food_app_2/helper/api_helper.dart';
import 'package:food_app_2/helper/app_color.dart';
import 'package:food_app_2/helper/app_localizations.dart';
import 'package:food_app_2/helper/app_vaditations.dart';
import 'package:food_app_2/helper/dialog_helper.dart';
import 'package:food_app_2/helper/firebase_helper.dart';
import 'package:food_app_2/helper/nav_helper.dart';
import 'package:food_app_2/model/userModel_forDb.dart';
import 'package:food_app_2/widget/container_button.dart';
import 'package:food_app_2/widget/custom_scaffold.dart';
import 'package:food_app_2/widget/textFieldWidget.dart';
import 'package:http/http.dart';

import '../helper/utlis.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController dob = TextEditingController();
  bool name1 = false;

  TextEditingController lastName = TextEditingController();

  bool lastName1 = false;

  TextEditingController email = TextEditingController();

  bool email1 = false;

  TextEditingController password = TextEditingController();

  bool password1 = false;

  TextEditingController city = TextEditingController();

  bool city1 = false;

  TextEditingController street = TextEditingController();

  bool street1 = false;

  TextEditingController doorNo = TextEditingController();

  bool doorNo1 = false;

  TextEditingController zipcode = TextEditingController();

  bool zipcode1 = false;

  TextEditingController phone = TextEditingController();

  bool phone1 = false;

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scafold(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    signUpHeader(context),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            nameField(),
                            lastNameField(),
                            emailField(),
                            dateOfBirth(),
                            passwordField(),
                            cityField(),
                            streetField(),
                            doorNoField(),
                            zipcodeField(),
                            phoneField(),
                            alreadyHaveAccountField(),
                          ],
                        ),
                      ),
                    ),
                    continueButtonField(context),
                  ],
                ),
                Visibility(
                  visible: visible,
                  child: DialogueHelper().progressIndicator(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginWithMobField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)?.translate("loginWithPhone") ?? "",
          style: FdStyle.sofia(
            fontSize: 14,
          ),
        ),
        TextButton(
          onPressed: () {
            // setState(() {
            //   phoneLogin = !phoneLogin;
            // });
            openScreen(loginWithMob);
          },
          child: Text(
            AppLocalizations.of(context)?.translate("yes") ?? "",
            style: TextStyle(color: AppColor.red1),
          ),
        )
      ],
    );
  }

  Widget signUpHeader(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            back(null);
          },
          child: Image.asset(
            "assets/images/icon.png",
            height: 30,
            width: 30,
          ),
        ),
        Text(
          AppLocalizations.of(context)?.translate("signUp") ?? "",
          style: FdStyle.sofiaTitle(color: AppColor.titleBlack),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
      ],
    );
  }

  Widget nameField() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: TextFieldButton(
                controller: name,
                onChange: (val) {
                  setState(() {
                    _formKey.currentState!.validate();
                  });
                  if (val.isNotEmpty) {
                    name1 = true;
                  } else {
                    name1 = false;
                  }
                },
                validate: (val) {
                  if (val!.isEmpty) {
                    return "Please Enter Name";
                  }
                },
                inputType: TextInputType.emailAddress,
                textAlign: TextAlign.start,
                labelText:
                    AppLocalizations.of(context)?.translate("name") ?? "",
                fontweight: FontWeight.w400,
                floating: FloatingLabelBehavior.auto,
                color: AppColor.textGrey,
              ),
            ),
            Visibility(
              visible: name1,
              child: Icon(
                Icons.check,
                color: AppColor.checkGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget dateOfBirth() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
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
            Visibility(
              visible: name1,
              child: Icon(
                Icons.check,
                color: AppColor.checkGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget lastNameField() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: TextFieldButton(
                controller: lastName,
                onChange: (val) {
                  setState(() {
                    _formKey.currentState!.validate();
                  });
                  if (val.isNotEmpty) {
                    lastName1 = true;
                  } else {
                    lastName1 = false;
                  }
                },
                validate: (val) {
                  if (val!.isEmpty) {
                    return "Please Enter Last Name";
                  }
                },
                inputType: TextInputType.emailAddress,
                textAlign: TextAlign.start,
                labelText:
                    AppLocalizations.of(context)?.translate("lastName") ?? "",
                fontweight: FontWeight.w400,
                floating: FloatingLabelBehavior.auto,
                color: AppColor.textGrey,
              ),
            ),
            Visibility(
              visible: lastName1,
              child: Icon(
                Icons.check,
                color: AppColor.checkGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: TextFieldButton(
                controller: email,
                validate: (val) {
                  if (val!.isEmpty) {
                    return "Please Enter Email";
                  } else if (AppValidation.isEmailValid(val)) {
                    return "Please Enter Valid Email";
                  }
                },
                onChange: (val) {
                  setState(() {
                    _formKey.currentState!.validate();
                  });
                  if (val.isNotEmpty) {
                    email1 = true;
                  } else {
                    email1 = false;
                  }
                },
                inputType: TextInputType.emailAddress,
                textAlign: TextAlign.start,
                labelText:
                    AppLocalizations.of(context)?.translate("email") ?? "",
                fontweight: FontWeight.w400,
                floating: FloatingLabelBehavior.auto,
                color: AppColor.textGrey,
              ),
            ),
            Visibility(
              visible: email1,
              child: Icon(
                Icons.check,
                color: AppColor.checkGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget passwordField() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: TextFieldButton(
                controller: password,
                validate: (val) {
                  if (val!.isEmpty) {
                    return "Please Enter Password";
                  }
                },
                onChange: (val) {
                  setState(() {
                    _formKey.currentState!.validate();
                  });
                  if (val.isNotEmpty) {
                    password1 = true;
                  } else {
                    password1 = false;
                  }
                },
                inputType: TextInputType.emailAddress,
                textAlign: TextAlign.start,
                labelText:
                    AppLocalizations.of(context)?.translate("password") ?? "",
                fontweight: FontWeight.w400,
                floating: FloatingLabelBehavior.auto,
                color: AppColor.textGrey,
              ),
            ),
            Visibility(
              visible: password1,
              child: Icon(
                Icons.check,
                color: AppColor.checkGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cityField() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: TextFieldButton(
                controller: city,
                onChange: (val) {
                  setState(() {
                    _formKey.currentState!.validate();
                  });
                  if (val.isNotEmpty) {
                    city1 = true;
                  } else {
                    city1 = false;
                  }
                },
                validate: (val) {
                  if (val!.isEmpty) {
                    return "Please Enter City";
                  }
                },
                inputType: TextInputType.emailAddress,
                textAlign: TextAlign.start,
                labelText:
                    AppLocalizations.of(context)?.translate("city") ?? "",
                fontweight: FontWeight.w400,
                floating: FloatingLabelBehavior.auto,
                color: AppColor.textGrey,
              ),
            ),
            Visibility(
              visible: city1,
              child: Icon(
                Icons.check,
                color: AppColor.checkGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget streetField() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: TextFieldButton(
                controller: street,
                onChange: (val) {
                  setState(() {
                    _formKey.currentState!.validate();
                  });
                  if (val.isNotEmpty) {
                    street1 = true;
                  } else {
                    street1 = false;
                  }
                },
                validate: (val) {
                  if (val!.isEmpty) {
                    return "Please Enter Street";
                  }
                },
                inputType: TextInputType.text,
                textAlign: TextAlign.start,
                labelText:
                    AppLocalizations.of(context)?.translate("street") ?? "",
                fontweight: FontWeight.w400,
                floating: FloatingLabelBehavior.auto,
                color: AppColor.textGrey,
              ),
            ),
            Visibility(
              visible: street1,
              child: Icon(
                Icons.check,
                color: AppColor.checkGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget doorNoField() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: TextFieldButton(
                controller: doorNo,
                onChange: (val) {
                  setState(() {
                    _formKey.currentState!.validate();
                  });
                  if (val.isNotEmpty) {
                    doorNo1 = true;
                  } else {
                    doorNo1 = false;
                  }
                },
                validate: (val) {
                  if (val!.isEmpty) {
                    return "Please Enter Door Number";
                  }
                },
                inputType: TextInputType.emailAddress,
                textAlign: TextAlign.start,
                labelText:
                    AppLocalizations.of(context)?.translate("doorNo") ?? "",
                fontweight: FontWeight.w400,
                floating: FloatingLabelBehavior.auto,
                color: AppColor.textGrey,
              ),
            ),
            Visibility(
              visible: doorNo1,
              child: Icon(
                Icons.check,
                color: AppColor.checkGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget zipcodeField() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: TextFieldButton(
                controller: zipcode,
                onChange: (val) {
                  setState(() {
                    _formKey.currentState!.validate();
                  });
                  if (val.isNotEmpty) {
                    zipcode1 = true;
                  } else {
                    zipcode1 = false;
                  }
                },
                validate: (val) {
                  if (val!.isEmpty) {
                    return "Please Enter Zipcode";
                  }
                },
                inputType: TextInputType.number,
                textAlign: TextAlign.start,
                labelText:
                    AppLocalizations.of(context)?.translate("zipcode") ?? "",
                fontweight: FontWeight.w400,
                floating: FloatingLabelBehavior.auto,
                color: AppColor.textGrey,
              ),
            ),
            Visibility(
              visible: zipcode1,
              child: Icon(
                Icons.check,
                color: AppColor.checkGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget phoneField() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: TextFieldButton(
                controller: phone,
                onChange: (val) {
                  setState(() {
                    _formKey.currentState!.validate();
                  });
                  if (val.isNotEmpty) {
                    phone1 = true;
                  } else {
                    phone1 = false;
                  }
                },
                inputFormat: [LengthLimitingTextInputFormatter(10)],
                validate: (val) {
                  if (val!.isEmpty) {
                    return "Please Enter Phone";
                  } else if (AppValidation.isPhoneNumberValid(val)) {
                    return "Please Enter Valid Phone";
                  }
                },
                inputType: TextInputType.number,
                textAlign: TextAlign.start,
                labelText:
                    AppLocalizations.of(context)?.translate("phone") ?? "",
                fontweight: FontWeight.w400,
                floating: FloatingLabelBehavior.auto,
                color: AppColor.textGrey,
              ),
            ),
            Visibility(
              visible: phone1,
              child: Icon(
                Icons.check,
                color: AppColor.checkGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget alreadyHaveAccountField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)?.translate("alreadyHaveAnAccount") ?? "",
          style: FdStyle.sofia(
            fontSize: 14,
          ),
        ),
        IconButton(
            onPressed: () {
              openScreen(login);
            },
            icon: Icon(
              Icons.arrow_right_alt,
              color: AppColor.red1,
            ))
      ],
    );
  }

  Widget continueButtonField(context) {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ContainerButton(
            backGroundColor: AppColor.red1,
            buttonSize: 50,
            buttonTitle: AppLocalizations.of(context)?.translate("continue"),
            radius: 40,
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                try {
                  setState(() {
                    visible = true;
                  });
                  var userId = await DatabaseHelper().CreateUser(context,
                      username: name.text,
                      lastname: lastName.text,
                      email: email.text,
                      password: password.text,
                      city: city.text,
                      street: street.text,
                      doorNo: doorNo.text,
                      zipcode: zipcode.text,
                      dob: dob.text,
                      phone: phone.text);
                  Name nameObj =
                      Name(firstname: name.text, lastname: lastName.text);
                  Geolocation geolocation = Geolocation(lat: "", long: "");
                  Address address = Address(
                    geolocation: geolocation,
                    city: city.text,
                    street: street.text,
                    doorNumber: int.parse(doorNo.text),
                    zipcode: zipcode.text,
                  );
                  UserModelDB user = UserModelDB(
                    username: name.text,
                    address: address,
                    id: userId,
                    email: email.text,
                    password: password.text,
                    name: nameObj,
                    phone: phone.text,
                  );

                  var res = await context
                      .read<UserDataCubit>()
                      .createUserDB(context, body: user.toJson());
                  //     await APIHelper().createUserDetails(body: user.toJson());
                  // print(res);
                  setState(() {
                    visible = false;
                  });
                  openScreen(login);
                } catch (e) {
                  return DialogueHelper.showErrorDialog(
                      context, (e as ApiFailure).message, false);
                }
              }
            },
          ),
        );
      },
    );
  }

  Widget socialAccountTitle() {
    return Center(
      child: Text(
        AppLocalizations.of(context)?.translate("loginWithSocialAccount") ?? "",
        style: FdStyle.sofia(
          fontSize: 14,
        ),
      ),
    );
  }

  Widget socialAccountsField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            setState(() {
              visible = true;
            });
            await GoogleAuth().googleSignIn(context);
            setState(() {
              visible = false;
            });
          },
          child: Image.asset(
            "assets/images/Google.png",
            height: 100,
            width: 100,
          ),
        ),
        InkWell(
          onTap: () async {
            setState(() {
              visible = true;
            });
            await FBAuth().signInWithFacebook(context);
            setState(() {
              visible = false;
            });
          },
          child: Image.asset(
            "assets/images/Facebook.png",
            height: 100,
            width: 100,
          ),
        ),
      ],
    );
  }
}
