import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sats/cubit/wallet/history.dart';
import 'package:sats/cubit/wallet/send.dart';
import 'package:sats/cubit/wallet/wallets.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/back-button.dart';
import 'package:sats/view/common/loading.dart';
import 'package:sats/view/common/log-button.dart';

class WalletDetails extends StatelessWidget {
  const WalletDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final walletName = context.select(
      (WalletsCubit wc) => wc.state.selectedWallet!.label,
    );
    final balance = context.select((SendCubit sc) => sc.state.balance);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          walletName,
          style: context.fonts.headline5!.copyWith(
            color: context.colours.onBackground,
          ),
        ),
        const SizedBox(height: 40),
        if (balance != null) ...[
          Text(
            'Balance'.toUpperCase(),
            style: context.fonts.overline!.copyWith(
              color: context.colours.onBackground,
            ),
          ),
          Text(
            balance.toString() + ' sats',
            style: context.fonts.headline6!.copyWith(
              color: context.colours.onBackground,
            ),
          ),
          Text(
            balance.toBtc() + ' BTC',
            style: context.fonts.caption!.copyWith(
              color: context.colours.onBackground,
            ),
          ),
        ],
      ],
    );
  }
}

class AddressRow extends StatefulWidget {
  const AddressRow({Key? key}) : super(key: key);

  @override
  State<AddressRow> createState() => _AddressRowState();
}

class _AddressRowState extends State<AddressRow> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final address = context.select((SendCubit sc) => sc.state.address);
    final errAddress = context.select((SendCubit sc) => sc.state.errAddress);

    if (address != _controller.text) _controller.text = address;

    return Column(
      children: [
        TextField(
          controller: _controller,
          style: TextStyle(color: context.colours.onBackground),
          decoration: InputDecoration(
            hintText: 'Enter Address'.toUpperCase(),
            errorText: errAddress.nullIfEmpty(),
          ),
          onChanged: (t) {
            context.read<SendCubit>().adddressChanged(t);
          },
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                context.read<SendCubit>().pasteAddress();
              },
              child: const Text('PASTE'),
            ),
            IconButton(
              onPressed: () {
                context.read<SendCubit>().scanAddress(false);
              },
              icon: Icon(
                Icons.qr_code,
                size: 32,
                color: context.colours.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AmountRow extends StatefulWidget {
  const AmountRow({
    Key? key,
  }) : super(key: key);

  @override
  State<AmountRow> createState() => _AmountRowState();
}

class _AmountRowState extends State<AmountRow> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final amount = context.select((SendCubit sc) => sc.state.amount);
    final errAmount = context.select((SendCubit sc) => sc.state.errAmount);

    if (amount != _controller.text) _controller.text = amount;

    return Column(
      children: [
        TextField(
          controller: _controller,
          style: TextStyle(color: context.colours.onBackground),
          decoration: InputDecoration(
            hintText: 'Enter SATS Amount'.toUpperCase(),
            errorText: errAmount.nullIfEmpty(),
          ),
          onChanged: (t) {
            context.read<SendCubit>().amountChanged(t);
          },
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '    BTC: ' + amount.toBtc(),
              style: context.fonts.caption!.copyWith(
                color: context.colours.onBackground.withOpacity(0.7),
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<SendCubit>().emptyWallet();
              },
              child: Text('Empty Wallet'.toUpperCase()),
            ),
          ],
        ),
      ],
    );
  }
}

class NetworkRow extends StatefulWidget {
  const NetworkRow({
    Key? key,
  }) : super(key: key);

  @override
  State<NetworkRow> createState() => _NetworkRowState();
}

class _NetworkRowState extends State<NetworkRow> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendCubit, SendState>(
      builder: (context, state) {
        if (state.feeSlow == null ||
            state.feeMedium == null ||
            state.feefast == null) return Container();

        final slow = state.feeSlow!.toString();
        final medium = state.feeMedium!.toString();
        final fast = state.feefast!.toString();

        if (state.fees != _controller.text) _controller.text = state.fees;

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Opacity(
                      opacity: state.feesOption == 0 ? 1 : 0.6,
                      child: TextButton(
                        onPressed: () {
                          context.read<SendCubit>().feeSelected(0);
                        },
                        child: Text('slow'.toUpperCase()),
                      ),
                    ),
                    Text(
                      '~ 60 minutes\n($slow sats / vbyte)',
                      textAlign: TextAlign.center,
                      style: context.fonts.caption!.copyWith(
                        fontSize: 10,
                        color: context.colours.onBackground.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Opacity(
                      opacity: state.feesOption == 1 ? 1 : 0.6,
                      child: TextButton(
                        onPressed: () {
                          context.read<SendCubit>().feeSelected(1);
                        },
                        child: Text('medium'.toUpperCase()),
                      ),
                    ),
                    Text(
                      '~ 30 minutes\n($medium sats / vbyte)',
                      textAlign: TextAlign.center,
                      style: context.fonts.caption!.copyWith(
                        fontSize: 10,
                        color: context.colours.onBackground.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Opacity(
                      opacity: state.feesOption == 2 ? 1 : 0.6,
                      child: TextButton(
                        onPressed: () {
                          context.read<SendCubit>().feeSelected(2);
                        },
                        child: Text('Fast'.toUpperCase()),
                      ),
                    ),
                    Text(
                      '~ 10 minutes\n($fast sats / vbyte)',
                      textAlign: TextAlign.center,
                      style: context.fonts.caption!.copyWith(
                        fontSize: 10,
                        color: context.colours.onBackground.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _controller,
              style: TextStyle(color: context.colours.onBackground),
              decoration: InputDecoration(
                hintText: 'Enter custom fee rate'.toUpperCase(),
                errorText: state.errFees.nullIfEmpty(),
              ),
              onChanged: (t) {
                context.read<SendCubit>().feeChanged(t);
              },
            ),
          ],
        );
      },
    );
  }
}

class ConfirmTransaction extends StatelessWidget {
  const ConfirmTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.select((SendCubit sc) => sc.state);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 60),
        Text(
          'Confirm\nTransaction',
          style: context.fonts.headline5!.copyWith(
            color: context.colours.onBackground,
          ),
        ),
        const SizedBox(height: 40),
        Text(
          'Address'.toUpperCase(),
          style: context.fonts.overline!.copyWith(
            color: context.colours.onBackground,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '' + state.address,
          style: context.fonts.caption!.copyWith(
            color: context.colours.onBackground,
          ),
        ),
        const SizedBox(height: 60),
        Text(
          'Amount'.toUpperCase(),
          style: context.fonts.overline!.copyWith(
            color: context.colours.onBackground,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '' + state.amount + ' sats',
          style: context.fonts.caption!.copyWith(
            color: context.colours.onBackground,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '' + int.parse(state.amount).toBtc() + ' BTC',
          style: context.fonts.caption!.copyWith(
            color: context.colours.onBackground.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 60),
        Text(
          'Network Fee'.toUpperCase(),
          style: context.fonts.overline!.copyWith(
            color: context.colours.onBackground,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '' + state.feeRate().toString() + ' sats',
          style: context.fonts.caption!.copyWith(
            color: context.colours.onBackground,
          ),
        ),
        const SizedBox(height: 60),
        Text(
          'Total'.toUpperCase(),
          style: context.fonts.overline!.copyWith(
            color: context.colours.onBackground,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '' + state.total().toString() + ' sats',
          style: context.fonts.caption!.copyWith(
            color: context.colours.onBackground,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '' + state.total().toBtc() + ' BTC',
          style: context.fonts.caption!.copyWith(
            color: context.colours.onBackground.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 60),
        TextButton(
          onPressed: () {
            context.read<SendCubit>().sendClicked();
          },
          child: const Text('SEND'),
        )
      ],
    );
  }
}

class TransactionComplete extends StatelessWidget {
  const TransactionComplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final txid = context.select((SendCubit sc) => sc.state.txId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 60),
        Text(
          'Confirm\nTransaction',
          style: context.fonts.headline5!.copyWith(
            color: context.colours.onBackground,
          ),
        ),
        const SizedBox(height: 40),
        Text(
          'Transaction ID'.toUpperCase(),
          style: context.fonts.overline!.copyWith(
            color: context.colours.onBackground,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '' + txid,
          style: context.fonts.caption!.copyWith(
            color: context.colours.onBackground,
          ),
        ),
        const SizedBox(height: 60),
        TextButton(
          onPressed: () {
            context.read<SendCubit>().shareTxId();
          },
          child: const Text('SHARE TRANSACTION ID'),
        )
      ],
    );
  }
}

class WalletSendPage extends StatelessWidget {
  const WalletSendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final confirmstep =
        context.select((SendCubit sc) => sc.state.confirmStep());
    final confirmedStep =
        context.select((SendCubit sc) => sc.state.confirmedStep());

    return WillPopScope(
      onWillPop: () async {
        if (confirmstep) {
          context.read<SendCubit>().clearPsbt();
          return false;
        }
        // if (confirmedStep) context.read<HistoryCubit>().getHistory();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocConsumer<SendCubit, SendState>(
                listener: (context, state) async {
                  if (state.zeroBalanceAmt()) {
                    await Future.delayed(const Duration(milliseconds: 2000));
                    Navigator.pop(context);
                  }
                },
                listenWhen: (p, c) =>
                    p.zeroBalanceAmt().not(c.zeroBalanceAmt()),
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (state.loadingStart)
                        const Loading(
                          text: 'Loading Details',
                        ),
                      if (state.buildingTx)
                        const Loading(
                          text: 'Building Transaction',
                        ),
                      if (state.sendingTx)
                        const Loading(
                          text: 'Sending Amount',
                        ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Back(
                            onPressed: () {
                              if (confirmstep) {
                                context.read<SendCubit>().clearPsbt();
                                return;
                              }
                              // if (confirmedStep)
                              //   context.read<HistoryCubit>().getHistory();
                              Navigator.pop(context);
                            },
                          ),
                          LogButton(
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.lightbulb_outline_sharp,
                                size: 32,
                                color: context.colours.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      if (state.zeroBalanceAmt()) ...[
                        Text(
                          'SORRY !\nYou have\nZero\nBalance.',
                          style: context.fonts.headline5!.copyWith(
                            color: context.colours.onBackground,
                          ),
                        ),
                      ],
                      if (!confirmstep &&
                          !state.zeroBalanceAmt() &&
                          !confirmedStep &&
                          !state.loadingStart &&
                          !state.buildingTx) ...[
                        const WalletDetails(),
                        const SizedBox(height: 80),
                        Text(
                          'To Address'.toUpperCase(),
                          style: context.fonts.overline!.copyWith(
                            color: context.colours.onBackground,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const AddressRow(),
                        const SizedBox(height: 60),
                        Text(
                          'Amount'.toUpperCase(),
                          style: context.fonts.overline!.copyWith(
                            color: context.colours.onBackground,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const AmountRow(),
                        const SizedBox(height: 60),
                        Text(
                          'Network Fee'.toUpperCase(),
                          style: context.fonts.overline!.copyWith(
                            color: context.colours.onBackground,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const NetworkRow(),
                        const SizedBox(height: 100),
                        TextButton(
                          onPressed: () {
                            context.read<SendCubit>().confirmClicked();
                          },
                          child: const Text('CONFIRM'),
                        ),
                      ],
                      if (confirmstep && !state.sendingTx)
                        FadeIn(child: const ConfirmTransaction()),
                      if (confirmedStep)
                        FadeIn(child: const TransactionComplete()),
                      const SizedBox(height: 80),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
