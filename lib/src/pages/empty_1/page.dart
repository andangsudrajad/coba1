import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myapp/src/components/index.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myapp/auth/auth_state.dart';
import 'package:map/map.dart' as map;
import 'package:url_launcher/url_launcher_string.dart';
import 'package:auth_buttons/auth_buttons.dart';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:tcard/tcard.dart';
import 'package:collection/collection.dart';
import 'package:myapp/src/pages/index.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:latlng/latlng.dart';
import 'package:badges/badges.dart';
import 'package:paged_vertical_calendar/paged_vertical_calendar.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:teta_cms/teta_cms.dart';
import 'package:webviewx/webviewx.dart';

class PageEmptyA1 extends StatefulWidget {
  const PageEmptyA1({
    Key? key,
  }) : super(key: key);

  @override
  _StateEmptyA1 createState() => _StateEmptyA1();
}

class _StateEmptyA1 extends AuthState<PageEmptyA1>
    with SingleTickerProviderStateMixin {
  String state1 = '0';

  var datasets = <String, dynamic>{};
  int index = 0;

  @override
  void initState() {
    super.initState();

    TetaCMS.instance.analytics.insertEvent(
      TetaAnalyticsType.usage,
      'App usage: view page',
      <String, dynamic>{
        'name': "EmptyA1",
      },
      isUserIdPreferableIfExists: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF000000),
      body: Stack(
        children: [
          map.MapLayoutBuilder(
            controller: map.MapController(
              location: LatLng(41.52, 12.30),
              zoom: 4,
            ),
            builder: (context, transformer) {
              return Stack(
                children: [
                  map.Map(
                    controller: map.MapController(
                      location: LatLng(41.52, 12.30),
                      zoom: 4,
                    ),
                    builder: (context, x, y, z) {
                      final url =
                          'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/$z/$x/$y?access_token=pk.eyJ1Ijoia29sb25lbCIsImEiOiJjanNjMWc2enEwMGs5M3lwbmF2NXEwazV4In0.70IXd_Hc-X_o1jQt19J3lA';
                      final darkUrl =
                          'https://api.mapbox.com/styles/v1/mapbox/dark-v10/tiles/$z/$x/$y?access_token=pk.eyJ1Ijoia29sb25lbCIsImEiOiJjanNjMWc2enEwMGs5M3lwbmF2NXEwazV4In0.70IXd_Hc-X_o1jQt19J3lA';
                      return Image.network(
                        false ? darkUrl : url,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
