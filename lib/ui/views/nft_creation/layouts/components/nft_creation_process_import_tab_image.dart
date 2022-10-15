/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:io';

import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/model.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class NFTCreationProcessImportTabImage extends ConsumerWidget {
  const NFTCreationProcessImportTabImage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kIsWeb == true ||
        (Platform.isAndroid == false && Platform.isIOS == false)) {
      return const SizedBox();
    }

    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(preferenceProvider);
    final nftCreation = ref.watch(NftCreationProvider.nftCreation);
    final nftCreationNotifier =
        ref.watch(NftCreationProvider.nftCreation.notifier);
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: InkWell(
            onTap: () async {
              final pickedFile = await ImagePicker().pickImage(
                source: ImageSource.gallery,
                maxWidth: 1800,
                maxHeight: 1800,
              );
              if (pickedFile != null) {
                nftCreationNotifier.setFileProperties(
                  File(pickedFile.path),
                  FileImportTypeEnum.image,
                );
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 30,
                      child: FaIcon(
                        FontAwesomeIcons.photoFilm,
                        size: 18,
                        color: theme.text,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      localizations.nftAddImportPhoto,
                      style: theme.textStyleSize12W400Primary,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    if (nftCreation.fileImportType == FileImportTypeEnum.image)
                      const Icon(
                        Icons.check_circle,
                        size: 16,
                        color: Colors.green,
                      )
                  ],
                ),
                InkWell(
                  onTap: () {
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.light,
                          preferences.activeVibrations,
                        );
                    AppDialogs.showInfoDialog(
                      context,
                      ref,
                      localizations.informations,
                      localizations.nftAddPhotoFormatInfo,
                    );
                  },
                  child: SizedBox(
                    width: 30,
                    child: FaIcon(
                      FontAwesomeIcons.circleInfo,
                      size: 18,
                      color: theme.text,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 2,
          color: theme.text15,
        ),
      ],
    );
  }
}