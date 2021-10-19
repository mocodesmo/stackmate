import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sats/cubit/wallet/wallet.dart';
import 'package:sats/cubit/wallet/wallets.dart';
import 'package:sats/model/transaction.dart';
import 'package:sats/navigation.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/back-button.dart';
import 'package:sats/view/common/loading.dart';

class WalletLoader extends StatelessWidget {
  const WalletLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final history = context.select((WalletCubit hc) => hc.state);
    if (!history.loadingTransactions && !history.loadingBalance)
      return Container();

    return Loading(
      text: history.loadingTransactions ? 'Loading History' : 'Loading Balance',
    );
  }
}

class DeleteWallet extends StatelessWidget {
  const DeleteWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    final history = c.select((WalletCubit hc) => hc.state);

    return Column(
      children: [
        Opacity(
          opacity: 0.4,
          child: IconButton(
            iconSize: 28,
            // alignment: Alignment.centerRight,
            color: c.colours.error,
            onPressed: () {
              c.read<WalletCubit>().deleteClicked();
            },
            icon: const Icon(Icons.delete_sweep_outlined),
          ),
        ),
        if (history.errDeleting.isNotEmpty)
          Text(
            history.errDeleting,
            style: c.fonts.caption!.copyWith(color: c.colours.error),
          )
      ],
    );
  }
}

class WalletName extends StatelessWidget {
  const WalletName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wallet = context.select((WalletsCubit wc) => wc.state.selectedWallet);
    if (wallet == null) return Container();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '' + wallet.label.toUpperCase(),
        style: context.fonts.headline4!.copyWith(
          color: context.colours.onBackground,
        ),
      ),
    );
  }
}

class Balance extends StatelessWidget {
  const Balance({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext c) {
    final balance = c.select((WalletCubit hc) => hc.state.balance);
    if (balance == null) return Container();

    return FadeIn(
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Balance'.toUpperCase(),
              style: c.fonts.overline!.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              balance.toString() + ' sats',
              style: c.fonts.headline6!.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              balance.toBtc() + ' BTC',
              style: c.fonts.caption!.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
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
                    c.read<WalletCubit>().openLink(widget.transaction);
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
                    'TIME'.notLocalised(),
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
                                .read<WalletCubit>()
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
                  c.read<WalletCubit>().openLink(widget.transaction);
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
                            .read<WalletCubit>()
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
    final transactions = c.select((WalletCubit w) => w.state.transactions);

    if (transactions == null || transactions.isEmpty) return Container();

    return FadeIn(
      delay: const Duration(milliseconds: 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 32, bottom: 24),
            child: Text(
              'HISTORY',
              style: c.fonts.overline!.copyWith(
                color: c.colours.onBackground,
              ),
            ),
          ),
          for (var transaction in transactions)
            TransactionCell(transaction: transaction),

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
      ),
    );
  }
}

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    final zeroBal = c.select((WalletCubit hc) => hc.state.zeroBalance());
    final showInfo = c.select((WalletCubit hc) => hc.state.showInfo);

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
                const WalletLoader(),
                const SizedBox(height: 16),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(width: 8),
                    Back(
                      onPressed: () {
                        c.read<WalletsCubit>().clearSelectedWallet();
                        Navigator.of(c).pop();
                      },
                    ),
                    const Spacer(),
                    const SizedBox(width: 8),
                  ],
                ),
                // const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          WalletName(),
                          SizedBox(height: 24),
                          Balance(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const DeleteWallet(),
                            // const SizedBox(height: 24),
                            IconButton(
                              // alignment: Alignment.centerRight,
                              color: c.colours.primary,
                              onPressed: () {
                                c.read<WalletCubit>().toggleShowInfo();
                              },
                              icon: const Icon(Icons.info_outline),
                            ),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: zeroBal ? 0.4 : 1,
                              child: IconButton(
                                // alignment: Alignment.centerRight,
                                color: c.colours.primary,
                                onPressed: () {
                                  if (!zeroBal)
                                    Navigator.pushNamed(
                                      c,
                                      Routes.send,
                                      // arguments: state.wallet!,
                                    );
                                },
                                icon: const Icon(
                                  Icons.call_missed_outgoing_outlined,
                                ),
                              ),
                            ),
                            IconButton(
                              // alignment: Alignment.centerRight,
                              color: c.colours.primary,
                              onPressed: () {
                                Navigator.pushNamed(
                                  c,
                                  Routes.receive,
                                  // arguments: state.wallet!,
                                );
                              },
                              icon: const Icon(Icons.call_received),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                if (!showInfo)
                  // const SizedBox(height: 48),
                  TransactionsView()
                else
                  const WalletInfo()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WalletInfo extends StatelessWidget {
  const WalletInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    final wallet = c.select((WalletsCubit wc) => wc.state.selectedWallet!);

    return FadeIn(
      delay: const Duration(milliseconds: 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),

          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              'WALLET INFORMATION',
              style: c.fonts.overline!.copyWith(
                color: c.colours.onBackground,
              ),
            ),
          ),
          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.only(left: 16),
            width: c.width * 0.8,
            child: Text(
              wallet.descriptor,
              maxLines: 10,
              textAlign: TextAlign.left,
              style: c.fonts.caption!.copyWith(
                color: c.colours.onBackground.withOpacity(0.9),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {},
              child: const Text('COPY'),
            ),
          )

          // for (var transaction in transactions)
          //   TransactionCell(transaction: transaction),

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
      ),
    );
  }
}
