import 'package:extended_image/extended_image.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:flutter/material.dart';
import 'package:zoom_widget/zoom_widget.dart';

class ImageFullScreen extends StatefulWidget {
  final String imageUrl;

  const ImageFullScreen({super.key, required this.imageUrl});

  @override
  State<ImageFullScreen> createState() => _ImageFullScreenState();
}

class _ImageFullScreenState extends State<ImageFullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getTranslated(context, LangConst.imageLabel).toString(),
        ),
      ),
      body: Zoom(
        maxZoomHeight: MediaQuery.of(context).size.height,
        maxZoomWidth: MediaQuery.of(context).size.width,
        doubleTapZoom: true,
        opacityScrollBars: 00,
        backgroundColor: AppColors.white,
        child: ExtendedImage.network(
          widget.imageUrl,
          clipBehavior: Clip.hardEdge,
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          shape: BoxShape.rectangle,
          loadStateChanged: (ExtendedImageState state) {
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                return SizedBox(
                  height: 0,
                  width: 0,
                );
              case LoadState.completed:
                return ExtendedImage.network(
                  widget.imageUrl,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  clipBehavior: Clip.hardEdge,
                  fit: BoxFit.cover,
                  shape: BoxShape.rectangle,
                );
              case LoadState.failed:
                return Image.network(
                  "https://picsum.photos/200/300",
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                );
            }
          },
        ),
      ),
    );
  }
}
