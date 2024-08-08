library sy_customs;

import 'dart:io';
import 'dart:ui';
import 'package:gap/gap.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    this.inputFormatters,
    this.optionList,
    this.onSubmitted,
    this.selectedFromList,
    required this.onClean,
    this.focusNode,
    this.isOnlySelectable = false,
  });

  final Color borderColor;
  final Color focusBorderColor;
  final List<TextInputFormatter>? inputFormatters;
  final List<String>? optionList;
  final String label;
  final String? old;
  final TextStyle textStyle;
  final Function(String) onChanged;
  final Function() onClean;
  final Function(String)? onSubmitted;
  final Function(String)? selectedFromList;
  final FocusNode? focusNode;
  final bool isOnlySelectable;

  @override
  State<SYTextField> createState() => _SYTextFieldState();
}

class _SYTextFieldState extends State<SYTextField> {
  String goingToAdd = "";

  @override
  Widget build(BuildContext context) {
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
            !h.contains(textEditingValue.text.toLowerCase()) &&
            !widget.isOnlySelectable) {
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
                  width: 300, // Set your desired width here
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
                                  "Conform Add",
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
          textEditingController.text = widget.old!;
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: textEditingController,
            inputFormatters: widget.inputFormatters,
            focusNode: widget.focusNode ?? focusNode,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.borderColor, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: widget.focusBorderColor, width: 2.0),
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
                        if (textEditingController.text.isNotEmpty) {
                          widget.onSubmitted!(textEditingController.text);
                        } else {
                          widget.onClean();
                        }
                      },
                      icon: const Icon(Icons.check)),
            ),
            onSubmitted: (dd) {
              if (dd.isEmpty) {
                widget.onClean();
              } else {
                widget.onSubmitted!(dd);
              }
            },
            onChanged: (dd) {
              if (dd.isNotEmpty) {
                widget.onChanged(dd);
              } else {
                widget.onClean();
              }
            },
          ),
        );
      },
    );
  }
}

class SySlideButton extends StatefulWidget {
  const SySlideButton(
      {super.key,
      required this.text,
      required this.onSlide,
      required this.active});
  final bool active;
  final String text;
  final Function() onSlide;
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
        buttontextstyle: const TextStyle(fontSize: 25, color: Colors.white),
        buttonWidget:
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey),
        activeColor: const Color(0xFF009C41),
        onWaitingProcess: () {
          widget.onSlide();
          // Future.delayed(const Duration(milliseconds: 300), () {
          //   setState(() => isFinished = true);
          // });
        },
        isFinished: isFinished,
        onFinish: () async {},
      ),
    );
  }
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
  request('request'),
  more('more'),
  pending('pending'),
  rejected('rejected'),
  lock('lock'),
  duplicate('duplicate'),
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
  yeezzLogo('yeezzLogo'),
  go('go'),
  construction('construction'),
  form('form'),
  thinking('thinking'),
  whatsapp('whatsapp'),
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
      case 'map':
        return SYIconText.map;
      case 'construction':
        return SYIconText.construction;
      case 'form':
        return SYIconText.form;
      case 'thinking':
        return SYIconText.thinking;
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
      case 'send':
        return SYIconText.send;
      case 'list':
        return SYIconText.list;
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
      case SYIconText.invoice:
        icon = 'packages/sy_customs/assets/svg/invoice.svg';
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
      case SYIconText.idCard:
        icon = 'packages/sy_customs/assets/svg/id_card.svg';
        break;
      case SYIconText.nic:
        icon = 'packages/sy_customs/assets/svg/nic.svg';
        break;
      case SYIconText.duplicate:
        icon = 'packages/sy_customs/assets/svg/duplicate.svg';
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
