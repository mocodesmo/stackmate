import 'package:flutter/material.dart';
import 'package:sats/cubit/wallet/history.dart';
import 'package:sats/model/transaction.dart';
import 'package:sats/navigation.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/back-button.dart';
import 'package:sats/view/common/header.dart';

class TransactionCell extends StatefulWidget {
  const TransactionCell({Key? key, required this.transaction})
      : super(key: key);

  final Transaction transaction;

  @override
  _TransactionCellState createState() => _TransactionCellState();
}

class _TransactionCellState extends State<TransactionCell> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext c) {
    final isReceive = widget.transaction.isReceive();

    if (isReceive)
      return AnimatedSwitcher(
          key: _isExpanded ? ValueKey(1) : ValueKey(2),
          duration: Duration(milliseconds: 2000),
          child: GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: c.colours.surface),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(children: [
                          Text(
                            'RECEIVE'.notLocalised(),
                            style: c.fonts.subtitle2!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: c.colours.onBackground,
                            ),
                          ),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                Text(
                                    widget.transaction.received.toString() +
                                        ' sats',
                                    style: c.fonts.headline6!.copyWith(
                                      color: c.colours.onBackground,
                                    ),
                                    textAlign: TextAlign.end),
                                Text(widget.transaction.amountToBtc() + ' BTC',
                                    style: c.fonts.overline!.copyWith(
                                      color: c.colours.onBackground,
                                    ))
                              ]))
                        ]),
                        SizedBox(height: 8),
                        Text('TRANSACTION ID'.notLocalised(),
                            style: c.fonts.overline!.copyWith(
                              color: c.colours.onBackground,
                            )),
                        GestureDetector(
                            onTap: () {
                              c
                                  .read<HistoryCubit>()
                                  .openLink(widget.transaction);
                            },
                            child: Container(
                                width: c.width / 2,
                                child: Text(
                                    !_isExpanded
                                        ? widget.transaction.txIdBlur()
                                        : widget.transaction.txid,
                                    style: c.fonts.caption!
                                        .copyWith(color: c.colours.primary)))),
                        //SizedBox(height: 16),
                        if (_isExpanded) ...[
                          SizedBox(height: 16),
                          Text('CREATED AT'.notLocalised(),
                              style: c.fonts.overline!.copyWith(
                                color: c.colours.onBackground,
                              )),
                          Text(widget.transaction.timeStr(),
                              style: c.fonts.caption!.copyWith(
                                color: c.colours.onBackground,
                              )),
                          SizedBox(height: 16),
                          //SizedBox(height: 8),
                          Row(children: [
                            Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                  // Text('ADDRESS'.notLocalised(),
                                  //     style: c.fonts.overline),
                                  // Text(widget.transaction.txid,
                                  //     style: c.fonts.caption)
                                ])),
                            SizedBox(
                                width: c.width / 4,
                                child: TextButton(
                                    onPressed: () {
                                      c
                                          .read<HistoryCubit>()
                                          .shareTransaction(widget.transaction);
                                    },
                                    child: Text('SHARE'.notLocalised())))
                          ])
                        ]
                      ]))));

    return AnimatedSwitcher(
      key: _isExpanded ? ValueKey(1) : ValueKey(2),
      duration: Duration(milliseconds: 2000),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2), color: c.colours.surface),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(children: [
                Text('SEND'.notLocalised(),
                    style: c.fonts.subtitle2!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: c.colours.onBackground,
                    )),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                      Text(
                        widget.transaction.sent.toString() + ' sats',
                        style: c.fonts.headline6!.copyWith(
                          color: c.colours.onBackground,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      Text(widget.transaction.amountToBtc() + ' BTC',
                          style: c.fonts.overline!.copyWith(
                            color: c.colours.onBackground,
                          ))
                    ]))
              ]),
              SizedBox(height: 8),
              Text('TRANSACTION ID'.notLocalised(),
                  style: c.fonts.overline!.copyWith(
                    color: c.colours.onBackground,
                  )),
              GestureDetector(
                onTap: () {
                  c.read<HistoryCubit>().openLink(widget.transaction);
                },
                child: Container(
                  width: c.width / 2,
                  child: Text(
                    !_isExpanded
                        ? widget.transaction.txIdBlur()
                        : widget.transaction.txid,
                    style: c.fonts.caption!.copyWith(
                      color: c.colours.primary,
                    ),
                  ),
                ),
              ),
              if (_isExpanded) ...[
                SizedBox(height: 16),
                //if (!widget.transaction.confirmed) ...[
                // Text('CONFIRMATIONS'.notLocalised(),
                //     style: c.fonts.overline),
                // Text(widget.transaction.confirmations.toString(),
                //     style: c.fonts.caption),
                //] else ...[
                //  Text('CONFIRMED'.notLocalised(),
                //      style: c.fonts.overline),
                //  Align(
                //      alignment: Alignment.centerLeft,
                //      child: Icon(Icons.check_rounded)),
                //],
                SizedBox(height: 16),
                Text('CREATED AT'.notLocalised(),
                    style: c.fonts.overline!.copyWith(
                      color: c.colours.onBackground,
                    )),
                Text(widget.transaction.timeStr(),
                    style: c.fonts.caption!.copyWith(
                      color: c.colours.onBackground,
                    )),
                SizedBox(height: 16),
                // Text('TO ADDRESS'.notLocalised(), style: c.fonts.overline),
                // Text(widget.transaction.txid, style: c.fonts.caption),
                SizedBox(height: 16),
                Text('AMOUNT'.notLocalised(),
                    style: c.fonts.overline!.copyWith(
                      color: c.colours.onBackground,
                    )),
                Text(widget.transaction.sent.toString(),
                    style: c.fonts.caption!.copyWith(
                      color: c.colours.onBackground,
                    )),
                SizedBox(height: 16),
                Text('Fees'.notLocalised(),
                    style: c.fonts.overline!.copyWith(
                      color: c.colours.onBackground,
                    )),
                Text(widget.transaction.fee.toString(),
                    style: c.fonts.caption!.copyWith(
                      color: c.colours.onBackground,
                    )),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // if (widget.transaction.comment != null)
                    //   Expanded(
                    //     child: Column(
                    //       crossAxisAlignment:
                    //           CrossAxisAlignment.stretch,
                    //       children: [
                    //         Text('COMMENT'.notLocalised(),
                    //             style: c.fonts.overline),
                    //         Text(widget.transaction.comment!,
                    //             style: c.fonts.caption)
                    //       ],
                    //     ),
                    //   ),
                    TextButton(
                      onPressed: () {
                        c
                            .read<HistoryCubit>()
                            .shareTransaction(widget.transaction);
                      },
                      child: Text('SHARE'.notLocalised()),
                    ),
                    SizedBox(width: 32),
                  ],
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionsView extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    final transactions = c.select((HistoryCubit h) => h.state.transactions);

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      if (transactions == null || transactions.length == 0)
        Container()
      else ...[
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 32, bottom: 24),
          child: Text('HISTORY',
              style: c.fonts.overline!.copyWith(
                color: c.colours.onBackground,
              )),
        ),
        for (var transaction in transactions)
          TransactionCell(transaction: transaction),
      ]
      // if (!state.loadingTransactions) ...[
      //   SizedBox(height: 24),
      //   Center(
      //       child: TextButton(
      //           onPressed: () {
      //             c.read<HistoryCubit>().getHistory();
      //           },
      //           child: Text('Load More'))),
      //   SizedBox(height: 24),
      // ]
    ]);
  }
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    final state = c.select((HistoryCubit h) => h.state);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (state.loadingTransactions) LinearProgressIndicator(),
            Header(cornerTitle: 'STACKMATE', children: [
              SizedBox(height: 8),
              Back(),
              SizedBox(height: 60),
              Text(' ' + state.wallet!.label.toUpperCase(),
                  style: c.fonts.headline4!.copyWith(
                    color: Colors.white,
                  )),
              SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        c,
                        Routes.receive,
                        arguments: state.wallet!,
                      );
                    },
                    child: Text('Receive')),
              ),
              SizedBox(height: 48),
            ]),
            TransactionsView()
          ],
        ),
      )),
    );
  }
}
