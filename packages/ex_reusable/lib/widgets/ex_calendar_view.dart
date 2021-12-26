import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

///   created               : Aditya Pratama
///   originalFilename      : ex_calendar_view
///   date                  : 12 Jul 2021
///   —————————————————————————————————————————————————————————————————————————————
///   screenshot            : @todo add screenshot
///
class ExCalendarView<T> extends StatelessWidget {
  const ExCalendarView({
    Key? key,
    required this.focusedDay,
    this.selectedDay,
    this.onRangeSelected,
    this.onDaySelected,
    this.onDayLongPressed,
    this.onDisabledDayTapped,
    this.onDisabledDayLongPressed,
    this.onHeaderTapped,
    this.onHeaderLongPressed,
    this.onPageChanged,
    this.onFormatChanged,
    this.onCalendarCreated,
    this.eventLoader,
  }) : super(key: key);

  final DateTime focusedDay;
  final DateTime? selectedDay;

  /// Called whenever a day range gets selected.
  final OnRangeSelected? onRangeSelected;

  /// Called whenever any day gets tapped.
  final OnDaySelected? onDaySelected;

  /// Called whenever any day gets long pressed.
  final OnDaySelected? onDayLongPressed;

  /// Called whenever any disabled day gets tapped.
  final void Function(DateTime day)? onDisabledDayTapped;

  /// Called whenever any disabled day gets long pressed.
  final void Function(DateTime day)? onDisabledDayLongPressed;

  /// Called whenever header gets tapped.
  final void Function(DateTime focusedDay)? onHeaderTapped;

  /// Called whenever header gets long pressed.
  final void Function(DateTime focusedDay)? onHeaderLongPressed;

  /// Called whenever currently visible calendar page is changed.
  final void Function(DateTime focusedDay)? onPageChanged;

  /// Called whenever `calendarFormat` is changed.
  final void Function(CalendarFormat format)? onFormatChanged;

  /// Called when the calendar is created. Exposes its PageController.
  final void Function(PageController pageController)? onCalendarCreated;

  /// Function that assigns a list of events to a specified day.
  final List<T> Function(DateTime day)? eventLoader;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('in');
    const String locale = 'in';
    return TableCalendar<T>(
      locale: locale,
      headerStyle: HeaderStyle(
        leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.orange),
        rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.orange),
        titleCentered: true,
        titleTextStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        titleTextFormatter: (DateTime date, locale) => DateFormat.yMMMM(locale).format(date),
        formatButtonVisible: false,
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(fontSize: 12),
        weekendStyle: TextStyle(fontSize: 12, color: Colors.red),
      ),
      calendarStyle: const CalendarStyle(
        outsideDaysVisible: false,
        weekendTextStyle: TextStyle(fontSize: 12, color: Colors.red),
        defaultTextStyle: TextStyle(fontSize: 12),
        todayTextStyle: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
        selectedTextStyle: TextStyle(fontSize: 12, color: Colors.white),
        markerSize: 5,
        selectedDecoration: BoxDecoration(
          color: Color(0xFF72a065),
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Color(0x77e7ac17),
          shape: BoxShape.circle,
        ),
        markerDecoration: BoxDecoration(
          color: Color(0xFF62717a),
          shape: BoxShape.circle,
        ),
      ),
      selectedDayPredicate: (DateTime day) => isSameDay(selectedDay, day),
      firstDay: DateTime(2020),
      lastDay: DateTime(2030),
      focusedDay: focusedDay,
      startingDayOfWeek: StartingDayOfWeek.monday,
      onRangeSelected: onRangeSelected,
      onDaySelected: onDaySelected,
      onDayLongPressed: onDayLongPressed,
      onDisabledDayTapped: onDisabledDayTapped,
      onDisabledDayLongPressed: onDisabledDayLongPressed,
      onHeaderTapped: onHeaderTapped,
      onHeaderLongPressed: onHeaderLongPressed,
      onPageChanged: onPageChanged,
      onFormatChanged: onFormatChanged,
      onCalendarCreated: onCalendarCreated,
      weekendDays: const [DateTime.sunday],
      eventLoader: eventLoader,
      availableGestures: AvailableGestures.horizontalSwipe,
    );
  }
}
