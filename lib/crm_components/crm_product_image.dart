import 'package:crm_mobile/constants/image_strings.dart';
import 'package:crm_mobile/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

class CrmProductImage extends StatelessWidget {
  final String image;

  CrmProductImage({this.image});

  @override
  Widget build(BuildContext context) {
    GlobalConfiguration cfg = GlobalConfiguration();
    final String crmUrlCatalog = cfg.get("URL_CATALOG");
    return FadeInImage(
      image: NetworkImage(
        crmUrlCatalog + '$image.png',
      ),
      placeholder: const AssetImage(
        tCrmNoProduct,
      ),
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset(
          tCrmNoProduct,
          height: tCircleAvatarSize,
        );
      },
      fit: BoxFit.fitWidth,
      height: tCircleAvatarSize,
    );
  }
}
