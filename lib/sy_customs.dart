library sy_customs;

import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:gap/gap.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

Future<dynamic> syServerResponse(
  String url,
  Map<String, dynamic> requestBody, {
  bool? getError,
  bool? debug,
}) async {
  try {
    Uri? mmm = Uri.tryParse(url);
    if (mmm == null) {
      syErrorPrint("url is wrong url is :$url");
      return;
    }
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(requestBody),
    );
    if (response.statusCode == 200) {
      if (debug != null && debug) {
        syResPrint(url, response.body);
      }
      final data2 = json.decode(response.body);

      if (getError != null && getError) {
        return data2;
      }
      if (data2["status"] == "success") {
        return data2["message"];
      } else {
        syErrorPrint("Server  status = 'error' url is :$url");
      }
    } else {
      syErrorPrint(
          "Server  Error statusCode:${response.statusCode} url is :$url");
    }
  } catch (e) {
    syErrorPrint("Network error for server format error $url");
  }
}

String syFirstCapital(String name) {
  return name[0].toUpperCase() + name.substring(1);
}

List<String> syStringToList(String? data, int length) {
  if (data == null || data.isEmpty) {
    return List.filled(length, '');
  }

  List<String> words = data.split('');
  // If the number of words is less than the specified length, add empty strings
  while (words.length < length) {
    words.add('');
  }

  // If the number of words is more than the specified length, trim the list from the last
  if (words.length > length) {
    words = words.sublist(0, length);
  }

  return words;
}

Future<bool> syConfirmPopUp(BuildContext context, String title, String content,
    {String? boldString, String? no, String? yes, Color? boldColor}) async {
  bool? e = await showDialog(
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
  return e ?? false;
}

class PageUnderCons extends StatefulWidget {
  const PageUnderCons({super.key});

  @override
  State<PageUnderCons> createState() => _PageUnderConsState();
}

class _PageUnderConsState extends State<PageUnderCons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SYIcon(
              data: SYIconText.construction,
              size: 150,
            ),
            Gap(20),
            Text(
              "Page Under Contraction",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SYTab extends StatelessWidget {
  const SYTab({super.key, required this.bars, required this.tabs});
  final List<Widget> bars;
  final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: bars.length,
      child: Column(
        children: [
          TabBar(
            tabs: bars
                .map((bar) => Padding(
                      padding: const EdgeInsets.all(
                          8.0), // Adjust the padding as needed
                      child: bar,
                    ))
                .toList(),
          ),
          Expanded(
            child: TabBarView(
              children: tabs,
            ),
          ),
        ],
      ),
    );
  }
}

String syListToString(List<String> data) {
  return data.join();
}

Future<bool> syPreviewConfirmPopUp(
    BuildContext context, String title, String content,
    {String? boldString,
    String? no,
    String? yes,
    Color? boldColor,
    Widget? sample}) async {
  bool? d = await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: SingleChildScrollView(
            child: Column(
              children: [
                sample ?? Container(),
                RichText(
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
              ],
            ),
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
  return d ?? false;
}

String syRenameEmptyString(String data, String ifEmpty) {
  if (data.trim().isEmpty) {
    return ifEmpty;
  }
  return data;
}

List<double> syListToDouble(List<String> data) {
  return data.map((e) => double.tryParse(e) ?? 0.0).toList();
}

int syListToInt(List<String> data) {
  return int.parse(
      data.map((e) => int.tryParse(e) ?? 0).toList().join().toString());
}

class DateOfBirthSelector extends StatefulWidget {
  const DateOfBirthSelector(
      {super.key, required this.selected, this.old, this.options});
  final Function(DateTime) selected;
  final DateTime? old;
  final TextStyle? options;

  @override
  State<DateOfBirthSelector> createState() => _DateOfBirthSelectorState();
}

class _DateOfBirthSelectorState extends State<DateOfBirthSelector> {
  int? selectedYear;
  int? selectedMonth;
  int? selectedDay;

  @override
  void initState() {
    super.initState();
    if (widget.options != null) {
      options = widget.options!;
    }
    if (widget.old != null) {
      selectedYear = widget.old!.year;
      selectedMonth = widget.old!.month;
      selectedDay = widget.old!.day;
    }
  }

  void _onDateChanged() {
    if (selectedYear != null && selectedMonth != null && selectedDay != null) {
      DateTime selectedDate =
          DateTime(selectedYear!, selectedMonth!, selectedDay!);
      widget.selected(selectedDate);
    }
  }

  TextStyle options = const TextStyle(fontFamily: 'raleway', fontSize: 20);

  @override
  Widget build(BuildContext context) {
    List<int> years = List<int>.generate(101, (i) => DateTime.now().year - i);
    List<int> months = List<int>.generate(12, (i) => i + 1);
    List<int> days = selectedYear != null && selectedMonth != null
        ? List<int>.generate(
            DateTime(selectedYear!, selectedMonth! + 1, 0).day, (i) => i + 1)
        : [];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(20),
            Text("Date of Birth", style: options),
            const Gap(20),
            const Gap(20),
            Text(
                "Selected ${selectedYear ?? "YYYY"}-${selectedMonth ?? "MM"}-${selectedDay ?? "DD"} ",
                style: options.copyWith(fontFamily: "apple")),
            const Spacer(),
            DropdownButton<int>(
              hint: const Text("Year"),
              value: selectedYear,
              items: years.map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString(), style: options),
                );
              }).toList(),
              onChanged: (value) {
                if (selectedYear != null &&
                    selectedMonth != null &&
                    selectedDay != null) {
                  widget.selected(
                      DateTime(selectedYear!, selectedMonth!, selectedDay!));
                }
                setState(() {
                  selectedYear = value;
                });
                _onDateChanged();
              },
            ),
            const Gap(20),
            DropdownButton<int>(
              hint: const Text("Month"),
              value: selectedMonth,
              items: months.map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString(), style: options),
                );
              }).toList(),
              onChanged: (value) {
                if (selectedYear != null &&
                    selectedMonth != null &&
                    selectedDay != null) {
                  widget.selected(
                      DateTime(selectedYear!, selectedMonth!, selectedDay!));
                }
                setState(() {
                  selectedMonth = value;
                });
                _onDateChanged();
              },
            ),
            const Gap(20),
            DropdownButton<int>(
              hint: const Text("Day"),
              value: selectedDay,
              items: days.map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString(), style: options),
                );
              }).toList(),
              onChanged: (value) {
                if (selectedYear != null &&
                    selectedMonth != null &&
                    selectedDay != null) {
                  widget.selected(
                      DateTime(selectedYear!, selectedMonth!, selectedDay!));
                }
                setState(() {
                  selectedDay = value;
                });
                _onDateChanged();
              },
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

class SYTextField extends StatefulWidget {
  const SYTextField({
    super.key,
    this.borderColor = Colors.black,
    this.focusBorderColor = Colors.black,
    required this.label,
    this.old,
    this.textStyle = const TextStyle(),
    required this.onChanged,
    this.optionList,
    this.onSubmitted,
    this.selectedFromList,
    this.focusNode,
    this.prefixIcon,
    this.numericType, // Updated to accept SYNumeric
  });

  final Widget? prefixIcon;
  final Color borderColor;
  final Color focusBorderColor;
  final List<String>? optionList;
  final String label;
  final String? old;
  final TextStyle textStyle;
  final Function(String) onChanged;
  final Function(String)? onSubmitted;
  final Function(String)? selectedFromList;
  final FocusNode? focusNode;
  final SYNumeric? numericType; // Added SYNumeric

  @override
  State<SYTextField> createState() => _SYTextFieldState();
}

class _SYTextFieldState extends State<SYTextField> {
  String goingToAdd = "";

  @override
  Widget build(BuildContext context) {
    Color? borderColor;
    Color? focusBorderColor;
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    if (isDarkMode) {
      borderColor = Colors.white;
      focusBorderColor = Colors.white;
    }

    // Determine keyboardType and inputFormatters based on SYNumeric type
    TextInputType keyboardType = TextInputType.text;
    List<TextInputFormatter>? inputFormatters;

    if (widget.numericType == SYNumeric.intValue) {
      keyboardType = TextInputType.number;
      inputFormatters = [FilteringTextInputFormatter.digitsOnly];
    } else if (widget.numericType == SYNumeric.doubleValue) {
      keyboardType = const TextInputType.numberWithOptions(decimal: true);
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
      ];
    }

    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (widget.optionList == null) {
          return const Iterable<String>.empty();
        }

        List<String> h = widget.optionList!.where((String option) {
          return option
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
        if (textEditingValue.text.isNotEmpty &&
            !h.contains(textEditingValue.text.toLowerCase())) {
          h.add(textEditingValue.text.toLowerCase());
          goingToAdd = textEditingValue.text.toLowerCase();
        } else {
          goingToAdd = "";
        }

        return h.map((f) => sySentenceCase(f)).toList();
      },
      optionsViewBuilder: widget.optionList == null
          ? null
          : (BuildContext context, AutocompleteOnSelected<String> onSelected,
              Iterable<String> options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Container(
                  color: const Color.fromARGB(156, 0, 0, 0),
                  width: 300,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      String option = options.elementAt(index);

                      return Card(
                        color: const Color.fromARGB(255, 249, 237, 237),
                        child: ListTile(
                          onTap: () async {
                            if (goingToAdd == option) {
                              bool? c = await syConfirmPopUp(
                                  context,
                                  "Confirm Add",
                                  "Do you need to add new value $option");
                              if (c) {
                                onSelected(option);
                              }
                            } else {
                              onSelected(option);
                            }
                          },
                          title: Text(option),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
      onSelected: (dd) {
        if (widget.onSubmitted != null) {
          widget.onSubmitted!(dd);
        }
        if (widget.selectedFromList != null) {
          widget.selectedFromList!(dd);
        }
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        if (widget.old != null) {
          String d = widget.old!;
          if (widget.numericType == SYNumeric.doubleValue ||
              widget.numericType == SYNumeric.intValue) {
            d = d.replaceAll(",", "");
          }
          textEditingController.text = d;
        }

        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: TextField(
            controller: textEditingController,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            focusNode: widget.focusNode ?? focusNode,
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              enabledBorder: borderColor == null
                  ? const OutlineInputBorder()
                  : OutlineInputBorder(
                      borderSide: BorderSide(color: borderColor),
                    ),
              focusedBorder: focusBorderColor == null
                  ? const OutlineInputBorder()
                  : OutlineInputBorder(
                      borderSide:
                          BorderSide(color: focusBorderColor, width: 2.0),
                    ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2.0),
              ),
              label: Text(
                widget.label,
                style: widget.textStyle,
              ),
              suffixIcon: widget.onSubmitted == null
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        widget.onSubmitted!(textEditingController.text);
                      },
                      icon: const Icon(Icons.check)),
            ),
            onSubmitted: (dd) {
              if (widget.onSubmitted != null) {
                widget.onSubmitted!(dd);
              }
            },
            onChanged: (dd) {
              widget.onChanged(dd.trim());
            },
          ),
        );
      },
    );
  }
}

class SySlideButton extends StatefulWidget {
  const SySlideButton({
    super.key,
    required this.text,
    this.fontSize = 15,
    this.onFinished,
    required this.onSlide,
    required this.active,
  });
  final double fontSize;
  final bool active;
  final String text;
  final Function() onSlide;
  final Function()? onFinished;
  @override
  State<SySlideButton> createState() => _SySlideButtonState();
}

class _SySlideButtonState extends State<SySlideButton> {
  bool isFinished = false;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SwipeableButtonView(
        isActive: widget.active,
        buttonText: 'Slide to ${widget.text}',
        buttontextstyle:
            TextStyle(fontSize: widget.fontSize, color: Colors.white),
        buttonWidget:
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey),
        activeColor: const Color(0xFF009C41),
        onWaitingProcess: () async {
          await widget.onSlide();
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              setState(() => isFinished = true);
            }
          });
        },
        isFinished: isFinished,
        onFinish: () async {
          if (mounted) {
            setState(() => isFinished = false);
          }
          widget.onFinished != null ? widget.onFinished!() : null;
        },
      ),
    );
  }
}

String syFormatNumber(int number) {
  // Create a NumberFormat instance for grouping by thousands
  final NumberFormat numberFormat = NumberFormat('#,##0');
  return numberFormat.format(number);
}

String? sySentenceCaseNullable(String? old) {
  if (old == null) {
    return null;
  }
  if (old.isEmpty) {
    return old;
  }
  return old.split(' ').map((word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
}

String sySentenceCase(String old) {
  if (old.isEmpty) {
    return old;
  }
  return old.split(' ').map((word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
}

class SYOnDebugText extends StatelessWidget {
  const SYOnDebugText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) {
      return Container();
    }
    return Text(
      "Debug: $text",
      style: const TextStyle(color: Colors.red),
    );
  }
}

Future<void> syShowAlert(
  BuildContext context,
  String title,
  String content,
) async {
  print("SY showing Alert $title $content");
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
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

class SYBox extends StatelessWidget {
  const SYBox({super.key, required this.size, required this.child});
  final double size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size, height: size, child: child);
  }
}

String syAvoidExtraZero(double mDouble, {bool? isDoubleFixed}) {
  if (isDoubleFixed != null && isDoubleFixed) {
    final NumberFormat numberFormat = NumberFormat('#,##0.00');
    return numberFormat.format(mDouble);
  } else if (mDouble % 1 == 0) {
    final NumberFormat numberFormat = NumberFormat('#,##0');
    return numberFormat.format(mDouble.floor());
  } else if ((mDouble * 10) % 1 == 0) {
    final NumberFormat numberFormat = NumberFormat('#,##0.00');
    return numberFormat.format(mDouble);
  } else {
    double r = (mDouble * 100).floor() / 100;
    final NumberFormat numberFormat = NumberFormat('#,##0.00');
    return numberFormat.format(r);
  }
}

String? syAvoidExtraZeroNullable(double? mDouble, {bool? isDoubleFixed}) {
  if (mDouble == null) {
    return null;
  }
  return syAvoidExtraZero(mDouble, isDoubleFixed: isDoubleFixed);
}

double syMod(double double) {
  if (double < 0) {
    return double * -1;
  }
  return double;
}

AppBar syAppBar(String title) {
  return AppBar(
    title: Text(title),
  );
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
  static Future<T?> navigateTo<T>(BuildContext context, Widget screen) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute<T>(
        builder: (BuildContext context) => screen,
      ),
    );
  }

  static void pushRe(BuildContext context, Widget screen) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => screen,
    ));
  }

  static Future<void> pop(BuildContext context) async {
    bool canPop = Navigator.of(context).canPop();
    if (canPop) {
      Navigator.of(context).pop(); // Close this screen and go back
    }
  }

  static void navigateWithBack(
      BuildContext context, Widget screen, Function() setState) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => screen));
    setState();
  }
}

enum SYIconText {
  personRelation('personRelation'),
  fingerPrint('fingerPrint'),
  notification('notification'),
  invoice('invoice'),
  bell('bell'),
  chick('chick'),
  medicine('medicine'),
  chickenLayEgg('chickenLayEgg'),
  chickenFeed('chickenFeed'),
  grow('grow'),
  eBill('eBill'),
  boost('boost'),
  inspect('inspect'),
  orders('orders'),
  request('request'),
  cashOut('cashOut'),
  donation('donation'),
  more('more'),
  pending('pending'),
  rejected('rejected'),
  lock('lock'),
  duplicate('duplicate'),
  cage('cage'),
  sale('sale'),
  lorryLoading('lorryLoading'),
  egg('egg'),
  box('box'),
  eggTray('eggTray'),
  store('store'),
  lorry('lorry'),
  eggBroken('eggBroken'),
  idCard('idCard'),
  nic('nic'),
  phone('phone'),
  pob('pob'),
  muslimMan('muslimMan'),
  muslimWoman('muslimWoman'),
  newBar('newBar'),
  switchBar('switchBar'),
  approved('approved'),
  medal('medal'),
  users('users'),
  masjid('masjid'),
  masjid_2('masjid_2'),
  edit('edit'),
  allForm('allForm'),
  calendar('calendar'),
  bed('bed'),
  cash('cash'),
  noticeBoard('noticeBoard'),
  googleMapColored('googleMapColored'),
  danger('danger'),
  verify('verify'),
  empty('empty'),
  star('star'),
  app('app'),
  map('map'),
  map2('map2'),
  yeezzLogo('yeezzLogo'),
  go('go'),
  construction('construction'),
  form('form'),
  thinking('thinking'),
  chicken('chicken'),
  whatsapp('whatsapp'),
  eggWaste('eggWaste'),
  eggLaid('eggLaid'),
  list('list'),
  noUpdate('noUpdate'),
  send('send'),
  analysis('analysis'),
  building('building'),
  chat('chat'),
  newForm('newForm'),
  pdf('pdf'),
  accounts('accounts'),
  customize('customize'),
  gender('gender'),
  bullet('bullet'),
  chickenFeeding('chickenFeeding'),
  shortage('shortage'),
  house('house');

  const SYIconText(this.status);

  final String status;

  @override
  String toString() {
    return status;
  }

  static SYIconText fromString(String? status) {
    switch (status) {
      case 'accounts':
        return SYIconText.accounts;
      case 'pdf':
        return SYIconText.pdf;
      case 'masjid_2':
        return SYIconText.masjid_2;
      case 'invoice':
        return SYIconText.invoice;
      case 'bell':
        return SYIconText.bell;
      case 'chick':
        return SYIconText.chick;
      case 'medicine':
        return SYIconText.medicine;
      case 'chickenLayEgg':
        return SYIconText.chickenLayEgg;
      case 'chickenFeed':
        return SYIconText.chickenFeed;
      case 'grow':
        return SYIconText.grow;
      case 'eBill':
        return SYIconText.eBill;
      case 'boost':
        return SYIconText.boost;
      case 'eggLaid':
        return SYIconText.eggLaid;
      case 'inspect':
        return SYIconText.inspect;
      case 'orders':
        return SYIconText.orders;
      case 'analysis':
        return SYIconText.analysis;
      case 'notification':
        return SYIconText.notification;
      case 'masjid':
        return SYIconText.masjid;
      case 'lock':
        return SYIconText.lock;
      case 'more':
        return SYIconText.more;
      case 'duplicate':
        return SYIconText.duplicate;
      case 'cage':
        return SYIconText.cage;
      case 'lorryLoading':
        return SYIconText.lorryLoading;
      case 'sale':
        return SYIconText.sale;
      case 'lorry':
        return SYIconText.lorry;
      case 'store':
        return SYIconText.store;
      case 'egg':
        return SYIconText.egg;
      case 'eggBroken':
        return SYIconText.eggBroken;
      case 'eggTray':
        return SYIconText.eggTray;
      case 'box':
        return SYIconText.box;
      case 'go':
        return SYIconText.go;
      case 'idCard':
        return SYIconText.idCard;
      case 'nic':
        return SYIconText.nic;
      case 'phone':
        return SYIconText.phone;
      case 'pob':
        return SYIconText.pob;
      case 'muslimMan':
        return SYIconText.muslimMan;
      case 'muslimWoman':
        return SYIconText.muslimWoman;
      case 'newBar':
        return SYIconText.newBar;
      case 'switchBar':
        return SYIconText.switchBar;
      case 'approved':
        return SYIconText.approved;
      case 'medal':
        return SYIconText.medal;
      case 'users':
        return SYIconText.users;
      case 'edit':
        return SYIconText.edit;
      case 'allForm':
        return SYIconText.allForm;
      case 'request':
        return SYIconText.request;
      case 'calendar':
        return SYIconText.calendar;
      case 'bed':
        return SYIconText.bed;
      case 'cash':
        return SYIconText.cash;
      case 'noticeBoard':
        return SYIconText.noticeBoard;
      case 'googleMapColored':
        return SYIconText.googleMapColored;
      case 'danger':
        return SYIconText.danger;
      case 'verify':
        return SYIconText.verify;
      case 'empty':
        return SYIconText.empty;
      case 'star':
        return SYIconText.star;
      case 'app':
        return SYIconText.app;
      case 'gender':
        return SYIconText.gender;
      case 'bullet':
        return SYIconText.bullet;
      case 'shortage':
        return SYIconText.shortage;
      case 'map2':
        return SYIconText.map2;
      case 'map':
        return SYIconText.map;
      case 'construction':
        return SYIconText.construction;
      case 'form':
        return SYIconText.form;
      case 'thinking':
        return SYIconText.thinking;
      case 'chicken':
        return SYIconText.chicken;
      case 'whatsapp':
        return SYIconText.whatsapp;
      case 'noUpdate':
        return SYIconText.noUpdate;
      case 'building':
        return SYIconText.building;
      case 'newForm':
        return SYIconText.newForm;
      case 'house':
        return SYIconText.house;
      case 'customize':
        return SYIconText.customize;
      case 'rejected':
        return SYIconText.rejected;
      case 'pending':
        return SYIconText.pending;
      case 'personRelation':
        return SYIconText.personRelation;
      case 'fingerPrint':
        return SYIconText.fingerPrint;
      case 'yeezzLogo':
        return SYIconText.yeezzLogo;
      case 'chat':
        return SYIconText.chat;
      case 'eggWaste':
        return SYIconText.eggWaste;
      case 'send':
        return SYIconText.send;
      case 'list':
        return SYIconText.list;
      case 'donation':
        return SYIconText.donation;
      case 'cashOut':
        return SYIconText.cashOut;
      case 'chickenFeeding':
        return SYIconText.chickenFeeding;
    }
    return SYIconText.construction;
  }
}

class SYIcon extends StatelessWidget {
  const SYIcon({super.key, required this.data, this.size = 30});
  final SYIconText data;
  final double size;
  @override
  Widget build(BuildContext context) {
    String icon = 'packages/sy_customs/assets/icons/error.svg';
    switch (data) {
      case SYIconText.notification:
        icon = 'packages/sy_customs/assets/svg/notification.svg';
      case SYIconText.more:
        icon = 'packages/sy_customs/assets/svg/more.svg';
      case SYIconText.cashOut:
        icon = 'packages/sy_customs/assets/svg/cashOut.svg';
      case SYIconText.donation:
        icon = 'packages/sy_customs/assets/svg/donation.svg';
      case SYIconText.chickenFeeding:
        icon = 'packages/sy_customs/assets/svg/chickenFeeding.svg';
      case SYIconText.eggLaid:
        icon = 'packages/sy_customs/assets/svg/eggLaid.svg';
      case SYIconText.invoice:
        icon = 'packages/sy_customs/assets/svg/invoice.svg';
      case SYIconText.bell:
        icon = 'packages/sy_customs/assets/svg/bell.svg';
      case SYIconText.chick:
        icon = 'packages/sy_customs/assets/svg/chick.svg';
      case SYIconText.medicine:
        icon = 'packages/sy_customs/assets/svg/medicine.svg';
      case SYIconText.chickenLayEgg:
        icon = 'packages/sy_customs/assets/svg/chickenLayEgg.svg';
      case SYIconText.chickenFeed:
        icon = 'packages/sy_customs/assets/svg/chickenFeed.svg';
      case SYIconText.grow:
        icon = 'packages/sy_customs/assets/svg/grow.svg';
      case SYIconText.eBill:
        icon = 'packages/sy_customs/assets/svg/eBill.svg';
      case SYIconText.boost:
        icon = 'packages/sy_customs/assets/svg/boost.svg';
      case SYIconText.inspect:
        icon = 'packages/sy_customs/assets/svg/inspect.svg';
      case SYIconText.orders:
        icon = 'packages/sy_customs/assets/svg/orders.svg';
      case SYIconText.request:
        icon = 'packages/sy_customs/assets/svg/request.svg';
      case SYIconText.accounts:
        icon = 'packages/sy_customs/assets/svg/accounts.svg';
      case SYIconText.chat:
        icon = 'packages/sy_customs/assets/svg/chat.svg';
      case SYIconText.masjid_2:
        icon = 'packages/sy_customs/assets/svg/masjid_2.svg';
      case SYIconText.list:
        icon = 'packages/sy_customs/assets/svg/list.svg';
      case SYIconText.pdf:
        icon = 'packages/sy_customs/assets/svg/pdf.svg';
      case SYIconText.analysis:
        icon = 'packages/sy_customs/assets/svg/analysis.svg';
      case SYIconText.personRelation:
        icon = 'packages/sy_customs/assets/svg/personRelation.svg';
        break;
      case SYIconText.send:
        icon = 'packages/sy_customs/assets/svg/send.svg';
        break;
      case SYIconText.masjid:
        icon = 'packages/sy_customs/assets/svg/masjid.svg';
        break;
      case SYIconText.go:
        icon = 'packages/sy_customs/assets/svg/go.svg';
        break;
      case SYIconText.rejected:
        icon = 'packages/sy_customs/assets/svg/rejected.svg';
        break;
      case SYIconText.pending:
        icon = 'packages/sy_customs/assets/svg/pending.svg';
        break;
      case SYIconText.customize:
        icon = 'packages/sy_customs/assets/svg/customize.svg';
        break;
      case SYIconText.phone:
        icon = 'packages/sy_customs/assets/svg/phone.svg';
        break;
      case SYIconText.fingerPrint:
        icon = 'packages/sy_customs/assets/svg/fingerPrint.svg';
      case SYIconText.pob:
        icon = 'packages/sy_customs/assets/svg/pob.svg';
        break;
      case SYIconText.gender:
        icon = 'packages/sy_customs/assets/svg/gender.svg';
        break;
      case SYIconText.bullet:
        icon = 'packages/sy_customs/assets/svg/bullet.svg';
        break;
      case SYIconText.shortage:
        icon = 'packages/sy_customs/assets/svg/shortage.svg';
        break;
      case SYIconText.idCard:
        icon = 'packages/sy_customs/assets/svg/id_card.svg';
        break;
      case SYIconText.nic:
        icon = 'packages/sy_customs/assets/svg/nic.svg';
        break;
      case SYIconText.duplicate:
        icon = 'packages/sy_customs/assets/svg/duplicate.svg';
        break;
      case SYIconText.cage:
        icon = 'packages/sy_customs/assets/svg/cage.svg';
        break;
      case SYIconText.lorryLoading:
        icon = 'packages/sy_customs/assets/svg/lorryLoading.svg';
        break;
      case SYIconText.sale:
        icon = 'packages/sy_customs/assets/svg/sale.svg';
        break;
      case SYIconText.lorry:
        icon = 'packages/sy_customs/assets/svg/lorry.svg';
        break;
      case SYIconText.egg:
        icon = 'packages/sy_customs/assets/svg/egg.svg';
        break;
      case SYIconText.store:
        icon = 'packages/sy_customs/assets/svg/store.svg';
        break;
      case SYIconText.eggBroken:
        icon = 'packages/sy_customs/assets/svg/eggBroken.svg';
        break;
      case SYIconText.box:
        icon = 'packages/sy_customs/assets/svg/box.svg';
        break;
      case SYIconText.eggTray:
        icon = 'packages/sy_customs/assets/svg/eggTray.svg';
        break;
      case SYIconText.lock:
        icon = 'packages/sy_customs/assets/svg/lock.svg';
        break;
      case SYIconText.medal:
        icon = 'packages/sy_customs/assets/svg/medal.svg';
        break;
      case SYIconText.danger:
        icon = 'packages/sy_customs/assets/svg/danger.svg';
        break;
      case SYIconText.verify:
        icon = 'packages/sy_customs/assets/svg/ver.svg';
        break;
      case SYIconText.star:
        icon = 'packages/sy_customs/assets/svg/star.svg';
        break;
      case SYIconText.empty:
        icon = 'packages/sy_customs/assets/svg/empty.svg';
        break;
      case SYIconText.app:
        icon = 'packages/sy_customs/assets/svg/playStore.svg';
        break;
      case SYIconText.map:
        icon = 'packages/sy_customs/assets/svg/map.svg';
        break;
      case SYIconText.eggWaste:
        icon = 'packages/sy_customs/assets/svg/eggWaste.svg';
        break;
      case SYIconText.map2:
        icon = 'packages/sy_customs/assets/svg/map2.svg';
        break;
      case SYIconText.construction:
        icon = 'packages/sy_customs/assets/svg/construction.svg';
        break;
      case SYIconText.whatsapp:
        icon = 'packages/sy_customs/assets/svg/whatsapp.svg';
        break;
      case SYIconText.noUpdate:
        icon = 'packages/sy_customs/assets/svg/no_update.svg';
        break;
      case SYIconText.thinking:
        icon = 'packages/sy_customs/assets/svg/thinking.svg';
        break;
      case SYIconText.chicken:
        icon = 'packages/sy_customs/assets/svg/chicken.svg';
        break;
      case SYIconText.form:
        icon = 'packages/sy_customs/assets/svg/form.svg';
        break;
      case SYIconText.newForm:
        icon = 'packages/sy_customs/assets/svg/new_form.svg';
        break;
      case SYIconText.house:
        icon = 'packages/sy_customs/assets/svg/house.svg';
        break;
      case SYIconText.building:
        icon = 'packages/sy_customs/assets/svg/building.svg';
        break;
      case SYIconText.allForm:
        icon = 'packages/sy_customs/assets/svg/all_form.svg';
        break;
      case SYIconText.edit:
        icon = 'packages/sy_customs/assets/svg/edit.svg';
        break;
      case SYIconText.users:
        icon = 'packages/sy_customs/assets/svg/users.svg';
        break;
      case SYIconText.cash:
        icon = 'packages/sy_customs/assets/svg/cash.svg';
        break;
      case SYIconText.bed:
        icon = 'packages/sy_customs/assets/svg/bed.svg';
        break;
      case SYIconText.noticeBoard:
        icon = 'packages/sy_customs/assets/svg/notice_board.svg';
        break;
      case SYIconText.calendar:
        icon = 'packages/sy_customs/assets/svg/calendar.svg';
        break;
      case SYIconText.googleMapColored:
        icon = 'packages/sy_customs/assets/svg/google_map_colored.svg';
        break;
      case SYIconText.muslimMan:
        icon = 'packages/sy_customs/assets/svg/muslim_man.svg';
        break;
      case SYIconText.muslimWoman:
        icon = 'packages/sy_customs/assets/svg/muslim_woman.svg';
        break;
      case SYIconText.newBar:
        icon = 'packages/sy_customs/assets/svg/new.svg';
        break;
      case SYIconText.switchBar:
        icon = 'packages/sy_customs/assets/svg/switch.svg';
        break;
      case SYIconText.approved:
        icon = 'packages/sy_customs/assets/svg/approved.svg';
        break;
      case SYIconText.yeezzLogo:
        icon = 'packages/sy_customs/assets/svg/yeezzLogo.svg';
        break;
    }
    return SvgPicture.asset(
      icon,
      width: size,
      height: size,
    );
  }
}

enum DateTimeSelectionMode { dateOnly, timeOnly, dateAndTime, dateWithOutYear }

Future<DateTime?> sySelectDateTime(BuildContext context,
    DateTimeSelectionMode mode, DateTime? selectedDate) async {
  TimeOfDay? selectedTime;

  if (mode == DateTimeSelectionMode.dateOnly ||
      mode == DateTimeSelectionMode.dateAndTime) {
    if (!context.mounted) return null;
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      selectedDate = pickedDate;
    }
  }

  if (mode == DateTimeSelectionMode.timeOnly ||
      mode == DateTimeSelectionMode.dateAndTime) {
    if (!context.mounted) return null;
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      // int hour = pickedTime.hour;
      // // Adjust for AM/PM directly
      // if (hour < 12 && !pickedTime.period.index.isOdd) {
      //   print("Convert to PM hour");
      //   hour += 12; // Convert to PM hour
      // } else if (hour == 12 && pickedTime.period.index.isOdd) {
      //   print("AM hour");
      //   hour = 0; // Convert 12 AM to 0 hour
      // }

      selectedTime = TimeOfDay(
        hour: pickedTime.hour,
        minute: pickedTime.minute,
      );
    }
  }

  if (mode == DateTimeSelectionMode.dateOnly && selectedDate != null) {
    return DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
  }

  if (mode == DateTimeSelectionMode.timeOnly && selectedTime != null) {
    final now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
    );
  }

  if (mode == DateTimeSelectionMode.dateAndTime &&
      selectedDate != null &&
      selectedTime != null) {
    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
  }

  return null;
}

String syDisplayTimeWithAmPm(
  DateTime? time, {
  DateTimeSelectionMode mode = DateTimeSelectionMode.dateOnly,
}) {
  if (time == null) {
    return "Not Available";
  }

  String dateStr = '';
  String timeStr = '';

  // Handle the date part based on selection mode
  if (mode == DateTimeSelectionMode.dateOnly ||
      mode == DateTimeSelectionMode.dateAndTime) {
    dateStr =
        DateFormat('yyyy-MM-dd').format(time); // Format the date as YYYY-MM-DD
  }
  if (mode == DateTimeSelectionMode.dateWithOutYear) {
    dateStr = DateFormat('MM-dd').format(time);
  }

  // Handle the time part
  if (mode == DateTimeSelectionMode.timeOnly ||
      mode == DateTimeSelectionMode.dateAndTime) {
    bool isAm = true;
    String mmm = DateFormat('hh:mm').format(time); // Format time as HH:MM
    if (int.parse(DateFormat('HH').format(time)) > 11) {
      isAm = false;
    }
    timeStr = "$mmm ${isAm ? "AM" : "PM"}";
  }

  // Combine the date and time based on the mode
  if (mode == DateTimeSelectionMode.dateAndTime) {
    return "$dateStr $timeStr";
  } else if (mode == DateTimeSelectionMode.dateOnly) {
    return dateStr;
  } else {
    return timeStr;
  }
}

String? syDisplayTimeWithAmPm2Nullable(DateTime? time,
    {DateTimeSelectionMode mode = DateTimeSelectionMode.dateOnly}) {
  if (time == null) {
    return null;
  }
  return syDisplayTimeWithAmPm(time, mode: mode);
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

Widget gap(double data) {
  return Gap(data);
}

class SYCache {
  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Save or Update Data
  static Future<void> updateString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value); // Overwrites if the key already exists
  }

  // Delete Data
  static Future<void> deleteVariable(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // Retrieve Data
  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Check if a key exists
  static Future<bool> containsKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  static Future<void> updateStringList(String key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        key, value); // Overwrites if the key already exists
  }

  // Retrieve a String List
  static Future<List<String>?> getStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  // Add an item to a String List
  static Future<void> addItemToList(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    final currentList = prefs.getStringList(key) ?? [];

    // Check if the value already exists before adding
    if (!currentList.contains(value)) {
      currentList.add(value);
      await prefs.setStringList(key, currentList);
    }
  }

  static Future<void> addItemForceToList(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    final currentList = prefs.getStringList(key) ?? [];
    currentList.add(value);
    await prefs.setStringList(key, currentList);
  }

  // Remove an item from a String List
  static Future<void> removeItemFromList(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    final currentList = prefs.getStringList(key) ?? [];
    currentList.remove(value);
    await prefs.setStringList(key, currentList);
  }
}

Widget syGrid2(
  List<Widget> theWidgetList, {
  double? width,
  double? height,
}) {
  if (theWidgetList.isEmpty) {
    return const Center(
      child: Text('No matching items found'),
    );
  }
  return LayoutBuilder(
    builder: (context, constraints) {
      // Calculate the number of columns based on screen width
      int columns =
          constraints.maxWidth ~/ (width ?? 200); // 300px width + some spacing
      columns = columns > 0 ? columns : 1; // Ensure at least 1 column
      int rows = (theWidgetList.length / columns).ceil();

      return Column(
        children: [
          for (int index = 0; index < rows; index++) ...{
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int c = 0; c < columns; c++)
                  if (index * columns + c <
                      theWidgetList.length) // Prevent index out of range
                    SizedBox(
                      width: (width ?? 200),
                      child: ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 100),
                          child: theWidgetList[index * columns + c]),
                    )
              ],
            )
          }
        ],
      );
    },
  );
}

enum SYNumeric { doubleValue, intValue }

Future<String?> syAskToTypeAnything({
  required BuildContext context,
  required String title,
  required String label,
  SYNumeric? numericType,
  String? old,
}) async {
  String typed = old ?? "";
  return await showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: SYTextField(
          label: label,
          numericType: numericType,
          old: old,
          onChanged: (e) {
            typed = e;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, typed),
            child: const Text("Save"),
          ),
        ],
      );
    },
  );
}

Future<void> syWait(double? time) async {
  await Future.delayed(
      Duration(milliseconds: ((time ?? 1) * 1000).floor()), () {});
}

class SYOnTap extends StatelessWidget {
  const SYOnTap({
    super.key,
    this.onTap,
    required this.child,
    this.onLongPress,
  });
  final Function()? onTap;
  final Function()? onLongPress;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: (onTap != null || onLongPress != null)
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      child: GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: child,
      ),
    );
  }
}
