import 'package:flutter/material.dart';
import 'package:sats/cubit/wallet/history.dart';
import 'package:sats/cubit/wallet/wallets.dart';
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
        key: _isExpanded ? const ValueKey(1) : const ValueKey(2),
        duration: const Duration(milliseconds: 2000),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: c.colours.surface,
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
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
                            widget.transaction.received.toString() + ' sats',
                            style: c.fonts.headline6!.copyWith(
                              color: c.colours.onBackground,
                            ),
                            textAlign: TextAlign.end,
                          ),
                          Text(
                            widget.transaction.amountToBtc() + ' BTC',
                            style: c.fonts.overline!.copyWith(
                              color: c.colours.onBackground,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'TRANSACTION ID'.notLocalised(),
                  style: c.fonts.overline!.copyWith(
                    color: c.colours.onBackground,
                  ),
                ),
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
                //SizedBox(height: 16),
                if (_isExpanded) ...[
                  const SizedBox(height: 16),
                  Text(
                    'CREATED AT'.notLocalised(),
                    style: c.fonts.overline!.copyWith(
                      color: c.colours.onBackground,
                    ),
                  ),
                  Text(
                    widget.transaction.timeStr(),
                    style: c.fonts.caption!.copyWith(
                      color: c.colours.onBackground,
                    ),
                  ),
                  const SizedBox(height: 16),
                  //SizedBox(height: 8),
                  Row(
                    children: [
                      const Spacer(),
                      // Expanded(
                      //     child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.stretch,
                      //         children: const [
                      //       // Text('ADDRESS'.notLocalised(),
                      //       //     style: c.fonts.overline),
                      //       // Text(widget.transaction.txid,
                      //       //     style: c.fonts.caption)
                      //     ])),
                      SizedBox(
                        width: c.width / 4,
                        child: TextButton(
                          onPressed: () {
                            c
                                .read<HistoryCubit>()
                                .shareTransaction(widget.transaction);
                          },
                          child: Text(
                            'SHARE'.notLocalised(),
                          ),
                        ),
                      )
                    ],
                  )
                ]
              ],
            ),
          ),
        ),
      );

    return AnimatedSwitcher(
      key: _isExpanded ? const ValueKey(1) : const ValueKey(2),
      duration: const Duration(milliseconds: 2000),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: c.colours.surface,
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    'SEND'.notLocalised(),
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
                          widget.transaction.sent.toString() + ' sats',
                          style: c.fonts.headline6!.copyWith(
                            color: c.colours.onBackground,
                          ),
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          widget.transaction.amountToBtc() + ' BTC',
                          style: c.fonts.overline!.copyWith(
                            color: c.colours.onBackground,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'TRANSACTION ID'.notLocalised(),
                style: c.fonts.overline!.copyWith(
                  color: c.colours.onBackground,
                ),
              ),
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
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
                Text(
                  'CREATED AT'.notLocalised(),
                  style: c.fonts.overline!.copyWith(
                    color: c.colours.onBackground,
                  ),
                ),
                Text(
                  widget.transaction.timeStr(),
                  style: c.fonts.caption!.copyWith(
                    color: c.colours.onBackground,
                  ),
                ),
                const SizedBox(height: 16),
                // Text('TO ADDRESS'.notLocalised(), style: c.fonts.overline),
                // Text(widget.transaction.txid, style: c.fonts.caption),
                const SizedBox(height: 16),
                Text(
                  'AMOUNT'.notLocalised(),
                  style: c.fonts.overline!.copyWith(
                    color: c.colours.onBackground,
                  ),
                ),
                Text(
                  widget.transaction.sent.toString(),
                  style: c.fonts.caption!.copyWith(
                    color: c.colours.onBackground,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Fees'.notLocalised(),
                  style: c.fonts.overline!.copyWith(
                    color: c.colours.onBackground,
                  ),
                ),
                Text(
                  widget.transaction.fee.toString(),
                  style: c.fonts.caption!.copyWith(
                    color: c.colours.onBackground,
                  ),
                ),
                const SizedBox(height: 16),
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
                    const SizedBox(width: 32),
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
    final wallet = c.select(
      (WalletsCubit w) => w.state.selectedWallet!,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (wallet.transactions == null || wallet.transactions!.isEmpty)
          Container()
        else ...[
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 32, bottom: 24),
            child: Text(
              'HISTORY',
              style: c.fonts.overline!.copyWith(
                color: c.colours.onBackground,
              ),
            ),
          ),
          for (var transaction in wallet.transactions!)
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
      ],
    );
  }
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    final history = c.select((HistoryCubit h) => h.state);
    final wallet = c.select(
      (WalletsCubit w) => w.state.selectedWallet!,
    );
    return WillPopScope(
      onWillPop: () async {
        c.read<WalletsCubit>().clearSelectedWallet();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (history.loadingTransactions)
                  const LinearProgressIndicator(),
                Header(
                  cornerTitle: 'STACKMATE',
                  children: [
                    const SizedBox(height: 8),
                    Back(
                      onPressed: () {
                        c.read<WalletsCubit>().clearSelectedWallet();
                        Navigator.of(c).pop();
                      },
                    ),
                    const SizedBox(height: 60),
                    Text(
                      ' ' + wallet.label.toUpperCase(),
                      style: c.fonts.headline4!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (wallet.balance != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Balance'.toUpperCase(),
                              style: c.fonts.overline!.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              wallet.balance!.toString() + ' sats',
                              style: c.fonts.headline6!.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              wallet.balanceToBtc() + ' BTC',
                              style: c.fonts.caption!.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              c,
                              Routes.receive,
                              // arguments: state.wallet!,
                            );
                          },
                          child: const Text('RECEIVE'),
                        ),
                        const SizedBox(height: 32),
                        TextButton(
                          onPressed: () {
                            // Navigator.pushNamed(
                            //   c,
                            //   Routes.receive,
                            //   // arguments: state.wallet!,
                            // );
                          },
                          child: const Text('SEND'),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 48),
                  ],
                ),
                TransactionsView()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
