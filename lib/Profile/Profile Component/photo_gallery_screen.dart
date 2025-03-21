import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/gallery_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Profile%20Component/image_full_screen.dart';
import 'package:multibusiness_business_app_flutter/Profile/Provider/gallery_provider.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/Widgets/app_bar_back_icon.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class PhotoGalleryScreen extends StatefulWidget {
  const PhotoGalleryScreen({super.key});

  @override
  State<PhotoGalleryScreen> createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  late GalleryProvider galleryProvider;

  @override
  void initState() {
    super.initState();
    galleryProvider = Provider.of<GalleryProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      galleryProvider.callGallery();
    });
  }

  @override
  Widget build(BuildContext context) {
    galleryProvider = Provider.of<GalleryProvider>(
      context,
    );
    return ModalProgressHUD(
      inAsyncCall: galleryProvider.galleryLoader,
      progressIndicator: SpinKitThreeBounce(
        color: AppColors.primarySwatch,
        size: 50.0,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: AppBarBack(),
          title: Text(
            getTranslated(context, LangConst.photoGalleryLabel).toString(),
          ),
          actions: [
            InkWell(
              onTap: () {
                galleryProvider.chooseProfileImage(context);
              },
              child: Container(
                margin: EdgeInsets.only(
                  left: 5,
                  top: 8,
                  bottom: 8,
                  right: 16,
                ),
                padding: EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                  left: 11,
                  right: 11,
                ),
                decoration: BoxDecoration(
                  borderRadius: AppBorderRadius.k10,
                  color: AppColors.primarySwatch,
                ),
                child: Icon(
                  Icons.add,
                  size: 20,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
        body: galleryProvider.galleryList.isEmpty && galleryProvider.galleryLoader == false
            ? Center(
                child: Text(
                getTranslated(context, LangConst.noDataFound).toString(),
              ))
            : GridView.builder(
                itemCount: galleryProvider.galleryList.length,
                padding: EdgeInsets.all(
                  Amount.screenMargin,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  GalleryData data = galleryProvider.galleryList[index];
                  return Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ImageFullScreen(
                                    imageUrl: data.imagePath! + data.image!,
                                  )));
                        },
                        child: ExtendedImage.network(
                          data.imagePath! + data.image!,
                          fit: BoxFit.cover,
                          borderRadius: AppBorderRadius.k16,
                          shape: BoxShape.rectangle,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          loadStateChanged: (ExtendedImageState state) {
                            switch (state.extendedImageLoadState) {
                              case LoadState.loading:
                                return SpinKitThreeBounce(
                                  color: AppColors.primarySwatch,
                                  size: 20.0,
                                );
                              case LoadState.completed:
                                return ExtendedImage.network(
                                  data.imagePath! + data.image!,
                                  fit: BoxFit.cover,
                                  borderRadius: AppBorderRadius.k16,
                                  shape: BoxShape.rectangle,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                );
                              case LoadState.failed:
                                return ClipRRect(
                                  borderRadius: AppBorderRadius.k16,
                                  child: Image.network(
                                    "https://picsum.photos/200/300",
                                    fit: BoxFit.cover,
                                  ),
                                );
                            }
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          onPressed: () {
                            showDeleteDialog(context, index, data.galleryId!.toInt());
                          },
                          icon: CircleAvatar(
                            backgroundColor: AppColors.danger50,
                            child: Icon(
                              CupertinoIcons.delete_simple,
                              color: AppColors.danger600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }

  showDeleteDialog(BuildContext context, int index, int id) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              getTranslated(context, LangConst.deleteQuestion).toString(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            actionsPadding: EdgeInsets.only(
              bottom: 16,
              right: 16,
              left: 16,
            ),
            content: Text(
              getTranslated(context, LangConst.areYouSureToDeleteThis).toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            actionsAlignment: MainAxisAlignment.end,
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  getTranslated(context, LangConst.cancelLabel).toString(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.background,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  galleryProvider.callDeleteGallery(id, index);
                },
                child: Text(
                  getTranslated(context, LangConst.deleteLabel).toString(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.white,
                      ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.danger500,
                ),
              ),
            ],
          );
        });
  }
}
