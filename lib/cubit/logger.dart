import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
//import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'logger.freezed.dart';

enum LogType { api, event, exception }

class Log {
  Log({
    required this.type,
    this.path,
    this.response,
    this.statusCode,
    this.bloc,
    this.event,
    this.exceptionType,
    this.exceptionSource,
    this.stackTrace,
  });

  final LogType type;

  final String? path;
  final String? response;
  final String? statusCode;

  final String? bloc;
  final String? event;

  final String? exceptionType;
  final String? exceptionSource;
  final String? stackTrace;
}

@freezed
class LoggerState with _$LoggerState {
  const factory LoggerState({
    @Default([]) List<Log> logs,
  }) = _LoggerState;
}

class LoggerCubit extends Cubit<LoggerState> {
  LoggerCubit() : super(LoggerState());

  void logAPI(
    String path,
    String response,
    int statusCode,
  ) async {
    try {
      final log = Log(
        type: LogType.api,
        path: path,
        response: response,
        statusCode: statusCode.toString(),
      );

      _addToLog(log);
    } catch (e) {
      print(e.toString());
    }
  }

  void logEvent(String event) async {
    try {
      final strs = event.split('.');
      final log = Log(
        type: LogType.event,
        bloc: strs[0],
        event: strs[1],
      );

      await Future.delayed(Duration(milliseconds: 5));

      _addToLog(log);
    } catch (e) {
      print(e.toString());
    }
  }

  void logException(
    dynamic e,
    String source,
    dynamic s,
  ) async {
    try {
      final log = Log(
        type: LogType.exception,
        exceptionSource: source,
        exceptionType: e.toString(),
        stackTrace: (s as StackTrace).toString(),
      );

      print('\n\nERROR @ ' +
          log.exceptionSource! +
          '\nMessage: ' +
          log.exceptionType! +
          '\nTrace: ' +
          log.stackTrace! +
          '\n\n');

      _addToLog(log);

      //await Sentry.captureException(
      //  event.e,
      //  stackTrace: event.s,
      //  hint: event.source,
      //);
    } catch (e) {
      print(e.toString());
    }
  }

  _addToLog(Log log) {
    List<Log> logs = state.logs.toList();
    logs.add(log);
    emit(state.copyWith(logs: logs));
  }
}
