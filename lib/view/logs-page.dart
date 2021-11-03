import 'package:flutter/material.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/model/log.dart';
import 'package:sats/pkg/extensions.dart';

class LogItem extends StatelessWidget {
  const LogItem(this.log);

  final Log log;

  @override
  Widget build(BuildContext context) {
    if (log.type == LogType.event)
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('EVENT from $log.bloc!'),
            Text(log.event!),
          ],
        ),
      );

    if (log.type == LogType.api)
      return ExpansionTile(
        collapsedIconColor: context.colours.primary,
        iconColor: context.colours.primary,
        // maintainState: false,
        tilePadding: EdgeInsets.zero,
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                log.path!,
                style: context.fonts.caption!.copyWith(
                  color: context.colours.onBackground,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'STATUS: ' + log.statusCode!,
                style: context.fonts.bodyText1!.copyWith(
                  color: context.colours.primary,
                ),
              )
            ],
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onLongPress: () {
                context.read<LoggerCubit>().copyToClipboard(log.response!);
              },
              child: Text(
                log.response!,
                style: context.fonts.caption!.copyWith(
                  color: context.colours.onBackground,
                ),
              ),
            ),
          )
        ],
      );

    if (log.type == LogType.exception)
      return ExpansionTile(
        // maintainState: false,
        tilePadding: EdgeInsets.zero,
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                log.exceptionSource!,
                style: context.fonts.caption!.copyWith(
                  color: context.colours.onBackground,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'EXCEPTION: ' + log.exceptionType!,
                style: context.fonts.caption!.copyWith(
                  color: context.colours.onBackground,
                ),
              )
            ],
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onLongPress: () {},
              child: Text(
                log.stackTrace!,
                style: context.fonts.caption!.copyWith(
                  color: context.colours.onBackground,
                ),
              ),
            ),
          )
        ],
      );

    return Container();
  }
}

class LogsPage extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    final logs = c.select((LoggerCubit l) => l.state.logs);
    return Scaffold(
      backgroundColor: c.colours.background,
      appBar: AppBar(
        title: const Text(
          'LOGS',
          style: TextStyle(
              // color: Colors.black,
              ),
        ),
        backgroundColor: c.colours.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            // color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(c);
          },
        ),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) => LogItem(logs[index]),
        itemCount: logs.length,
      ),
    );
  }
}
