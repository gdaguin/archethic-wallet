/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../add_contact.dart';

class AddContactTextFieldPublicKey extends ConsumerStatefulWidget {
  const AddContactTextFieldPublicKey({
    super.key,
  });

  @override
  ConsumerState<AddContactTextFieldPublicKey> createState() =>
      _AddContactTextFieldPublicKeyState();
}

class _AddContactTextFieldPublicKeyState
    extends ConsumerState<AddContactTextFieldPublicKey> {
  late FocusNode publicKeyFocusNode;
  late TextEditingController publicKeyController;

  @override
  void initState() {
    super.initState();
    publicKeyFocusNode = FocusNode();
    publicKeyController = TextEditingController();
  }

  @override
  void dispose() {
    publicKeyFocusNode.dispose();
    publicKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;
    final preferences = ref.watch(SettingsProviders.settings);
    final hasQRCode = ref.watch(DeviceAbilities.hasQRCodeProvider);
    final contactCreationNotifier =
        ref.watch(ContactCreationFormProvider.contactCreationForm.notifier);

    return AppTextField(
      focusNode: publicKeyFocusNode,
      controller: publicKeyController,
      style: theme.textStyleSize14W100Primary,
      inputFormatters: <TextInputFormatter>[
        UpperCaseTextFormatter(),
        LengthLimitingTextInputFormatter(68),
      ],
      textInputAction: TextInputAction.done,
      maxLines: 4,
      autocorrect: false,
      labelText: localizations.publicKeyHint,
      prefixButton: hasQRCode
          ? TextFieldButton(
              icon: FontAwesomeIcons.qrcode,
              onPressed: () async {
                sl.get<HapticUtil>().feedback(
                      FeedbackType.light,
                      preferences.activeVibrations,
                    );
                UIUtil.cancelLockEvent();
                final scanResult = await UserDataUtil.getQRData(
                  DataType.raw,
                  context,
                  ref,
                );
                if (scanResult == null) {
                  UIUtil.showSnackbar(
                    AppLocalization.of(context)!.qrInvalidAddress,
                    context,
                    ref,
                    theme.text!,
                    theme.snackBarShadow!,
                  );
                } else if (QRScanErrs.errorList.contains(scanResult)) {
                  UIUtil.showSnackbar(
                    scanResult,
                    context,
                    ref,
                    theme.text!,
                    theme.snackBarShadow!,
                  );
                  return;
                } else {
                  contactCreationNotifier.setPublicKey(
                    scanResult,
                  );
                }
              },
            )
          : null,
      fadePrefixOnCondition: true,
      prefixShowFirstCondition: true,
      suffixButton: TextFieldButton(
        icon: FontAwesomeIcons.paste,
        onPressed: () async {
          sl.get<HapticUtil>().feedback(
                FeedbackType.light,
                preferences.activeVibrations,
              );
          final data = await UserDataUtil.getClipboardText(
            DataType.raw,
          );
          contactCreationNotifier.setPublicKey(
            data!,
          );
        },
      ),
      fadeSuffixOnCondition: true,
      suffixShowFirstCondition: true,
      onChanged: (String text) {
        contactCreationNotifier.setPublicKey(text);
      },
    );
  }
}