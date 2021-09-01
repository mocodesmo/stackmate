import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/cubit/logger.dart';

class LogList extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    final logs = c.select((LoggerCubit l) => l.state.logs);
    return Scaffold(
        backgroundColor: c.colours.background,
        appBar: AppBar(
            title: Text('LOGS', style: TextStyle(color: Colors.black)),
            backgroundColor: c.colours.primary,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () {
                  Navigator.pop(c);
                })),
        body: ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
                LogItem(logs[index]),
            itemCount: logs.length));
  }
}

class LogItem extends StatelessWidget {
  final Log log;

  const LogItem(this.log);

  @override
  Widget build(BuildContext context) {
    if (log.type == LogType.event)
      return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [Text('EVENT from ' + log.bloc!), Text(log.event!)]));

    if (log.type == LogType.api)
      return ExpansionTile(
          maintainState: false,
          tilePadding: EdgeInsets.all(0),
          title: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(log.path!),
                    SizedBox(height: 8),
                    Text('STATUS: ' + log.statusCode!)
                  ])),
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(16.0),
                child: GestureDetector(
                    onLongPress: () {}, child: Text(log.response!)))
          ]);

    if (log.type == LogType.exception)
      return ExpansionTile(
          maintainState: false,
          tilePadding: EdgeInsets.all(0),
          title: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      log.exceptionSource!,
                    ),
                    SizedBox(height: 8),
                    Text('EXCEPTION: ' + log.exceptionType!)
                  ])),
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(16.0),
                child: GestureDetector(
                    onLongPress: () {}, child: Text(log.stackTrace!)))
          ]);

    return Container();
  }
}
