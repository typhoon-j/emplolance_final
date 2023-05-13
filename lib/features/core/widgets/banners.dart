import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/image_strings.dart';
import '../../../constants/sizes.dart';
import '../../../constants/text_strings.dart';

class DashboardBanners extends StatelessWidget {
  const DashboardBanners({
    Key? key,
    required this.txtTheme,
  }) : super(key: key);

  final TextTheme txtTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: tCardBgColor),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Flexible(child: Image(image: AssetImage(tBannerImage1))),
                    Flexible(child: Image(image: AssetImage(tBannerImage2))),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  tDashboardBannerTitle1,
                  style: txtTheme.headline4?.apply(color: Colors.black),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  tDashboardBannerSubtitle,
                  style: txtTheme.bodyText2?.apply(color: Colors.black),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: tDashboardCardPadding,
        ),
        // 2do Banner
        Expanded(
          child: Column(
            children: [
              //CARD
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: tCardBgColor,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Flexible(
                            child: Image(image: AssetImage(tBannerImage1))),
                        Flexible(
                            child: Image(image: AssetImage(tBannerImage2))),
                      ],
                    ),
                    Text(
                      tDashboardBannerTitle1,
                      style: txtTheme.headline4?.apply(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      tDashboardBannerSubtitle,
                      style: txtTheme.bodyText2?.apply(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () {}, child: const Text(tDashboardButton)),
              )
            ],
          ),
        ),
      ],
    );
  }
}
