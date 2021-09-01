import 'package:flutter/material.dart';
import 'package:sats/zold/cubit/wallet-history.dart';
import 'package:sats/zold/model/wallet-transaction.dart';
import 'package:sats/pkg/extensions.dart';

class Transactions extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    final historyState = c.select((WalletHistoryCubit h) => h.state);

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      if (historyState.transactions.length == 0)
        Container()
      else
        for (var transaction in historyState.transactions)
          TransactionCell(transaction: transaction),
      if (!historyState.loadingHistory) ...[
        SizedBox(height: 24),
        Center(
            child: TextButton(
                onPressed: () {
                  c.read<WalletHistoryCubit>().getHistory();
                },
                child: Text('Load More'))),
        SizedBox(height: 24),
      ]
    ]);
  }
}

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
    final isReceive = widget.transaction.received();

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
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: c.colours.surface),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(children: [
                          Text('RECEIVE'.notLocalised(),
                              style: c.fonts.subtitle2!
                                  .copyWith(fontWeight: FontWeight.bold)),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                Text(
                                    widget.transaction.amount.toString() +
                                        ' sats',
                                    style: c.fonts.headline6,
                                    textAlign: TextAlign.end),
                                Text(widget.transaction.amountToBtc() + ' BTC',
                                    style: c.fonts.overline)
                              ]))
                        ]),
                        SizedBox(height: 8),
                        Text('TRANSACTION ID'.notLocalised(),
                            style: c.fonts.overline),
                        GestureDetector(
                            onTap: () {
                              c
                                  .read<WalletHistoryCubit>()
                                  .openLink(widget.transaction);
                            },
                            child: Container(
                                width: c.width / 2,
                                child: Text(
                                    !_isExpanded
                                        ? widget.transaction.txIdBlur()
                                        : widget.transaction.txid,
                                    style: c.fonts.caption!.copyWith(
                                        color: c.colours.primaryVariant)))),
                        //SizedBox(height: 16),
                        if (_isExpanded) ...[
                          SizedBox(height: 16),
                          Text('CREATED AT'.notLocalised(),
                              style: c.fonts.overline),
                          Text(widget.transaction.timeStr(),
                              style: c.fonts.caption),
                          SizedBox(height: 16),
                          //SizedBox(height: 8),
                          Row(children: [
                            Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                  Text('ADDRESS'.notLocalised(),
                                      style: c.fonts.overline),
                                  Text(widget.transaction.address,
                                      style: c.fonts.caption)
                                ])),
                            SizedBox(
                                width: c.width / 4,
                                child: ElevatedButton(
                                    onPressed: () {
                                      c
                                          .read<WalletHistoryCubit>()
                                          .shareOrder(widget.transaction);
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
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: c.colours.surface),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(children: [
                        Text('SEND'.notLocalised(),
                            style: c.fonts.subtitle2!
                                .copyWith(fontWeight: FontWeight.bold)),
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                              Text(
                                  widget.transaction.amount.toString() +
                                      ' sats',
                                  style: c.fonts.headline6,
                                  textAlign: TextAlign.end),
                              Text(widget.transaction.amountToBtc() + ' BTC',
                                  style: c.fonts.overline)
                            ]))
                      ]),
                      SizedBox(height: 8),
                      Text('TRANSACTION ID'.notLocalised(),
                          style: c.fonts.overline),
                      GestureDetector(
                          onTap: () {
                            c
                                .read<WalletHistoryCubit>()
                                .openLink(widget.transaction);
                          },
                          child: Container(
                              width: c.width / 2,
                              child: Text(
                                  !_isExpanded
                                      ? widget.transaction.txIdBlur()
                                      : widget.transaction.txid,
                                  style: c.fonts.caption!.copyWith(
                                      color: c.colours.primaryVariant)))),
                      if (_isExpanded) ...[
                        SizedBox(height: 16),
                        //if (!widget.transaction.confirmed) ...[
                        Text('CONFIRMATIONS'.notLocalised(),
                            style: c.fonts.overline),
                        Text(widget.transaction.confirmations.toString(),
                            style: c.fonts.caption),
                        //] else ...[
                        //  Text('CONFIRMED'.notLocalised(),
                        //      style: c.fonts.overline),
                        //  Align(
                        //      alignment: Alignment.centerLeft,
                        //      child: Icon(Icons.check_rounded)),
                        //],
                        SizedBox(height: 16),
                        Text('CREATED AT'.notLocalised(),
                            style: c.fonts.overline),
                        Text(widget.transaction.timeStr(),
                            style: c.fonts.caption),
                        SizedBox(height: 16),
                        Text('TO ADDRESS'.notLocalised(),
                            style: c.fonts.overline),
                        Text(widget.transaction.address,
                            style: c.fonts.caption),
                        SizedBox(height: 16),
                        Text('AMOUNT'.notLocalised(), style: c.fonts.overline),
                        Text(widget.transaction.amount.toString(),
                            style: c.fonts.caption),
                        SizedBox(height: 16),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (widget.transaction.comment != null)
                                Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                      Text('COMMENT'.notLocalised(),
                                          style: c.fonts.overline),
                                      Text(widget.transaction.comment!,
                                          style: c.fonts.caption)
                                    ])),
                              SizedBox(
                                  width: c.width / 3,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        c
                                            .read<WalletHistoryCubit>()
                                            .shareOrder(widget.transaction);
                                      },
                                      child: Text('SHARE'.notLocalised())))
                            ])
                      ]
                    ]))));
  }
}
