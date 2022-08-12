/// SPDX-License-Identifier: AGPL-3.0-or-later
// ignore_for_file: avoid_unnecessary_containers

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart' show ApiService;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/tokens_fungibles/add_token_confirm.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';

class AddTokenSheet extends StatefulWidget {
  const AddTokenSheet({
    super.key,
    this.primaryCurrency,
  });

  final PrimaryCurrencySetting? primaryCurrency;

  @override
  State<AddTokenSheet> createState() => _AddTokenSheetState();
}

enum PrimaryCurrency { network, selected }

class _AddTokenSheetState extends State<AddTokenSheet> {
  FocusNode? _nameFocusNode;
  FocusNode? _symbolFocusNode;
  FocusNode? _initialSupplyFocusNode;
  TextEditingController? _nameController;
  TextEditingController? _symbolController;
  TextEditingController? _initialSupplyController;

  String? _nameValidationText;
  String? _symbolValidationText;
  String? _initialSupplyValidationText;

  bool? animationOpen;
  double feeEstimation = 0.0;
  bool? _isPressed;
  bool validRequest = true;
  PrimaryCurrency primaryCurrency = PrimaryCurrency.network;

  @override
  void initState() {
    super.initState();
    if (widget.primaryCurrency!.primaryCurrency.name ==
        PrimaryCurrencySetting(AvailablePrimaryCurrency.native)
            .primaryCurrency
            .name) {
      primaryCurrency = PrimaryCurrency.network;
    } else {
      primaryCurrency = PrimaryCurrency.selected;
    }
    _isPressed = false;
    _nameFocusNode = FocusNode();
    _symbolFocusNode = FocusNode();
    _initialSupplyFocusNode = FocusNode();
    _nameController = TextEditingController();
    _symbolController = TextEditingController();
    _initialSupplyController = TextEditingController();
    _nameValidationText = '';
    _symbolValidationText = '';
    _initialSupplyValidationText = '';
  }

  @override
  Widget build(BuildContext context) {
    final double bottom = MediaQuery.of(context).viewInsets.bottom;
    return TapOutsideUnfocus(
      child: SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  width: 60,
                ),
                Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.15,
                      decoration: BoxDecoration(
                        color: StateContainer.of(context).curTheme.text60,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width - 140),
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: [
                              SvgPicture.asset(
                                '${StateContainer.of(context).curTheme.assetsFolder!}${StateContainer.of(context).curTheme.logoAlone!}.svg',
                                height: 30,
                              ),
                              Text(
                                  StateContainer.of(context)
                                      .curNetwork
                                      .getDisplayName(context),
                                  style: AppStyles.textStyleSize10W100Primary(
                                      context)),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ), // Header
                          AutoSizeText(
                            AppLocalization.of(context)!.createFungibleToken,
                            style: AppStyles.textStyleSize24W700EquinoxPrimary(
                                context),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            stepGranularity: 0.1,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          StateContainer.of(context).showBalance
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    primaryCurrency == PrimaryCurrency.selected
                                        ? Column(
                                            children: [
                                              _balanceSelected(context, true),
                                              _balanceNetwork(context, false),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              _balanceNetwork(context, true),
                                              _balanceSelected(context, false),
                                            ],
                                          ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.change_circle),
                                      alignment: Alignment.centerRight,
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .textFieldIcon,
                                      onPressed: () {
                                        sl.get<HapticUtil>().feedback(
                                            FeedbackType.light,
                                            StateContainer.of(context)
                                                .activeVibrations);
                                        if (primaryCurrency ==
                                            PrimaryCurrency.network) {
                                          setState(() {
                                            primaryCurrency =
                                                PrimaryCurrency.selected;
                                          });
                                        } else {
                                          setState(() {
                                            primaryCurrency =
                                                PrimaryCurrency.network;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 60,
                  height: 40,
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _nameFocusNode!.unfocus();
                        _symbolFocusNode!.unfocus();
                        _initialSupplyFocusNode!.unfocus();
                      },
                      child: Container(
                        color: Colors.transparent,
                        constraints: const BoxConstraints.expand(),
                        child: const SizedBox.expand(),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: bottom + 80),
                        child: Column(
                          children: <Widget>[
                            AppTextField(
                              focusNode: _nameFocusNode,
                              controller: _nameController,
                              cursorColor:
                                  StateContainer.of(context).curTheme.text,
                              textInputAction: TextInputAction.next,
                              labelText:
                                  AppLocalization.of(context)!.tokenNameHint,
                              autocorrect: false,
                              keyboardType: TextInputType.text,
                              style:
                                  AppStyles.textStyleSize16W600Primary(context),
                              inputFormatters: <
                                  LengthLimitingTextInputFormatter>[
                                LengthLimitingTextInputFormatter(40),
                              ],
                              onChanged: (_) async {
                                double fee = await getFee();
                                // Always reset the error message to be less annoying
                                setState(() {
                                  feeEstimation = fee;
                                });
                              },
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(_nameValidationText!,
                                  style: AppStyles.textStyleSize14W600Primary(
                                      context)),
                            ),
                            AppTextField(
                              focusNode: _symbolFocusNode,
                              controller: _symbolController,
                              cursorColor:
                                  StateContainer.of(context).curTheme.text,
                              textInputAction: TextInputAction.next,
                              labelText:
                                  AppLocalization.of(context)!.tokenSymbolHint,
                              autocorrect: false,
                              keyboardType: TextInputType.text,
                              style:
                                  AppStyles.textStyleSize16W600Primary(context),
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                                LengthLimitingTextInputFormatter(4),
                              ],
                              onChanged: (_) async {
                                double fee = await getFee();
                                // Always reset the error message to be less annoying
                                setState(() {
                                  feeEstimation = fee;
                                });
                              },
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(_symbolValidationText!,
                                  style: AppStyles.textStyleSize14W600Primary(
                                      context)),
                            ),
                            AppTextField(
                              focusNode: _initialSupplyFocusNode,
                              controller: _initialSupplyController,
                              cursorColor:
                                  StateContainer.of(context).curTheme.text,
                              textInputAction: TextInputAction.next,
                              labelText: AppLocalization.of(context)!
                                  .tokenInitialSupplyHint,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: false, decimal: false),
                              style:
                                  AppStyles.textStyleSize16W600Primary(context),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(23),
                                FilteringTextInputFormatter.digitsOnly,
                                ThousandsSeparatorInputFormatter()
                              ],
                              onChanged: (_) async {
                                double fee = await getFee();
                                // Always reset the error message to be less annoying
                                setState(() {
                                  feeEstimation = fee;
                                });
                              },
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                _initialSupplyValidationText!,
                                style: AppStyles.textStyleSize14W600Primary(
                                    context),
                              ),
                            ),
                            feeEstimation > 0
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 30),
                                    child: Text(
                                      '${AppLocalization.of(context)!.estimatedFees}: $feeEstimation ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                                      style:
                                          AppStyles.textStyleSize14W100Primary(
                                              context),
                                      textAlign: TextAlign.justify,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 30),
                                    child: Text(
                                      AppLocalization.of(context)!
                                          .estimatedFeesAddTokenNote,
                                      style:
                                          AppStyles.textStyleSize14W100Primary(
                                              context),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _isPressed == true
                          ? AppButton.buildAppButton(
                              const Key('createToken'),
                              context,
                              AppButtonType.primaryOutline,
                              AppLocalization.of(context)!.createToken,
                              Dimens.buttonTopDimens,
                              onPressed: () {},
                            )
                          : AppButton.buildAppButton(
                              const Key('createToken'),
                              context,
                              AppButtonType.primary,
                              AppLocalization.of(context)!.createToken,
                              Dimens.buttonTopDimens,
                              onPressed: () async {
                                setState(() {
                                  _isPressed = true;
                                });

                                validRequest = await _validateRequest();
                                if (validRequest) {
                                  Sheets.showAppHeightNineSheet(
                                    onDisposed: () {
                                      if (mounted) {
                                        setState(() {
                                          _isPressed = false;
                                        });
                                      }
                                    },
                                    context: context,
                                    widget: AddTokenConfirm(
                                      tokenName: _nameController!.text,
                                      tokenSymbol: _symbolController!.text,
                                      feeEstimation: feeEstimation,
                                      tokenInitialSupply: int.tryParse(
                                          _initialSupplyController!.text
                                              .replaceAll(' ', '')),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    _isPressed = false;
                                  });
                                }
                              },
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _validateRequest() async {
    bool isValid = true;
    setState(() {
      _nameValidationText = '';
      _symbolValidationText = '';
      _initialSupplyValidationText = '';
    });
    if (_nameController!.text.isEmpty) {
      isValid = false;
      setState(() {
        _nameValidationText = AppLocalization.of(context)!.tokenNameMissing;
      });
    }
    if (_symbolController!.text.isEmpty) {
      isValid = false;
      setState(() {
        _symbolValidationText = AppLocalization.of(context)!.tokenSymbolMissing;
      });
    }
    if (_initialSupplyController!.text.isEmpty) {
      isValid = false;
      setState(() {
        _initialSupplyValidationText =
            AppLocalization.of(context)!.tokenInitialSupplyMissing;
      });
    } else {
      if (int.tryParse(_initialSupplyController!.text.replaceAll(' ', '')) ==
              null ||
          int.tryParse(_initialSupplyController!.text.replaceAll(' ', ''))! <=
              0) {
        isValid = false;
        setState(() {
          _initialSupplyValidationText =
              AppLocalization.of(context)!.tokenInitialSupplyPositive;
        });
      } else {
        if (int.tryParse(_initialSupplyController!.text.replaceAll(' ', ''))! >
            9999999999) {
          isValid = false;
          setState(() {
            _initialSupplyValidationText =
                AppLocalization.of(context)!.tokenInitialSupplyTooHigh;
          });
        }
      }
    }
    // Estimation of fees
    feeEstimation = await getFee();

    if (feeEstimation >
        StateContainer.of(context)
            .appWallet!
            .appKeychain!
            .getAccountSelected()!
            .balance!
            .nativeTokenValue!) {
      isValid = false;
      setState(() {
        _initialSupplyValidationText = AppLocalization.of(context)!
            .insufficientBalance
            .replaceAll(
                '%1',
                StateContainer.of(context)
                    .curNetwork
                    .getNetworkCryptoCurrencyLabel());
      });
    }

    return isValid;
  }

  Future<double> getFee() async {
    double fee = 0;
    if (_initialSupplyController!.text.isEmpty ||
        _symbolController!.text.isEmpty ||
        _nameController!.text.isEmpty) {
      return fee;
    }
    try {
      final String? seed = await StateContainer.of(context).getSeed();
      final String originPrivateKey = sl.get<ApiService>().getOriginKey();
      fee = await sl.get<AppService>().getFeesEstimationCreateToken(
          originPrivateKey,
          seed!,
          _nameController!.text,
          _symbolController!.text,
          'fungible',
          int.tryParse(_initialSupplyController!.text.replaceAll(' ', ''))!,
          StateContainer.of(context)
              .appWallet!
              .appKeychain!
              .getAccountSelected()!
              .name!);
    } catch (e) {
      fee = 0;
    }
    return fee;
  }

  Widget _balanceNetwork(BuildContext context, bool primary) {
    return Container(
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          text: '',
          children: <InlineSpan>[
            TextSpan(
              text: '(',
              style: primary
                  ? AppStyles.textStyleSize16W100Primary(context)
                  : AppStyles.textStyleSize14W100Primary(context),
            ),
            TextSpan(
              text:
                  '${StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.nativeTokenValueToString()} ${StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.nativeTokenName!}',
              style: primary
                  ? AppStyles.textStyleSize16W700Primary(context)
                  : AppStyles.textStyleSize14W700Primary(context),
            ),
            TextSpan(
              text: ')',
              style: primary
                  ? AppStyles.textStyleSize16W100Primary(context)
                  : AppStyles.textStyleSize14W100Primary(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _balanceSelected(BuildContext context, bool primary) {
    return Container(
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          text: '',
          children: <InlineSpan>[
            TextSpan(
              text: '(',
              style: primary
                  ? AppStyles.textStyleSize16W100Primary(context)
                  : AppStyles.textStyleSize14W100Primary(context),
            ),
            TextSpan(
              text: CurrencyUtil.getConvertedAmount(
                  StateContainer.of(context).curCurrency.currency.name,
                  StateContainer.of(context)
                      .appWallet!
                      .appKeychain!
                      .getAccountSelected()!
                      .balance!
                      .fiatCurrencyValue!),
              style: primary
                  ? AppStyles.textStyleSize16W700Primary(context)
                  : AppStyles.textStyleSize14W700Primary(context),
            ),
            TextSpan(
              text: ')',
              style: primary
                  ? AppStyles.textStyleSize16W100Primary(context)
                  : AppStyles.textStyleSize14W100Primary(context),
            ),
          ],
        ),
      ),
    );
  }
}