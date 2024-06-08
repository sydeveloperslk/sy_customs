library sy_customs;

import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<bool?> syConfirmPopUp(BuildContext context, String title, String content,
    {String? boldString, String? no, String? yes, Color? boldColor}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: content,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: boldString,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: boldColor ?? Colors.red,
                ),
              )
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(no ?? 'Cancel'),
          ),
          Visibility(
            visible: yes != "",
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                yes ?? 'Yes',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

Future<void> syShowAlert(
  BuildContext context,
  String title,
  String content,
) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}

void syLoadingBox(BuildContext context, String title) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: const LinearProgressIndicator(),
      );
    },
  );
}

void syErrorPrint(String s) {
  // ignore: avoid_print
  print("errorPrint $s");
}

void syResPrint(String url, String response) {
  // ignore: avoid_print
  print("resPrint url:$url response:$response ");
}

void syAlertPrint(String s) {
  // ignore: avoid_print
  print("alertPrint $s");
}

class SYUpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class SYBlurredUnit extends StatelessWidget {
  const SYBlurredUnit({
    super.key,
    required this.uint8list,
    required this.blurDouble,
    this.boxFit = BoxFit.fill,
  });
  final Uint8List uint8list;
  final double blurDouble;
  final BoxFit boxFit;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: MemoryImage(uint8list),
          fit: boxFit,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurDouble, sigmaY: blurDouble),
        child: Container(
          color: Colors.black.withOpacity(0.2134),
        ),
      ),
    );
  }
}

RichText sySomeBoldText(BuildContext context, String? text) {
  if (text == null) {
    return RichText(
      text: const TextSpan(),
    );
  }
  List<String> splitText = text.split('*');
  List<TextSpan> mTextSpans = [];

  for (int i = 0; i < splitText.length; i++) {
    if (i.isOdd) {
      mTextSpans.add(TextSpan(
        text: splitText[i],
        style: DefaultTextStyle.of(context)
            .style
            .copyWith(fontWeight: FontWeight.bold),
      ));
    } else {
      mTextSpans.add(TextSpan(
        text: splitText[i],
        style: DefaultTextStyle.of(context).style,
      ));
    }
  }
  return RichText(
    overflow: TextOverflow.ellipsis,
    text: TextSpan(
      children: mTextSpans,
    ),
  );
}

String syAvoidZero(double mDouble) {
  if (mDouble % 1 == 0) {
    return mDouble.floor().toString();
  }

  if ((mDouble * 100) % 1 == 0) {
    return mDouble.toString();
  } else {
    double r = (mDouble * 100).floor() / 100;
    return r.toString();
  }
}

String? syAvoidZeroNullable(double? mDouble) {
  if (mDouble == null) {
    return null;
  }
  return syAvoidZero(mDouble);
}

void syShowToast(BuildContext context, String text) {
  // ignore: avoid_print
  print("Tost showing $text");
  if (!kIsWeb) {
    if (Platform.isAndroid) {
      Fluttertoast.showToast(msg: text);
    } else if (Platform.isWindows) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class Nav {
  static void navigateTo(BuildContext context, Widget screen) {
    Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => screen,
        ));
  }

  static void pushRe(BuildContext context, Widget screen) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => screen,
    ));
  }

  static Future<void> pop(BuildContext context) async {
    Navigator.of(context).pop();
  }

  static void navigateWithBack(
      BuildContext context, Widget screen, Function() setState) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => screen));
    setState();
  }
}

class SYIcon extends StatelessWidget {
  const SYIcon({super.key, required this.data, this.size = 30});
  final String data;
  final double size;
  @override
  Widget build(BuildContext context) {
    String icon = 'packages/sy_customs/assets/icons/error.svg';
    switch (data.toLowerCase()) {
      case "lock":
        icon = 'packages/sy_customs/assets/svg/lock.svg';
        break;
      case "medal":
        icon = 'packages/sy_customs/assets/svg/medal.svg';
        break;
      case "danger":
        icon = 'packages/sy_customs/assets/svg/danger.svg';
        break;
      case "verify":
        icon = 'packages/sy_customs/assets/svg/ver.svg';
        break;
      case "star":
        icon = 'packages/sy_customs/assets/svg/star.svg';
        break;
      case "empty":
        icon = 'packages/sy_customs/assets/svg/empty.svg';
        break;
      case "app":
        icon = 'packages/sy_customs/assets/svg/playStore.svg';
        break;
      case "map":
        icon = 'packages/sy_customs/assets/svg/map.svg';
        break;
      case "construction":
        icon = 'packages/sy_customs/assets/svg/construction.svg';
        break;
      case "whatsapp":
        icon = 'packages/sy_customs/assets/svg/whatsapp.svg';
        break;
      case "no_update":
        icon = 'packages/sy_customs/assets/svg/no_update.svg';
        break;
      case "thinking":
        icon = 'packages/sy_customs/assets/svg/thinking.svg';
        break;
      case "form":
        icon = 'packages/sy_customs/assets/svg/form.svg';
        break;
      case "new_form":
        icon = 'packages/sy_customs/assets/svg/new_form.svg';
        break;
      case "house":
        icon = 'packages/sy_customs/assets/svg/house.svg';
        break;
      case "building":
        icon = 'packages/sy_customs/assets/svg/building.svg';
        break;
      case "all_form":
        icon = 'packages/sy_customs/assets/svg/all_form.svg';
        break;
      case "edit":
        icon = 'packages/sy_customs/assets/svg/edit.svg';
        break;
      case "users":
        icon = 'packages/sy_customs/assets/svg/users.svg';
        break;
      case "cash":
        icon = 'packages/sy_customs/assets/svg/cash.svg';
        break;
      case "bed":
        icon = 'packages/sy_customs/assets/svg/bed.svg';
        break;
      case "notice_board":
        icon = 'packages/sy_customs/assets/svg/notice_board.svg';
        break;
      case "calendar":
        icon = 'packages/sy_customs/assets/svg/calendar.svg';
        break;
      case "notice_board":
        icon = 'packages/sy_customs/assets/svg/notice_board.svg';
        break;
      case "notice_board":
        icon = 'packages/sy_customs/assets/svg/notice_board.svg';
        break;
      case "notice_board":
        icon = 'packages/sy_customs/assets/svg/notice_board.svg';
        break;
    }
    return SvgPicture.asset(
      icon,
      width: size,
      height: size,
    );
  }
}

Future<DateTime?> selectDateTime(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  if (pickedDate != null && context.mounted) {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      return DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    }
  }
  return null;
}

class SYHexColor extends Color {
  SYHexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}
