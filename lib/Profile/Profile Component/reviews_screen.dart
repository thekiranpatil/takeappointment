import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/reviews_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Provider/review_provider.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/Widgets/app_bar_back_icon.dart';
import 'package:multibusiness_business_app_flutter/Widgets/constant_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ReviewSScreen extends StatefulWidget {
  const ReviewSScreen({super.key});

  @override
  State<ReviewSScreen> createState() => _ReviewSScreenState();
}

class _ReviewSScreenState extends State<ReviewSScreen> {
  bool isToggle = true;
  late ReviewProvider reviewProvider;

  @override
  void initState() {
    super.initState();
    reviewProvider = Provider.of<ReviewProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      reviewProvider.callGetReview();
    });
  }

  @override
  Widget build(BuildContext context) {
    reviewProvider = Provider.of<ReviewProvider>(
      context,
    );
    return ModalProgressHUD(
      inAsyncCall: reviewProvider.reviewLoader,
      progressIndicator: SpinKitThreeBounce(
        color: AppColors.primarySwatch,
        size: 50.0,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: AppBarBack(),
          title: Text(
            getTranslated(context, LangConst.reviewsLabel).toString(),
          ),
        ),
        body: reviewProvider.reviewLoader == false && reviewProvider.reviews.isEmpty
            ? Center(
                child: Text(
                  getTranslated(context, LangConst.noDataFound).toString(),
                ),
              )
            : ListView.separated(
                itemCount: reviewProvider.reviews.length,
                shrinkWrap: true,
                padding: EdgeInsets.all(
                  Amount.screenMargin,
                ),
                separatorBuilder: (context, index) => Column(
                  children: [
                    HeightBox(4),
                    Divider(
                      indent: 0,
                      endIndent: 0,
                    ),
                    HeightBox(4),
                  ],
                ),
                itemBuilder: (context, index) {
                  ReviewData review = reviewProvider.reviews[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ExtendedImage.network(
                            review.user!.imagePath! + review.user!.image!,
                            fit: BoxFit.cover,
                            height: 48,
                            width: 48,
                            shape: BoxShape.circle,
                            loadStateChanged: (ExtendedImageState state) {
                              switch (state.extendedImageLoadState) {
                                case LoadState.loading:
                                  return SpinKitThreeBounce(
                                    color: AppColors.primarySwatch,
                                    size: 20.0,
                                  );
                                case LoadState.completed:
                                  return ExtendedImage.network(
                                    review.user!.imagePath! + review.user!.image!,
                                    height: 48,
                                    width: 48,
                                    fit: BoxFit.cover,
                                    shape: BoxShape.circle,
                                  );
                                case LoadState.failed:
                                  return CircleAvatar(
                                    radius: 24,
                                    backgroundImage: AssetImage("assets/app/profile.png"),
                                  );
                              }
                            },
                          ),
                          WidthBox(12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${review.user!.name}",
                                  style: TypographyMedium.textThemeLight.titleMedium,
                                ),
                                RatingBarIndicator(
                                  rating: review.rate!.toDouble(),
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star_rounded,
                                    color: AppColors.warning500,
                                  ),
                                  itemCount: 5,
                                  itemSize: 20.0,
                                  unratedColor: AppColors.neutral700,
                                  direction: Axis.horizontal,
                                ),
                              ],
                            ),
                          ),
                          WidthBox(12),
                          Switch(
                              value: review.report == 1 ? true : false,
                              inactiveTrackColor: AppColors.gray50,
                              onChanged: (value) {
                                Map<String, dynamic> body = {
                                  "review_id": review.reviewId,
                                };
                                reviewProvider.callReviewReport(body, index);
                              }),
                        ],
                      ),
                      HeightBox(4),
                      Text(
                        "${review.message}",
                        style: TypographyRegular.textThemeLight.titleMedium,
                        maxLines: 3,
                      ),
                      HeightBox(8),
                      Text(
                        "${review.display}",
                        style: TypographyRegular.textThemeLight.titleSmall!.copyWith(
                          color: AppColors.gray50,
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
