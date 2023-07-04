// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/src/widgets/custom_icon_button.dart';
import 'package:table_calendar/src/widgets/format_button.dart';

import '../customization/header_style.dart';
import '../shared/utils.dart' show CalendarFormat, DayBuilder;

class CalendarHeader extends StatelessWidget {
  final dynamic locale;
  final DateTime focusedMonth;
  final DateTime focusedYear;
  final CalendarFormat calendarFormat;
  final HeaderStyle headerStyle;
  final VoidCallback onLeftChevronTap;
  final VoidCallback onRightChevronTap;
  final VoidCallback onLeftYearTap;
  final VoidCallback onRightYearTap;
  final VoidCallback onHeaderTap;
  final VoidCallback onHeaderLongPress;
  final ValueChanged<CalendarFormat> onFormatButtonTap;
  final Map<CalendarFormat, String> availableCalendarFormats;
  final DayBuilder? headerTitleBuilder;
  final bool? useCustomHeader;

  const CalendarHeader({
    Key? key,
    this.locale,
    required this.focusedMonth,
    required this.focusedYear,
    required this.calendarFormat,
    required this.headerStyle,
    required this.onLeftChevronTap,
    required this.onRightChevronTap,
    required this.onHeaderTap,
    required this.onHeaderLongPress,
    required this.onFormatButtonTap,
    required this.availableCalendarFormats,
    required this.onLeftYearTap,
    required this.onRightYearTap,
    this.useCustomHeader = false,
    this.headerTitleBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = headerStyle.titleTextFormatter?.call(focusedMonth, locale) ??
        DateFormat.MMMM(locale).format(focusedMonth);
    final textYear =
        headerStyle.subTitleTextFormatter?.call(focusedYear, locale) ??
            DateFormat.y(locale).format(focusedYear);

    return Container(
      decoration: headerStyle.decoration,
      margin: headerStyle.headerMargin,
      padding: headerStyle.headerPadding,
      child: (useCustomHeader == true)
          ? Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      CustomIconButton(
                          icon: headerStyle.leftChevronIcon,
                          padding: EdgeInsets.all(0),
                          onTap: onLeftChevronTap),
                      Text(
                        text,
                        style: headerStyle.titleTextStyle,
                      ),
                      CustomIconButton(
                          icon: headerStyle.rightChevronIcon,
                          padding: EdgeInsets.all(0),
                          onTap: onRightChevronTap),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  height: 42,
                  margin: const EdgeInsets.only(right: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      CustomIconButton(
                          icon: headerStyle.leftChevronIcon,
                          padding: EdgeInsets.all(0),
                          onTap: onLeftYearTap),
                      Text(
                        textYear,
                        style: headerStyle.titleTextStyle,
                      ),
                      CustomIconButton(
                          icon: headerStyle.rightChevronIcon,
                          padding: EdgeInsets.all(0),
                          onTap: onRightYearTap),
                    ],
                  ),
                ),
              ],
            )
          : Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (headerStyle.leftChevronVisible)
                  CustomIconButton(
                    icon: headerStyle.leftChevronIcon,
                    onTap: onLeftChevronTap,
                    margin: headerStyle.leftChevronMargin,
                    padding: headerStyle.leftChevronPadding,
                  ),
                Expanded(
                  child: headerTitleBuilder?.call(context, focusedMonth) ??
                      GestureDetector(
                        onTap: onHeaderTap,
                        onLongPress: onHeaderLongPress,
                        child: Text(
                          text,
                          style: headerStyle.titleTextStyle,
                          textAlign: headerStyle.titleCentered
                              ? TextAlign.center
                              : TextAlign.start,
                        ),
                      ),
                ),
                if (headerStyle.formatButtonVisible &&
                    availableCalendarFormats.length > 1)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: FormatButton(
                      onTap: onFormatButtonTap,
                      availableCalendarFormats: availableCalendarFormats,
                      calendarFormat: calendarFormat,
                      decoration: headerStyle.formatButtonDecoration,
                      padding: headerStyle.formatButtonPadding,
                      textStyle: headerStyle.formatButtonTextStyle,
                      showsNextFormat: headerStyle.formatButtonShowsNext,
                    ),
                  ),
                if (headerStyle.rightChevronVisible)
                  CustomIconButton(
                    icon: headerStyle.rightChevronIcon,
                    onTap: onRightChevronTap,
                    margin: headerStyle.rightChevronMargin,
                    padding: headerStyle.rightChevronPadding,
                  ),
              ],
            ),
    );
  }
}
