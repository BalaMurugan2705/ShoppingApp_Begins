import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_2/helper/api_helper.dart';
import 'package:food_app_2/widget/custom_scaffold.dart';
import 'package:food_app_2/widget/otp_field/otp_field.dart';
import '../cubit/userdata_cubit.dart';
import '../helper/Style.dart';
import '../helper/app_color.dart';
import '../helper/app_localizations.dart';
import '../helper/app_vaditations.dart';
import '../helper/dialog_helper.dart';
import '../helper/firebase_helper.dart';
import '../helper/nav_helper.dart';
import '../helper/preferenceHelper.dart';
import '../model/userModel_forDb.dart';
import '../widget/container_button.dart';
import '../widget/otp_field/otp_field_style.dart';
import '../widget/textFieldWidget.dart';

class LoginWithPhoneOtp extends StatefulWidget {
  LoginWithPhoneOtp({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneOtp> createState() => _LoginWithPhoneOtpState();
}

class _LoginWithPhoneOtpState extends State<LoginWithPhoneOtp> {
  TextEditingController phone = TextEditingController();

  ValueNotifier<bool> phone1 = ValueNotifier<bool>(false);

  OtpFieldController otpFieldController = OtpFieldController();

  TextEditingController phoneFieldController = TextEditingController();

  // ValueNotifier<bool> otp1 = ValueNotifier<bool>(false);

  bool verifyPhone = false;

  var _auth = FirebaseAuth.instance;
  var verificationId;
  var forceRefreshToken;
  bool isLoading = false;
  List<String> otpList = [];
  String otpValue = "";
  bool progressIndicatorVisible = false;
  bool resendCode = false;
  bool otpVisible = false;

  // MobileNumberPicker mobileNumber = MobileNumberPicker();
  // MobileNumber mobileNumber = MobileNumber();

  static const platform = MethodChannel("com.kb.ShoppingApp");

  @override
  void initState() {
    // FirebaseAuth.instance.userChanges().listen((event) {
    //   print(FirebaseAuth.instance.currentUser);
    //   print(event);
    // });
    // WidgetsBinding.instance
    //     .addPostFrameCallback((timeStamp) => mobileNumber.mobileNumber());
    // mobileNumber.getMobileNumberStream.listen((MobileNumber? event) {
    //   if (event?.states == PhoneNumberStates.PhoneNumberSelected) {
    //     setState(() {
    //       mobileNumberObject = event!;
    //       print(mobileNumberObject);
    //     });
    //   }
    // });
    // checkAvailablePhoneNumber();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scafold(
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                loginHeader(context),
                loginWithPhoneField(context, otpVisible),
                !isLoading
                    ? continueButtonField(context)
                    : Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          color: AppColor.red1,
                        ),
                      ),
              ],
            ),
            Visibility(
              visible: progressIndicatorVisible,
              child: DialogueHelper().progressIndicator(),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> loginWithPhone(BuildContext context) async {
  Widget loginHeader(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
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
            AppLocalizations.of(context)?.translate("loginWithMob") ?? "",
            style: FdStyle.sofiaTitle(color: AppColor.titleBlack),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
        ],
      ),
    );
  }

  Widget loginWithPhoneField(context, bool otpVisible) {
    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(left: 20, right: 20),
        //   child: phoneField(context),
        // ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: phoneFieldHint(context),
        ),
        Visibility(visible: otpVisible, child: otpField(context)),
      ],
    );
  }

  Widget phoneFieldHint(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),

      ),
    );
  }

  Widget phoneField(context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFieldButton(
                    controller: phone,
                    onChange: (val) {
                      if (val.isNotEmpty) {
                        phone1.value = true;
                      } else {
                        phone1.value = false;
                      }
                    },
                    validate: (value) {
                      if (AppValidation.isPhoneNumberValid(value!)) {
                        return "Enter Valid Mobile Number";
                      }
                    },
                    inputFormat: [
                      LengthLimitingTextInputFormatter(10),
                      //   // FilteringTextInputFormatter.allow(
                      //   //     RegExp(r'(\d(?:(\d{1,8}\.{1}\d?\d?)|(\d{1,8})))')),
                    ],
                    inputType: TextInputType.phone,
                    textAlign: TextAlign.start,
                    labelText:
                        AppLocalizations.of(context)?.translate("phone") ?? "",
                    fontweight: FontWeight.w400,
                    floating: FloatingLabelBehavior.auto,
                    color: AppColor.textGrey,
                  ),
                ),
                ValueListenableBuilder(
                    valueListenable: phone1,
                    builder: (context, bool val, child) {
                      return Visibility(
                        visible: val,
                        child: Icon(
                          Icons.check,
                          color: AppColor.checkGreen,
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget otpField(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      child: OTPTextField(
        length: 6,
        width: 300,
        spaceBetween: 10,
        controller: otpFieldController,
        otpFieldStyle: OtpFieldStyle(
            borderColor: Colors.red,
            focusBorderColor: Colors.red,
            enabledBorderColor: Colors.black),
        onChanged: (value) {
          otpValue = value;
          otpList.add(value);
        },
      ),
    );
  }

  Widget continueButtonField(context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ContainerButton(
        onTap: () {
          if (phone.text.isNotEmpty) {
            if (phone.text.contains("+")) {
              phone.text = phone.text.substring(3);
            }
            if (!AppValidation.isPhoneNumberValid(phone.text)) {
              setState(() {
                otpVisible = true;
              });
              verifyPhone
                  ? verifySms(otpValue)
                  : phoneSignIn(phoneNumber: phone.text);
            } else {
              DialogueHelper.showErrorDialog(
                  context, "Enter Valid Details to Login", false);
            }
          } else {
            DialogueHelper.showErrorDialog(
                context, "Enter the Details to Login", false);
          }
        },
        backGroundColor: AppColor.red1,
        buttonSize: 50,
        buttonTitle: verifyPhone
            ? AppLocalizations.of(context)?.translate("verify")
            : resendCode
                ? AppLocalizations.of(context)?.translate("resendCode")
                : AppLocalizations.of(context)?.translate("login"),
        radius: 40,
      ),
    );
  }

  Future<void> phoneSignIn({required String phoneNumber}) async {
    setState(() {
      isLoading = true;
    });
    await _auth.verifyPhoneNumber(
        phoneNumber: "+91" "$phoneNumber",
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: _onVerificationFailed,
        codeSent: _onCodeSent,
        codeAutoRetrievalTimeout: _onCodeTimeout);
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print("verification completed ${authCredential.smsCode}");
    // User? user = _auth.currentUser;
    List<String> smsValue = [];
    smsValue.add(authCredential.smsCode?.substring(0, 1) ?? "");
    smsValue.add(authCredential.smsCode?.substring(1, 2) ?? "");
    smsValue.add(authCredential.smsCode?.substring(2, 3) ?? "");
    smsValue.add(authCredential.smsCode?.substring(3, 4) ?? "");
    smsValue.add(authCredential.smsCode?.substring(4, 5) ?? "");
    smsValue.add(authCredential.smsCode?.substring(5) ?? "");
    setState(() {
      // this.otp.text = authCredential.smsCode!;
      this.otpFieldController.set(smsValue);
    });
    if (authCredential.smsCode != null) {
      var userCredential = await _auth.signInWithCredential(authCredential);
      var userDetails = userCredential.user;
      await DatabaseHelper().updateUser(
          name: userDetails?.displayName ?? "",
          lastname: "",
          email: userDetails?.email ?? "",
          password: "",
          city: "",
          street: "",
          doorNo: "",
          zipcode: "",
          phone: userDetails?.phoneNumber ?? "",
          uid: userDetails?.uid ?? "",
          image: userDetails?.photoURL ?? "");
      print(userDetails);
      var appUser = await DatabaseHelper.service?.getUserDetails();
      print(appUser?.name);
      UserModelDB user = UserModelDB();
      user.email = userCredential.user?.email ?? "";
      user.name =
          Name(firstname: userCredential.user?.displayName ?? "", lastname: "");
      user.phone = userCredential.user?.phoneNumber ?? "";
      user.password = "";
      user.username = userCredential.user?.displayName ?? "";
      user.id = userCredential.user?.uid ?? "";
      user.iV = 0;
      user.address = Address(
          geolocation: Geolocation(long: "", lat: ""),
          city: "",
          street: "",
          doorNumber: 0,
          zipcode: "");
      var res = await BlocProvider.of<UserDataCubit>(context)
          .createUserDB(context, body: user.toJson());
      print(res);
      setState(() {
        isLoading = false;
      });
      if (userCredential.user?.uid != "") {
        PreferenceHelper.saveInitialLogin();
        openScreen(dashBoard, requiresAsInitial: true);
        DialogueHelper().customToast(context,
            status: "Success",
            message: AppLocalizations.of(context)?.translate("successMsg"));
      } else {
        setState(() {
          isLoading = false;
          resendCode = true;
        });
        DialogueHelper().customToast(context,
            status: "Cancel",
            message: AppLocalizations.of(context)?.translate("cancelMsg"));
      }
    }
  }

  verifySms(String otpValue) async {
    try {
      setState(() {
        progressIndicatorVisible = true;
      });
      var authCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otpValue.trim());
      var userCredential = await _auth.signInWithCredential(authCredential);
      var userDetails = userCredential.user;
      await DatabaseHelper().updateUser(
          name: userDetails?.displayName ?? "",
          lastname: "",
          email: userDetails?.email ?? "",
          password: "",
          city: "",
          street: "",
          doorNo: "",
          zipcode: "",
          phone: userDetails?.phoneNumber ?? "",
          uid: userDetails?.uid ?? "",
          image: userDetails?.photoURL ?? "");
      print(userDetails);
      var appUser = await DatabaseHelper.service?.getUserDetails();
      print(appUser?.name);
      UserModelDB user = UserModelDB();
      user.email = userCredential.user?.email ?? "";
      user.name =
          Name(firstname: userCredential.user?.displayName ?? "", lastname: "");
      user.phone = userCredential.user?.phoneNumber ?? "";
      user.password = "";
      user.username = userCredential.user?.displayName ?? "";
      user.id = userCredential.user?.uid ?? "";
      user.iV = 0;
      user.address = Address(
          geolocation: Geolocation(long: "", lat: ""),
          city: "",
          street: "",
          doorNumber: 0,
          zipcode: "");
      var res = await BlocProvider.of<UserDataCubit>(context)
          .createUserDB(context, body: user.toJson());
      print(res);
      setState(() {
        progressIndicatorVisible = false;
      });
      if (userCredential.user?.uid != "") {
        print("verification completed $otpValue");
        PreferenceHelper.saveInitialLogin();
        openScreen(dashBoard, requiresAsInitial: true);
        DialogueHelper().customToast(context,
            status: "Success",
            message: AppLocalizations.of(context)?.translate("successMsg"));
      } else {
        DialogueHelper().customToast(context,
            status: "Cancel",
            message: AppLocalizations.of(context)?.translate("cancelMsg"));
      }
    } catch (e) {
      setState(() {
        progressIndicatorVisible = false;
      });
      DialogueHelper.showErrorDialog(
          context, (e as FirebaseAuthException).message ?? "", false);
    }
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    setState(() {
      isLoading = false;
      resendCode = true;
    });
    if (exception.code == 'invalid-phone-number') {
      String str = "The phone number entered is invalid!";
      DialogueHelper.showErrorDialog(context, str, false);
    } else {
      DialogueHelper.showErrorDialog(context, exception.message ?? "", false);
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) {
    this.verificationId = verificationId;
    this.forceRefreshToken = forceResendingToken;
    print(forceResendingToken);
    print("code sent");
  }

  _onCodeTimeout(String timeout) {
    setState(() {
      isLoading = false;
      verifyPhone = true;
    });
    return null;
  }

  void showMessage(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(errorMessage),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () async {
                  Navigator.of(builderContext).pop();
                },
              )
            ],
          );
        }).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  checkAvailablePhoneNumber() async {
    // var status = await MobileNumber.hasPhonePermission;

    // var res = await MobileNumber.getSimCards;
    // // var ph = await GetPhoneNumber().get();
    // print(res);

    // var res = MobileNumberPicker().mobileNumber().then((value) => print(value));
    // print(res);
    // final permission = await Permission.camera.status.isDenied;
    // if (permission) Permission.camera.request();
    try {
      var res = await platform.invokeMethod("getMobileNumber");
      print(res);
    } catch (e) {
      print(e);
    }
  }
}
