import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sats/cubit/address-book.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/back-button.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = context.select(
      (AddressBookCubit abc) => abc.state.users,
    );

    return FadeIn(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 40),
          Text(
            ' Your Network',
            style: context.fonts.headline4!.copyWith(
              color: context.colours.onBackground,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                context.read<AddressBookCubit>().editUserSelected();
              },
              child: Text('Create New User'.toUpperCase()),
            ),
          ),
          const SizedBox(height: 40),
          if (users.isEmpty) ...[
            Text(
              ' No Contacts',
              style: context.fonts.headline6!.copyWith(
                color: context.colours.onBackground,
              ),
            ),
          ] else
            for (final user in users) ...[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(context.colours.surface),
                  alignment: Alignment.centerLeft,
                ),
                onPressed: () {
                  context.read<AddressBookCubit>().userSelected(user);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
                  child: Text(
                    user.name,
                    textAlign: TextAlign.left,
                    style: context.fonts.button!.copyWith(
                      color: context.colours.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ]
        ],
      ),
    );
  }
}

class KeyList extends StatelessWidget {
  const KeyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select(
      (AddressBookCubit abc) => abc.state.selectedUser,
    );

    if (user == null) return Container();

    return FadeIn(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 40),
          Text(
            '  ' + user.name,
            style: context.fonts.headline6!.copyWith(
              color: context.colours.onBackground,
            ),
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  context.read<AddressBookCubit>().editKeySelected();
                },
                child: const Text('NEW PUBLIC KEY'),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  context.read<AddressBookCubit>().editUserSelected();
                },
                child: const Text('EDIT'),
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: () {
                  context.read<AddressBookCubit>().deleteUserClicked();
                },
                child: Text(
                  'DELETE',
                  style: context.fonts.button!.copyWith(
                    color: context.colours.error.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          if (user.keys == null || user.keys!.isEmpty) ...[
            Text(
              '   No Public Keys',
              style: context.fonts.subtitle1!.copyWith(
                color: context.colours.onBackground,
              ),
            ),
          ] else
            for (final key in user.keys!) ...[
              ElevatedButton(
                onPressed: () {
                  context.read<AddressBookCubit>().keySelected(key);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(context.colours.surface),
                  alignment: Alignment.centerLeft,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
                  child: Text(
                    key.name,
                    style: context.fonts.button!.copyWith(
                      color: context.colours.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class KeyProfile extends StatelessWidget {
  const KeyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final key = context.select(
      (AddressBookCubit abc) => abc.state.selectedKey,
    );

    if (key == null) return Container();

    return FadeIn(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text(
            '    ' + key.name,
            style: context.fonts.headline6!.copyWith(
              color: context.colours.onBackground,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  context.read<AddressBookCubit>().editKeySelected();
                },
                child: const Text('EDIT'),
              ),
              TextButton(
                onPressed: () {
                  context.read<AddressBookCubit>().deleteKeyClicked();
                },
                child: const Text('DELETE'),
              ),
            ],
          ),
          const SizedBox(height: 80),
          Text(
            'PUBLIC KEY',
            style: context.fonts.overline!.copyWith(
              color: context.colours.onBackground,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            key.publicKey,
            style: context.fonts.bodyText1!.copyWith(
              color: context.colours.onBackground,
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              context.read<AddressBookCubit>().copyKey();
            },
            child: const Text('COPY'),
          ),
        ],
      ),
    );
  }
}

class EditUser extends StatelessWidget {
  const EditUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 80),
          const UserNameField(),
          const SizedBox(height: 40),
          TextButton(
            onPressed: () {
              context.read<AddressBookCubit>().saveUserClicked();
            },
            child: const Text('SAVE'),
          ),
          const SizedBox(height: 40),
          TextButton(
            onPressed: () {
              context.read<AddressBookCubit>().cancelUserEdit();
            },
            child: const Text('CANCEL'),
          ),
        ],
      ),
    );
  }
}

class EditKey extends StatelessWidget {
  const EditKey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 80),
          const KeyNameField(),
          const SizedBox(height: 40),
          const KeyValueField(),
          const SizedBox(height: 100),
          TextButton(
            onPressed: () {
              context.read<AddressBookCubit>().saveKeyClicked();
            },
            child: const Text('SAVE'),
          ),
          const SizedBox(height: 40),
          TextButton(
            onPressed: () {
              context.read<AddressBookCubit>().cancelKeyEdit();
            },
            child: const Text('CANCEL'),
          ),
        ],
      ),
    );
  }
}

class UserNameField extends StatefulWidget {
  const UserNameField({Key? key}) : super(key: key);

  @override
  _UserNameFieldState createState() => _UserNameFieldState();
}

class _UserNameFieldState extends State<UserNameField> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final username =
        context.select((AddressBookCubit abc) => abc.state.editUserName);
    final errUsername =
        context.select((AddressBookCubit sc) => sc.state.errEditUserName);

    if (username != _controller.text) _controller.text = username;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _controller,
          style: TextStyle(color: context.colours.onBackground),
          decoration: InputDecoration(
            hintText: 'Enter Name'.toUpperCase(),
            errorText: errUsername.nullIfEmpty(),
          ),
          onChanged: (t) {
            context.read<AddressBookCubit>().userNameChanged(t);
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class KeyNameField extends StatefulWidget {
  const KeyNameField({Key? key}) : super(key: key);

  @override
  State<KeyNameField> createState() => _KeyNameFieldState();
}

class _KeyNameFieldState extends State<KeyNameField> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final keyname =
        context.select((AddressBookCubit abc) => abc.state.editKeyName);
    final errKeyName =
        context.select((AddressBookCubit sc) => sc.state.errKeyName);

    if (keyname != _controller.text) _controller.text = keyname;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _controller,
          style: TextStyle(color: context.colours.onBackground),
          decoration: InputDecoration(
            hintText: 'Enter Key Name'.toUpperCase(),
            errorText: errKeyName.nullIfEmpty(),
          ),
          onChanged: (t) {
            context.read<AddressBookCubit>().keyNameChanged(t);
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class KeyValueField extends StatefulWidget {
  const KeyValueField({Key? key}) : super(key: key);

  @override
  State<KeyValueField> createState() => _KeyValueFieldState();
}

class _KeyValueFieldState extends State<KeyValueField> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final keyValue =
        context.select((AddressBookCubit abc) => abc.state.editPublicKey);
    final errKeyValue =
        context.select((AddressBookCubit sc) => sc.state.errEditPublicKey);

    if (keyValue != _controller.text) _controller.text = keyValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _controller,
          style: TextStyle(color: context.colours.onBackground),
          decoration: InputDecoration(
            hintText: 'Enter Public Key'.toUpperCase(),
            errorText: errKeyValue.nullIfEmpty(),
          ),
          onChanged: (t) {
            context.read<AddressBookCubit>().publicKeyChanged(t);
          },
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                context.read<AddressBookCubit>().pasteKey();
              },
              child: const Text('PASTE'),
            ),
            Container(),
          ],
        ),
      ],
    );
  }
}

class AddressBookPage extends StatelessWidget {
  const AddressBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final canGoBack = context.select(
      (AddressBookCubit abc) => abc.state.canGoBack(),
    );

    return WillPopScope(
      onWillPop: () async {
        if (!canGoBack) {
          context.read<AddressBookCubit>().onBackPress();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<AddressBookCubit, AddressBookState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Back(
                        onPressed: () {
                          if (!canGoBack) {
                            context.read<AddressBookCubit>().onBackPress();
                          } else
                            Navigator.pop(context);
                        },
                      ),
                      if (state.editKeyDetails) ...[
                        const EditKey(),
                      ] else if (state.selectedKey != null) ...[
                        const KeyProfile(),
                      ] else if (state.editUserDetails) ...[
                        const EditUser(),
                      ] else if (state.selectedUser != null) ...[
                        const KeyList(),
                      ] else if (state.selectedUser == null) ...[
                        const UserList()
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
