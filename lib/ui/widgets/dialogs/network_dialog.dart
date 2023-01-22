/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/util/service_locator.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NetworkDialog {
  static Future<NetworksSetting?> getDialog(
    BuildContext context,
    WidgetRef ref,
    NetworksSetting curNetworksSetting,
  ) async {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;
    final endpointFocusNode = FocusNode();
    final endpointController = TextEditingController();
    String? endpointError;

    final pickerItemsList = List<PickerItem>.empty(growable: true);
    for (final value in AvailableNetworks.values) {
      var _networkDevEndpoint = '';
      if (value == AvailableNetworks.archethicDevNet &&
          _networkDevEndpoint.isEmpty) {
        _networkDevEndpoint = 'http://localhost:4000';
      }
      final networkSetting = NetworksSetting(
        network: value,
        networkDevEndpoint: _networkDevEndpoint,
      );
      pickerItemsList.add(
        PickerItem(
          networkSetting.getDisplayName(context),
          networkSetting.getLink(),
          '${theme.assetsFolder!}${theme.logoAlone!}.png',
          null,
          networkSetting,
          true,
        ),
      );
    }

    return showDialog<NetworksSetting>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return _NetworkAlertDialog(
          title: const _NetworkTitle(),
          content: PickerWidget(
            pickerItems: pickerItemsList,
            selectedIndex: curNetworksSetting.getIndex(),
            onSelected: (value) async {
              final selectedNetworkSettings = value.value as NetworksSetting;
              await ref
                  .read(SettingsProviders.settings.notifier)
                  .setNetwork(selectedNetworkSettings);

              // If selected network is DevNet
              // Show a dialog to enter a custom network
              // else use the network selected
              if (selectedNetworkSettings.network ==
                  AvailableNetworks.archethicDevNet) {
                endpointController.text =
                    selectedNetworkSettings.networkDevEndpoint;

                await showDialog<AvailableNetworks>(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return _NetworkDialogCustomInput(
                          endpointFocusNode: endpointFocusNode,
                          endpointController: endpointController,
                          endpointError: endpointError,
                          onSubmitNetwork: () async {
                            void setError(String errorText) {
                              setState(() {
                                endpointError = errorText;
                                FocusScope.of(context).requestFocus(
                                  endpointFocusNode,
                                );
                              });
                            }

                            if (endpointController.text.isEmpty) {
                              setError(localizations.enterEndpointBlank);
                              return;
                            }

                            // Uri seem to accept whitespace. So I need to remove bad formated Uri.
                            final textCleaned =
                                endpointController.text.replaceAll(' ', '');

                            final uriInput = Uri.parse(textCleaned);

                            if (uriInput.isAbsolute == false) {
                              setError(localizations.enterEndpointNotValid);
                              return;
                            }

                            try {
                              final nodeListMain = await ApiService(
                                'https://mainnet.archethic.net',
                              ).getNodeList();

                              final nodeListTest = await ApiService(
                                'https://testnet.archethic.net',
                              ).getNodeList();

                              if (nodeListMain.any(
                                (node) =>
                                    node.ip == uriInput.host &&
                                    node.port == uriInput.port,
                              )) {
                                setError(localizations.enterEndpointNotValid);
                                return;
                              }
                              if (nodeListTest.any(
                                (node) =>
                                    node.ip == uriInput.host &&
                                    node.port == uriInput.port,
                              )) {
                                setError(localizations.enterEndpointNotValid);
                                return;
                              }
                            } catch (e) {
                              setError(localizations.enterEndpointNotValid);
                              return;
                            }

                            await ref
                                .read(
                                  SettingsProviders.settings.notifier,
                                )
                                .setNetwork(
                                  NetworksSetting(
                                    network: AvailableNetworks.archethicDevNet,
                                    networkDevEndpoint: textCleaned,
                                  ),
                                );

                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  },
                );
              }
              await setupServiceLocator();

              Navigator.pop(context, selectedNetworkSettings);
            },
          ),
        );
      },
    );
  }
}

class _NetworkDialogCustomInput extends ConsumerWidget {
  const _NetworkDialogCustomInput({
    required this.endpointFocusNode,
    required this.endpointController,
    required this.endpointError,
    required this.onSubmitNetwork,
  });

  final FocusNode endpointFocusNode;
  final TextEditingController endpointController;
  final String? endpointError;
  final Function() onSubmitNetwork;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return _NetworkAlertDialog(
      title: const Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: _NetworkDevnetLogo(),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AppTextField(
                key: const Key('networkChoice'),
                leftMargin: 0,
                rightMargin: 0,
                focusNode: endpointFocusNode,
                controller: endpointController,
                labelText: localizations.enterEndpoint,
                keyboardType: TextInputType.text,
                style: theme.textStyleSize14W600Primary,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(28),
                ],
              ),
              Text(
                'http://xxx.xxx.xxx.xxx:xxxx',
                style: theme.textStyleSize12W400Primary,
              ),
              if (endpointError != null)
                _NetworkErrorMessage(
                  endpointError: endpointError,
                )
              else
                const SizedBox(),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              AppButtonTiny(
                AppButtonTinyType.primary,
                localizations.ok,
                Dimens.buttonTopDimens,
                key: const Key('addEndpoint'),
                onPressed: onSubmitNetwork,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NetworkAlertDialog extends ConsumerWidget {
  const _NetworkAlertDialog({required this.content, required this.title});

  final Widget content;
  final Widget title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return AlertDialog(
      title: title,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        side: BorderSide(
          color: theme.text45!,
        ),
      ),
      content: content,
    );
  }
}

class _NetworkTitle extends ConsumerWidget {
  const _NetworkTitle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        localizations.networksHeader,
        style: theme.textStyleSize24W700EquinoxPrimary,
      ),
    );
  }
}

class _NetworkDevnetLogo extends ConsumerWidget {
  const _NetworkDevnetLogo();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;

    return Column(
      children: [
        SvgPicture.asset(
          '${theme.assetsFolder!}${theme.logoAlone!}.svg',
          height: 30,
        ),
        Text(
          ref.read(SettingsProviders.settings).network.getDisplayName(context),
          key: const Key('networkName'),
          style: theme.textStyleSize10W100Primary,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          localizations.enterEndpointHeader,
          style: theme.textStyleSize16W400Primary,
        ),
      ],
    );
  }
}

class _NetworkErrorMessage extends ConsumerWidget {
  const _NetworkErrorMessage({
    required this.endpointError,
  });

  final String? endpointError;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Container(
      margin: const EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      child: Text(
        endpointError!,
        style: theme.textStyleSize14W600Primary,
      ),
    );
  }
}
