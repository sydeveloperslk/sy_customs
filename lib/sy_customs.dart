library sy_customs;

import 'dart:io';

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

void showToast(BuildContext context, String text) {
  // ignore: avoid_print
  print("Tost showing $text");
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
    String icon = 'assets/icons/gem.svg';
    switch (data.toLowerCase()) {
      case "medal":
        icon = 'assets/svg/medal.svg';
      case "danger":
        icon = 'assets/svg/danger.svg';
      case "verify":
        icon = 'assets/svg/ver.svg';
      case "star":
        icon = 'assets/svg/star.svg';
      case "empty":
        icon = 'assets/svg/empty.svg';
      case "app":
        icon = 'assets/svg/playStore.svg';
      case "map":
        icon = 'assets/svg/map.svg';
      case "construction":
        icon = 'assets/svg/construction.svg';
      case "whatsapp":
        icon = 'assets/svg/whatsapp.svg';
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
