import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Recurrence {
  DateTime? nextPaymentDate;
  Duration? duration;
  int? accountId;
  int id;

  Recurrence({
    required this.id,
    required this.nextPaymentDate,
    required this.duration,
    required this.accountId,
  });
}
