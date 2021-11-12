import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/back-button.dart';
import 'package:sats/view/common/log-button.dart';

class InheritancePage extends StatelessWidget {
  const InheritancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                // elevation: 2,
                floating: true,
                snap: true,
                forceElevated: innerBoxIsScrolled,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  systemNavigationBarColor: c.colours.onBackground,
                  statusBarIconBrightness: Brightness.dark,
                ),
                // leading: const Back(),
                leadingWidth: 100,
                toolbarHeight: 64,
                leading: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Back(),
                ),

                actions: [
                  LogButton(
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.lightbulb_outline_sharp,
                        size: 32,
                        // color: Colors.blue[400],
                        color: c.colours.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: [
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
