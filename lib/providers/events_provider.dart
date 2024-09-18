// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import '../models/event.dart';
import '../repository/event_repository.dart';

class EventsProvider extends ChangeNotifier {
  final repository = EventRepository();

  List<Event> _events = [];

  EventsProvider() {
    _loadEvents();
  }

  void _loadEvents() async {
    _events = await repository.getEvents();
    notifyListeners();
  }

  List<Event> get events => _events;

  loadEvents() async {
    _loadEvents();
  }
}
