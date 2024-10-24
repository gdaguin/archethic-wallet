/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class BuySheet extends ConsumerWidget implements SheetSkeletonInterface {
  const BuySheet({super.key});

  static const String routerPage = '/buy';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    return const SizedBox.shrink();
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    return SheetAppBar(
      title: AppLocalizations.of(context)!.transactionBuyHeader,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.go(HomePage.routerPage);
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Centralized Exchanges'.toUpperCase(),
                      style: ArchethicThemeStyles.textStyleSize14W200Primary,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      r'Buy with Fiats (€ or $):',
                      style: ArchethicThemeStyles.textStyleSize14W600Primary,
                    ),
                    const SizedBox(height: 16),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final maxWidth = constraints.maxWidth;
                        final itemWidth = (maxWidth - 16) / 2;
                        return Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 16,
                          runSpacing: 16,
                          children: [
                            SizedBox(
                              width: itemWidth,
                              child: _ExchangeButton(
                                image: SvgPicture.asset(
                                  'assets/exchanges/probit.svg',
                                  colorFilter: const ColorFilter.mode(
                                    Color(0xFF4231C8),
                                    BlendMode.srcIn,
                                  ),
                                  height: 70,
                                ),
                                text: 'ProBit Exchange',
                                url:
                                    'https://www.probit.com/app/exchange/UCO-USDT',
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Decentralized exchanges'.toUpperCase(),
                      style: ArchethicThemeStyles.textStyleSize14W200Primary,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Buy with other Cryptos:',
                      style: ArchethicThemeStyles.textStyleSize14W600Primary,
                    ),
                    const SizedBox(height: 16),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final maxWidth = constraints.maxWidth;
                        final itemWidth = (maxWidth - 20) / 2;
                        return Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 16,
                          runSpacing: 16,
                          children: [
                            SizedBox(
                              width: itemWidth,
                              child: _ExchangeButton(
                                image: Image.asset(
                                  'assets/exchanges/archethic.png',
                                  height: 70,
                                ),
                                text: 'Archethic Chain',
                                url: 'https://swap.archethic.net/swap',
                              ),
                            ),
                            SizedBox(
                              width: itemWidth,
                              child: _ExchangeButton(
                                image: Image.asset(
                                  'assets/exchanges/polygon.png',
                                  height: 70,
                                ),
                                text: 'Polygon Chain',
                                url:
                                    'https://swap.defillama.com/?chain=polygon&from=0x2791bca1f2de4661ed88a30c99a7a9449aa84174&tab=swap&to=0x3c720206bfacb2d16fa3ac0ed87d2048dbc401fc',
                              ),
                            ),
                            SizedBox(
                              width: itemWidth,
                              child: _ExchangeButton(
                                image: Image.asset(
                                  'assets/exchanges/ethereum.png',
                                  height: 70,
                                ),
                                text: 'Ethereum Chain',
                                url:
                                    'https://swap.defillama.com/?chain=ethereum&from=0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48&tab=swap&to=0x8a3d77e9d6968b780564936d15b09805827c21fa',
                              ),
                            ),
                            SizedBox(
                              width: itemWidth,
                              child: _ExchangeButton(
                                image: Image.asset(
                                  'assets/exchanges/bsc.png',
                                  height: 70,
                                ),
                                text: 'Binance Chain',
                                url:
                                    'https://swap.defillama.com/?chain=bsc&from=0x55d398326f99059ff775485246999027b3197955&tab=swap&to=0xb001f1e7c8bda414ac7cf7ecba5469fe8d24b6de',
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExchangeButton extends StatelessWidget {
  const _ExchangeButton({
    required this.image,
    required this.text,
    required this.url,
  });
  final Widget image;
  final String text;
  final String url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse(url));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ArchethicTheme.backgroundRecentTxListCardTransferOutput,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: ArchethicTheme.backgroundRecentTxListCardTokenCreation
                    .withOpacity(0.3),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                image,
                const SizedBox(height: 8),
                AutoSizeText(
                  text,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: ArchethicThemeStyles.textStyleSize14W200Primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
