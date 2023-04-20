import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/modules/authentication/viewmodel/authentication_viewmodel.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:customer/util/connectivity_utils.dart';
import 'package:document_file_save_plus/document_file_save_plus.dart' as ds;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_filex/open_filex.dart';
//import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../util/file_utils.dart';

class PhysicalMandateView extends StatefulWidget {
  const PhysicalMandateView({Key? key}) : super(key: key);

  @override
  _PhysicalMandateViewState createState() => _PhysicalMandateViewState();
}

class _PhysicalMandateViewState extends State<PhysicalMandateView> {
  @override
  File? image;
  late AuthenticationViewModel _service;
  Uint8List? _bytesImage;
  bool dirDownloadExists = true;
  var directory;
  @override
  void initState() {
    _service = AuthenticationViewModel(context);
    super.initState();
  }

  void getDownloadMandate() async {
    if (ConnectivityUtils.instance.hasInternet) {
      var requestDownloadMandate = await _service.downloadMandate();
      if (requestDownloadMandate?.code == 200) {
        print("requestDownloadMandate${requestDownloadMandate?.message}");
        //if (requestDownloadMandate?.body.) {
        //   final prefs = await SharedPreferences.getInstance();
        //await prefs.setString('user_auth', jsonEncode(requestLonAuth?.body?.data![0]));

        // if(data?.ESA == "Done" && data?.ESP_CAMS == "Done" && data?.ESA == "Done"){
        //   Constant.eventBus.fire(PageChangeEvent(12));
        // }else{
        //   setState(() {
        //     ESIGN_ID_A = data?.ESIGN_ID_A.toString()??"";
        //     ESIGN_PDF_ID_A = data?.ESIGN_PDF_ID_A.toString()??"";
        //     agreementInitate(time, ESIGN_ID_A, ESIGN_PDF_ID_A);
        //     //if (data?.ESA == "Done" && data?.ESP_CAMS == "Done" && data?.ESA == "Done") {
        //     // }
        //   });
        // }
        //  }
        // setState(() {
        //   _bytesImage = Base64Decoder().convert(requestDownloadMandate?.body?.base64 ?? "");
        // });
        createPdf(requestDownloadMandate?.body?.base64 ?? "");
      }
    }
  }

  createPdf(String base64) async {
    var bytes = base64Decode(base64.replaceAll('\n', ''));
    final output = await getTemporaryDirectory();
   // var dir = await DownloadsPathProvider.downloadsDirectory;
    final file = File("${output.path}/example.pdf");
    await file.writeAsBytes(bytes.buffer.asUint8List());
    //final directory = (await getExternalStorageDirectories(type: StorageDirectory.downloads))?.first;
    print("${output.path}/example.pdf");
   // print("pathDownload${directory?.path}");
    OpenFilex.open("${output.path}/example.pdf");
    //String path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
  //  print("getExternalStoragePublicDirectory${path}");
  //  ds.DocumentFileSavePlus.saveFile(bytes, "my_sample_file.pdf", "appliation/pdf");
    //writeFile(bytes,"example.pdf");
    //await FileSaver.instance.saveFile("mandateNew", bytes,"pdf", mimeType: MimeType.PDF);
    // FileDownloader.downloadFile(
    //     url: "https://tinypng.com/images/social/website.jpg",
    //     name: "mandate",
    //     onDownloadCompleted: (path) {
    //       final File file = File(path);
    //       print(file.path);
    //       //This will be the path of the downloaded file
    //     });
    //await OpenFile.open("${output.path}/example.pdf");
    setState(() {});
  }



  Widget bottomSheetForSelectionFile(BuildContext context, ValueChanged<XFile> onFileSelection) {
    final ImagePicker imgpicker = ImagePicker();
    List<XFile> imagefiles;

    openImages() async {
      try {
        var pickedfiles = await imgpicker.pickMultiImage();
        //you can use ImageCourse.camera for Camera capture
        if(pickedfiles != null){
          imagefiles = pickedfiles;
        }else{
          print("No image is selected.");
        }
      }catch (e) {
        print("error while picking file.");
      }
    }
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(18.sp),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.sp),topRight: Radius.circular(10.sp))),
        child: Wrap(
          children: <Widget>[
            ListTile(
                leading: Icon(Icons.camera),
                title: Text("Take Photos"),
                onTap: () async {
                  Navigator.pop(context);

                  XFile? _documentFile = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 30);
                  onFileSelection(_documentFile!);
                }),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Gallery"),
              onTap: () async {
                Navigator.pop(context);
                XFile? _documentFile = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 40);

                print(_documentFile?.path);

                return onFileSelection(_documentFile!);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Future<File> writeFile(Uint8List data, String name) async {
  //   // storage permission ask
  //   var status = await Permission.storage.status;
  //   if (!status.isGranted) {
  //     await Permission.storage.request();
  //   }
  //   // the downloads folder path
  //   Directory tempDir = await DownloadsPathProvider.downloadsDirectory;
  //   String tempPath = tempDir.path;
  //   var filePath = tempPath + '/$name';
  //   _prepareSaveDir();
  //
  //
  //
  //   // the data
  //   var bytes = ByteData.view(data.buffer);
  //   final buffer = bytes.buffer;
  //   // save the data in the path
  //   return File(directory).writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  // }



  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "UPLOAD A SCANNED MANDATE",
                    style: TextStyle(
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w500,
                      color: blackColor,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () async {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Select Option'),
                              content: bottomSheetForSelectionFile(context, (file) {
                                setState(() async {

                                 // await Utils.pickImageFromGallery().then((pickedFile) async {
                                    if (file == null) return;
                                    await Utils.cropSelectedImage(file.path)
                                        .then((croppedFile) {
                                      if (croppedFile == null) return;

                                      setState(() {
                                        image = croppedFile;
                                      });
                                    });
                                 // });

                                 // attachment.text = file.name.toString();
                                 // product1 = file;
                                  // if (number == 1) {
                                  //   product1 = file;
                                  // }
                                  //
                                  // if (number == 2) {
                                  //   product2 = file;
                                  // }
                                  //
                                  // if (number == 3) {
                                  //   product3 = file;
                                  // }
                                });
                              }),
                            );
                          });

                    },
                    child: Container(
                      height: 130.w,
                      width: 130.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: dividerColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.r),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "+",
                          style: TextStyle(
                            color: dividerColor,
                            fontSize: 50.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  if (image != null) ...[
                    Container(
                      height: 200,
                      width: 200,
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(image!),
                        ),
                        // boxShadow: const [
                        //   BoxShadow(
                        //     offset: Offset(0, 4),
                        //     blurRadius: 10,
                        //     spreadRadius: -5,
                        //   )
                        // ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () async {
                      if(image!=null){
                        if (ConnectivityUtils.instance.hasInternet) {
                          var uploadFile = await _service.uploadFileMandate(image!);
                          if (uploadFile?.code == 200) {
                            var filepath = "${uploadFile?.body?.filePath}${uploadFile?.body?.fileName}";
                            print("filePath$filepath");
                            //setState(() {isFileUploaded = true;});
                            Fluttertoast.showToast(msg: uploadFile?.message ?? "",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            showPopup(context,filepath);
                          }
                        }
                      }else{

                      }
                     // final bytes = Io.File(imageBytes.path).readAsBytesSync();

                      //String img64 = base64Encode(bytes);

                    },
                    child: Container(
                      height: 40.w,
                      width: 130.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: dividerColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.r),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "UPLOAD",
                          style: TextStyle(
                            color: themeColor,
                            fontSize: 14.sp,
                            fontFamily: LocaleKeys.font_family,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () {
                      getDownloadMandate();
                    },
                    child: Text(
                      "Download Mandate +",
                      style: TextStyle(
                        fontFamily: LocaleKeys.font_family,
                        fontWeight: FontWeight.w700,
                        color: themeColor,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> showPopup(BuildContext context,String path) async {
    return await showDialog<bool>(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              color: whiteColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Alert",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 14.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Are you sure you want to submit this Image?",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 12.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Get.back();
                          setState(() {
                            // showError = true;
                          });
                        },
                        child: Container(
                          height: 30.h,
                          width: 100.w,
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          decoration: BoxDecoration(
                            color: unselectTab,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Close",
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
                      GestureDetector(
                        onTap: () async {
                          Get.back();
                          if (ConnectivityUtils.instance.hasInternet) {
                            var uploadFile = await _service.uploadFileFinal(path);
                            if (uploadFile?.code == 200) {
                              //setState(() {isFileUploaded = true;});
                            }
                          }
                          /*setState(() {
                            showError = false;
                          });
                          getAuthenticationUrl();*/
                          //Constant.eventBus.fire(PageChangeEvent(11));
                        },
                        child: Container(
                          height: 30.h,
                          width: 100.w,
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          decoration: BoxDecoration(
                            color: themeColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(11),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "OK",
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
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
