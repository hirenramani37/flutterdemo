import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/constant/constant.dart';
import 'package:customer/app/modules/authentication/viewmodel/authentication_viewmodel.dart';
import 'package:customer/app/modules/dashboard/model/EventModel.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:customer/util/connectivity_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BankMandateView extends StatefulWidget {
  const BankMandateView({Key? key}) : super(key: key);

  @override
  _BankMandateViewState createState() => _BankMandateViewState();
}



class _BankMandateViewState extends State<BankMandateView> {
  late AuthenticationViewModel _service;
  bool eMandate = false;
  bool physicalMandate = false;
  @override
  void initState() {
    _service = AuthenticationViewModel(context);
    checkMendateButton();
    super.initState();
  }

  Future<void> checkMendateButton() async {
    if(ConnectivityUtils.instance.hasInternet){
      var requestBankMandate = await _service.checkMandate();
      if(requestBankMandate?.code == 200){
        var data = requestBankMandate?.body;
        data?.types?.forEach((element) {
          if(element=="Net Banking"||element=="Debit Card"||element=="Aadhaar"){
            eMandate = true;
          }else if(element=="Physical"){
            physicalMandate = true;
          }
        });
        //if(data.)

       // tokenInitate = data?.token.toString()??"";
       // otpInitate = data?.otp??0;
       //  Fluttertoast.showToast(
       //      msg: otpInitate.toString(),
       //      toastLength: Toast.LENGTH_LONG,
       //      gravity: ToastGravity.BOTTOM,
       //      timeInSecForIosWeb: 1,
       //      backgroundColor: Colors.green,
       //      textColor: Colors.white,
       //      fontSize: 16.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            Visibility(
              visible: eMandate?true:false,
              child: Card(
                child: ListTile(
                  leading: Image.asset(
                    LocaleKeys.ic_bottom_report,
                    width: 24.w,
                    height: 24.h,
                    color: blackColor,
                  ),
                  title: const Text("E-Mandate"),
                  onTap: () {
                    Constant.eventBus.fire(PageChangeEvent(13));
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Visibility(
              visible: physicalMandate?true:false,
              child: Card(
                child: ListTile(
                  leading: Image.asset(
                    LocaleKeys.ic_bottom_report,
                    width: 24.w,
                    height: 24.h,
                    color: blackColor,
                  ),
                  title: const Text("Physical Mandate"),
                  onTap: () {
                    Constant.eventBus.fire(PageChangeEvent(14));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
