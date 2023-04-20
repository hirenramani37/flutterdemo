import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/modules/bank/model/bank_list_response.dart';
import 'package:customer/app/modules/bank/viewmodel/bank_viewmodel.dart';
import 'package:customer/app/modules/fetchcas/viewmodel/fetch_cas_controller.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:customer/util/connectivity_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BankDetailView extends StatefulWidget {
  final FetchCasController controller;

   const BankDetailView(this.controller, {Key? key}) : super(key: key);

  @override
  _BankDetailViewState createState() => _BankDetailViewState(controller);
}

class _BankDetailViewState extends State<BankDetailView> {
  late BankViewModel _service;
  List<BankList> bankList = [];
  String selectBank = "";

  _BankDetailViewState(FetchCasController _controller) {
    _controller.methodA = methodA;
  }

  Future<bool> methodA(int index) async {
    if(selectBank.isNotEmpty){
      if (ConnectivityUtils.instance.hasInternet) {
        var result = await _service.bankUsedLoan(selectBank);
        if(result?.code == 200){
            return true;
        }
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    _service = BankViewModel(context);
    getBankList();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ListView.builder(
                  itemCount: bankList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                          right: 16.w,
                          left: 16.w,
                          top: 16.h,
                          bottom: index == bankList.length - 1 ? 66.h : 0.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        border: Border.all(color: borderColor, width: 1),
                      ),
                      width: 110.w,
                      child: Row(
                        children: [
                          /*Image.asset(
                            LocaleKeys.ic_bank_dummy,
                            width: 60.w,
                          ),*/
                          Radio(
                              value: selectBank,
                              groupValue: "${bankList[index].bankId}",
                              onChanged: (value) {
                                setState(() {
                                  selectBank = "${bankList[index].bankId}";
                                });
                              }),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Bank Name",
                                  style: TextStyle(
                                      fontFamily: LocaleKeys.font_family,
                                      fontWeight: FontWeight.w600,
                                      color: unselectTab,
                                      fontSize: 10.sp),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  "${bankList[index].bankName}",
                                  style: TextStyle(
                                      fontFamily: LocaleKeys.font_family,
                                      fontWeight: FontWeight.w600,
                                      color: blackColor,
                                      fontSize: 11.sp),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 6.w,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Account No.",
                                style: TextStyle(
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w600,
                                    color: unselectTab,
                                    fontSize: 10.sp),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                "${bankList[index].accNo}",
                                style: TextStyle(
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w600,
                                    color: blackColor,
                                    fontSize: 11.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () async {
                var result = await Get.toNamed(Routes.BANK_ADD);
                if (result is bool) {
                  if (result) {
                    getBankList();
                  }
                }
              },
              child: Container(
                height: 40.h,
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    "+ADD NEW BANK",
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 14.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getBankList() async {
    if (ConnectivityUtils.instance.hasInternet) {
      var requestCas = await _service.getBankList();
      if (requestCas?.code == 200) {
        setState(() {
          bankList = (requestCas?.body?.bankList ?? []).reversed.toList();
          var temp =
              bankList.where((element) => element.selected ?? false).toList();
          selectBank = temp.isNotEmpty ? temp[0].bankId ?? "" : "";
        });
      }
    }
  }
}
