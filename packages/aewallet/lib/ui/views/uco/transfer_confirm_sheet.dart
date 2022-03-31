// ignore_for_file: cancel_subscriptions, always_specify_types

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/util/ui_util.dart';
import 'package:aeuniverse/ui/views/ledger_screen.dart';
import 'package:aeuniverse/ui/views/pin_screen.dart';
import 'package:aeuniverse/ui/views/yubikey_screen.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/dialog.dart';
import 'package:aeuniverse/util/preferences.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/ui/views/nft/nft_transfer_list.dart';
import 'package:aewallet/ui/views/uco/absinthe_socket.dart';
import 'package:aewallet/ui/views/uco/uco_transfer_list.dart';
import 'package:core/bus/authenticated_event.dart';
import 'package:core/localization.dart';
import 'package:core/model/authentication_method.dart';
import 'package:core/model/data/hive_db.dart';
import 'package:core/service/app_service.dart';
import 'package:core/util/biometrics_util.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/global_var.dart';
import 'package:core/util/haptic_util.dart';
import 'package:core/util/vault.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:core_ui/ui/util/routes.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show UCOTransfer, NFTTransfer, TransactionStatus;

class TransferConfirmSheet extends StatefulWidget {
  const TransferConfirmSheet(
      {Key? key,
      required this.lastAddress,
      required this.typeTransfer,
      this.contactsRef,
      required this.feeEstimation,
      this.title,
      this.ucoTransferList,
      this.nftTransferList})
      : super(key: key);

  final String? lastAddress;
  final String? typeTransfer;
  final String? title;
  final List<Contact>? contactsRef;
  final double? feeEstimation;
  final List<UCOTransfer>? ucoTransferList;
  final List<NFTTransfer>? nftTransferList;

  @override
  _TransferConfirmSheetState createState() => _TransferConfirmSheetState();
}

class _TransferConfirmSheetState extends State<TransferConfirmSheet> {
  bool? animationOpen;

  StreamSubscription<AuthenticatedEvent>? _authSub;
  StreamSubscription<TransactionSendEvent>? _sendTxSub;

  void _registerBus() {
    _authSub = EventTaxiImpl.singleton()
        .registerTo<AuthenticatedEvent>()
        .listen((AuthenticatedEvent event) {
      if (event.authType == AUTH_EVENT_TYPE.send) {
        _doSend();
      }
    });

    _sendTxSub = EventTaxiImpl.singleton()
        .registerTo<TransactionSendEvent>()
        .listen((TransactionSendEvent event) {
      if (event.response != 'pending') {
        // Send failed
        if (animationOpen!) {
          Navigator.of(context).pop();
        }
        UIUtil.showSnackbar(
            AppLocalization.of(context)!.sendError +
                ' (' +
                event.response! +
                ')',
            context,
            StateContainer.of(context).curTheme.primary!,
            StateContainer.of(context).curTheme.overlay80!);
        Navigator.of(context).pop();
      } else {
        UIUtil.showSnackbar(
            AppLocalization.of(context)!.transferSuccess,
            context,
            StateContainer.of(context).curTheme.primary!,
            StateContainer.of(context).curTheme.overlay80!,
            duration: const Duration(milliseconds: 5000));
        setState(() {
          StateContainer.of(context).requestUpdate(
              account: StateContainer.of(context).selectedAccount);
        });
        Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
      }
    });
  }

  void _destroyBus() {
    if (_authSub != null) {
      _authSub!.cancel();
    }
    if (_sendTxSub != null) {
      _sendTxSub!.cancel();
    }
  }

  Map<String, String> transactionConfirmed = {};
  String toto = 'nulllllll';
  @override
  void initState() {
    super.initState();
    //Absinthe.connect(StateContainer.of(context).curNetwork.getLink());
    //_waitConfirmations(widget.lastAddress!);
    _registerBus();

    animationOpen = false;
  }

  /* _waitConfirmations(String lastAddress) async {
    final String operation =
        """subscription { transactionConfirmed(address: "$lastAddress") { nbConfirmations } }""";

    return Absinthe.subscribe(
      StateContainer.of(context).curNetwork.getLink(),
      'transactionConfirmed',
      operation,
      onResult: (payload) async {
        if (payload == null) {
          print('nbConfirmations null');
        } else {
          print('nbConfirmations pas null');
          setState(() {
            toto = transactionConfirmed[payload['data']['transactionConfirmed']
                ['nbConfirmations']]!;
          });
        }
      },
      onError: (error) {
        print('Error ----> $error');
      },
      onCancel: () {
        print("cancelled subscription");
      },
      onAbort: () {
        print("subscription aborted");
      },
      onStart: () {
        print("start subscription");
      },
    );
  }*/

  @override
  void dispose() {
    _destroyBus();
    super.dispose();
  }

  void _showSendingAnimation(BuildContext context) {
    animationOpen = true;
    Navigator.of(context).push(AnimationLoadingOverlay(
        AnimationType.send,
        StateContainer.of(context).curTheme.animationOverlayStrong!,
        StateContainer.of(context).curTheme.animationOverlayMedium!,
        onPoppedCallback: () => animationOpen = false));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            // Sheet handle
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 5,
              width: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                color: StateContainer.of(context).curTheme.primary60,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          widget.title ??
                              AppLocalization.of(context)!.transfering,
                          style: AppStyles.textStyleSize24W700Primary(context),
                        ),
                      ],
                    ),
                  ),
                  Text(toto),
                  Text(
                      AppLocalization.of(context)!.estimatedFees +
                          ': ' +
                          widget.feeEstimation.toString() +
                          ' UCO',
                      style: AppStyles.textStyleSize14W100Primary(context)),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        child: widget.typeTransfer == 'UCO'
                            ? UcoTransferListWidget(
                                listUcoTransfer: widget.ucoTransferList,
                                contacts: widget.contactsRef,
                                displayContextMenu: false,
                              )
                            : widget.typeTransfer == 'NFT'
                                ? NftTransferListWidget(
                                    listNftTransfer: widget.nftTransferList,
                                    contacts: widget.contactsRef,
                                    displayContextMenu: false,
                                  )
                                : const SizedBox(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //A container for CONFIRM and CANCEL buttons
            Container(
              margin: const EdgeInsets.only(top: 10.0, bottom: 0),
              child: Column(
                children: <Widget>[
                  // A row for CONFIRM Button
                  Row(
                    children: <Widget>[
                      // CONFIRM Button
                      AppButton.buildAppButton(
                          const Key('confirm'),
                          context,
                          AppButtonType.primary,
                          AppLocalization.of(context)!.confirm,
                          Dimens.buttonTopDimens, onPressed: () async {
                        final Preferences _preferences =
                            await Preferences.getInstance();
                        // Authenticate
                        final AuthenticationMethod authMethod =
                            _preferences.getAuthMethod();
                        final bool hasBiometrics =
                            await sl.get<BiometricUtil>().hasBiometrics();
                        if (authMethod.method == AuthMethod.biometrics &&
                            hasBiometrics) {
                          try {
                            final bool authenticated = await sl
                                .get<BiometricUtil>()
                                .authenticateWithBiometrics(
                                    context,
                                    AppLocalization.of(context)!
                                        .confirmBiometrics);
                            if (authenticated) {
                              sl
                                  .get<HapticUtil>()
                                  .feedback(FeedbackType.success);
                              EventTaxiImpl.singleton().fire(
                                  AuthenticatedEvent(AUTH_EVENT_TYPE.send));
                            }
                          } catch (e) {
                            await authenticateWithPin();
                          }
                        } else {
                          if (authMethod.method ==
                              AuthMethod.yubikeyWithYubicloud) {
                            await authenticateWithYubikey();
                          } else {
                            if (authMethod.method == AuthMethod.ledger) {
                              await confirmationWithLedger();
                            } else {
                              await authenticateWithPin();
                            }
                          }
                        }
                      }),
                    ],
                  ),
                  // A row for CANCEL Button
                  Row(
                    children: <Widget>[
                      // CANCEL Button
                      AppButton.buildAppButton(
                          const Key('cancel'),
                          context,
                          AppButtonType.primary,
                          AppLocalization.of(context)!.cancel,
                          Dimens.buttonBottomDimens, onPressed: () {
                        Navigator.of(context).pop();
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Future<void> _doSend() async {
    try {
      _showSendingAnimation(context);
      final String transactionChainSeed =
          await StateContainer.of(context).getSeed();
      List<UCOTransfer> _ucoTransferList = widget.ucoTransferList!;
      for (int i = 0; i < _ucoTransferList.length; i++) {
        if (_ucoTransferList[i].to!.startsWith('@')) {
          for (int j = 0; j < widget.contactsRef!.length; j++) {
            if (_ucoTransferList[i].to == widget.contactsRef![j].name) {
              _ucoTransferList[i].to = widget.contactsRef![j].address;
            }
          }
        }
      }
      final TransactionStatus transactionStatus = await sl
          .get<AppService>()
          .sendUCO(
              globalVarOriginPrivateKey,
              transactionChainSeed,
              StateContainer.of(context).selectedAccount.lastAddress!,
              _ucoTransferList);
      EventTaxiImpl.singleton()
          .fire(TransactionSendEvent(response: transactionStatus.status));
    } catch (e) {
      EventTaxiImpl.singleton()
          .fire(TransactionSendEvent(response: e.toString()));
    }
  }

  Future<void> authenticateWithPin() async {
    // PIN Authentication
    final Vault _vault = await Vault.getInstance();
    final String? expectedPin = _vault.getPin();
    final bool auth = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return PinScreen(
        PinOverlayType.enterPin,
        expectedPin: expectedPin!,
        description: '',
      );
    })) as bool;
    if (auth) {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      EventTaxiImpl.singleton().fire(AuthenticatedEvent(AUTH_EVENT_TYPE.send));
    }
  }

  Future<void> authenticateWithYubikey() async {
    // Yubikey Authentication
    final bool auth = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return const YubikeyScreen();
    })) as bool;
    if (auth) {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      EventTaxiImpl.singleton().fire(AuthenticatedEvent(AUTH_EVENT_TYPE.send));
    }
  }

  Future<void> confirmationWithLedger() async {
    // Ledger confirmation
    final bool auth = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return LedgerScreen(widget.ucoTransferList);
    })) as bool;
    if (auth) {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      EventTaxiImpl.singleton().fire(AuthenticatedEvent(AUTH_EVENT_TYPE.send));
    }
  }
}
