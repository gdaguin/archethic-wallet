/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:filesize/filesize.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/token_property_with_access_infos.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/mime_util.dart';
import 'package:aewallet/util/nft_util.dart';

class NFTPreviewWidget extends StatelessWidget {
  const NFTPreviewWidget(
      {super.key,
      this.nftName,
      this.nftAddress,
      this.nftDescription,
      this.nftFile,
      this.nftTypeMime,
      this.tokenPropertyWithAccessInfos,
      this.nftSize = 0,
      this.context,
      this.nftPropertiesDeleteAction = true});

  final String? nftName;
  final String? nftAddress;
  final String? nftDescription;
  final Uint8List? nftFile;
  final String? nftTypeMime;
  final List<TokenPropertyWithAccessInfos>? tokenPropertyWithAccessInfos;
  final BuildContext? context;
  final int nftSize;
  final bool nftPropertiesDeleteAction;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: nftName!,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                nftName!,
                style: AppStyles.textStyleSize18W600Primary(context),
              ),
              const SizedBox(
                height: 10,
              ),
              if (MimeUtil.isImage(nftTypeMime) == true ||
                  MimeUtil.isPdf(nftTypeMime) == true)
                if (nftAddress != null)
                  FutureBuilder<Uint8List?>(
                      future: NFTUtil.getImageFromTokenAddress(nftAddress!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                              decoration: BoxDecoration(
                                color: StateContainer.of(context).curTheme.text,
                                border: Border.all(
                                  width: 1,
                                ),
                              ),
                              child: Image.memory(
                                snapshot.data!,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fitWidth,
                              ));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      })
                else
                  Container(
                    decoration: BoxDecoration(
                      color: StateContainer.of(context).curTheme.text,
                      border: Border.all(
                        width: 1,
                      ),
                    ),
                    child: Image.memory(
                      nftFile!,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
              if (nftSize > 0)
                Text(
                  '${AppLocalization.of(context)!.nftAddFileSize} ${filesize(nftSize)}',
                  style: AppStyles.textStyleSize12W400Primary(context),
                ),
              if (nftDescription != null) const SizedBox(height: 10),
              if (nftDescription != null)
                Text(
                  nftDescription!,
                  style: AppStyles.textStyleSize14W600Primary(context),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Wrap(
                    alignment: WrapAlignment.start,
                    children: tokenPropertyWithAccessInfos!.asMap().entries.map(
                        (MapEntry<dynamic, TokenPropertyWithAccessInfos>
                            entry) {
                      return entry.value.tokenProperty!.name != 'file' &&
                              entry.value.tokenProperty!.name !=
                                  'description' &&
                              entry.value.tokenProperty!.name != 'name' &&
                              entry.value.tokenProperty!.name != 'type/mime'
                          ? Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: _buildTokenProperty(context, entry.value),
                            )
                          : const SizedBox();
                    }).toList()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTokenProperty(BuildContext context,
      TokenPropertyWithAccessInfos tokenPropertyWithAccessInfos) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () async {},
        onLongPress: () {},
        child: Card(
          shape: RoundedRectangleBorder(
            side: tokenPropertyWithAccessInfos.publicKeysList != null &&
                    tokenPropertyWithAccessInfos.publicKeysList!.isNotEmpty
                ? const BorderSide(color: Colors.redAccent, width: 2.0)
                : BorderSide(
                    color: StateContainer.of(context)
                        .curTheme
                        .backgroundAccountsListCardSelected!,
                    width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          color: StateContainer.of(context)
              .curTheme
              .backgroundAccountsListCardSelected,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: AutoSizeText(
                                tokenPropertyWithAccessInfos
                                    .tokenProperty!.name!,
                                style: AppStyles.textStyleSize12W600Primary(
                                    context),
                              ),
                            ),
                            Container(
                              width: 200,
                              padding: const EdgeInsets.only(left: 20),
                              child: AutoSizeText(
                                tokenPropertyWithAccessInfos
                                    .tokenProperty!.value!,
                                style: AppStyles.textStyleSize12W400Primary(
                                    context),
                              ),
                            ),
                            tokenPropertyWithAccessInfos.publicKeysList !=
                                        null &&
                                    tokenPropertyWithAccessInfos
                                        .publicKeysList!.isNotEmpty
                                ? tokenPropertyWithAccessInfos
                                            .publicKeysList!.length ==
                                        1
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                100,
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: AutoSizeText(
                                          'This property is protected and accessible by ${tokenPropertyWithAccessInfos.publicKeysList!.length} public key',
                                          style: AppStyles
                                              .textStyleSize12W400Primary(
                                                  context),
                                        ),
                                      )
                                    : Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                100,
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: AutoSizeText(
                                          'This property is protected and accessible by ${tokenPropertyWithAccessInfos.publicKeysList!.length} public keys',
                                          style: AppStyles
                                              .textStyleSize12W400Primary(
                                                  context),
                                        ),
                                      )
                                : Container(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    padding: const EdgeInsets.only(left: 20),
                                    child: AutoSizeText(
                                      'This property is accessible for everyone',
                                      style:
                                          AppStyles.textStyleSize12W400Primary(
                                              context),
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
