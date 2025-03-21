import 'package:multibusiness_business_app_flutter/Appointment/Model/home_all_appointments_response.dart';
import 'package:multibusiness_business_app_flutter/Clients/Provider/clients_provider.dart';
import 'package:multibusiness_business_app_flutter/Clients/add_client_screen.dart';
import 'package:multibusiness_business_app_flutter/Clients/client_profile_screen.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  late ClientsProvider clientsProvider;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    clientsProvider = Provider.of<ClientsProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      clientsProvider.callGetClients();
    });
  }

  @override
  Widget build(BuildContext context) {
    clientsProvider = Provider.of<ClientsProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: clientsProvider.clientsLoader,
      progressIndicator: SpinKitThreeBounce(
        color: AppColors.primarySwatch,
        size: 50.0,
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Text(
            getTranslated(context, LangConst.clientLabel).toString(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            Amount.screenMargin,
          ),
          child: Column(
            children: [
              TextFormField(
                cursorColor: AppColors.primarySwatch,
                controller: searchController,
                onChanged: (value) {
                  clientsProvider.filterClients(value);
                  setState(() {});
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.icon,
                  ),
                  labelText: getTranslated(context, LangConst.searchLabel).toString(),
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Expanded(
                child: clientsProvider.clientsLoader == false && clientsProvider.filteredClients.isEmpty
                    ? Center(
                        child: Text(getTranslated(context, LangConst.noDataFound).toString()),
                      )
                    : ListView.separated(
                        itemCount: clientsProvider.filteredClients.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                          top: Amount.screenMargin,
                        ),
                        separatorBuilder: (context, index) => Divider(
                          endIndent: 0,
                          indent: 0,
                        ),
                        itemBuilder: (context, index) {
                          UserDetails user = clientsProvider.filteredClients[index];
                          return ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ClientProfileScreen(
                                    id: user.id!.toInt(),
                                  ),
                                ),
                              );
                            },
                            contentPadding: EdgeInsets.zero,
                            leading: ExtendedImage.network(
                              user.imagePath! + user.image!,
                              fit: BoxFit.cover,
                              height: 45,
                              width: 45,
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
                                      user.imagePath! + user.image!,
                                      height: 45,
                                      width: 45,
                                      fit: BoxFit.cover,
                                      shape: BoxShape.circle,
                                    );
                                  case LoadState.failed:
                                    return CircleAvatar(
                                      radius: 22,
                                      backgroundImage: AssetImage("assets/app/profile.png"),
                                    );
                                }
                              },
                            ),
                            title: Text(
                              "${user.name}",
                                style: Theme.of(context).brightness == Brightness.light
                                    ? TypographyMedium.textThemeLight.titleMedium
                                    : TypographyMedium.textThemeDark.titleMedium
                            ),
                            subtitle: Text(
                              "${user.email}",
                              style: TypographyRegular.textThemeLight.titleMedium!.copyWith(
                                color: AppColors.gray50,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.gray50,
                              size: 18,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddClientScreen(),
              ),
            );
          },
          child: Icon(
            Icons.person_add_alt,
          ),
          tooltip: getTranslated(context, LangConst.addClient).toString(),
        ),
      ),
    );
  }
}
