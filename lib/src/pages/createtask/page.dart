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

class PageCreateTask extends StatefulWidget {
  const PageCreateTask({
    Key? key,
  }) : super(key: key);

  @override
  _StateCreateTask createState() => _StateCreateTask();
}

class _StateCreateTask extends AuthState<PageCreateTask>
    with SingleTickerProviderStateMixin {
  String taskName = '0';

  var datasets = <String, dynamic>{};
  int index = 0;

  @override
  void initState() {
    super.initState();

    TetaCMS.instance.analytics.insertEvent(
      TetaAnalyticsType.usage,
      'App usage: view page',
      <String, dynamic>{
        'name': "CreateTask",
      },
      isUserIdPreferableIfExists: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Container(
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.only(
            left: 24,
          ),
          width: double.maxFinite,
          height: 100,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF).withOpacity(1),
            border: Border(
              left: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                  color: Color(0xFF000000).withOpacity(1)),
              top: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                  color: Color(0xFF000000).withOpacity(1)),
              right: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                  color: Color(0xFF000000).withOpacity(1)),
              bottom: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                  color: Color(0xFF000000).withOpacity(1)),
            ),
          ),
          child: SafeArea(
            left: false,
            top: true,
            right: false,
            bottom: false,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context, rootNavigator: true).pop(null);
                  },
                  onDoubleTap: () async {},
                  onLongPress: () async {},
                  child: Icon(
                    MdiIcons.fromString('arrow-left'),
                    size: 32,
                    color: Color(0xFF000000).withOpacity(1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFF000000),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF).withOpacity(1),
              border: Border(
                left: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                    color: Color(0xFF000000).withOpacity(1)),
                top: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                    color: Color(0xFF000000).withOpacity(1)),
                right: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                    color: Color(0xFF000000).withOpacity(1)),
                bottom: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                    color: Color(0xFF000000).withOpacity(1)),
              ),
            ),
            child: TetaFutureBuilder(
                future: TetaCMS.instance.auth.user.get,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final user = snapshot.data as Map<String, dynamic>?;
                  final data = <String, dynamic>{
                    'isLogged': user?.keys.isNotEmpty,
                    'uid': user?['uid'],
                    'name': user?['name'],
                    'email': user?['email'],
                    'locale': user?['locale'],
                    'provider': user?['provider'],
                  };
                  datasets['Teta Auth User'] = [
                    if (data != null) data,
                  ];
                  var index = 0;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        r'''Insert a name for your task''',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Color(0xFF000000).withOpacity(1),
                            fontWeight: FontWeight.w300,
                            fontSize: 24,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        textAlign: TextAlign.left,
                        textDirection: TextDirection.ltr,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16,
                          bottom: 8,
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 24,
                            top: 8,
                            right: 24,
                            bottom: 8,
                          ),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                          child: TextField(
                            onChanged: (String value) async {
                              setState(() {
                                taskName = value;
                              });
                            },
                            onSubmitted: (String value) async {},
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFFFFFFF).withOpacity(1),
                              counterStyle: TextStyle(
                                color: Color(0xFFFFFFFF).withOpacity(1),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                              ),
                              hintText: r'''''',
                              contentPadding: const EdgeInsets.only(
                                left: 16,
                              ),
                            ),
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Color(0xFF000000).withOpacity(1),
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            textAlign: TextAlign.left,
                            textDirection: TextDirection.ltr,
                            maxLines: 1,
                            minLines: 1,
                            maxLength: null,
                            obscureText: false,
                            showCursor: true,
                            autocorrect: false,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 24,
                          right: 24,
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            await TetaCMS.instance.client.insertDocument(
                                '62aff225115478c782ccfd2e', <String, dynamic>{
                              'name': '''${taskName}''',
                              'email':
                                  '''${this.datasets['Teta Auth User']?[0]?['email']?.toString() ?? ''}''',
                            });
                            Navigator.of(context, rootNavigator: true)
                                .pop(null);
                          },
                          onLongPress: () async {},
                          child: Container(
                              width: double.maxFinite,
                              height: 56,
                              decoration: BoxDecoration(
                                color: Color(0xFF30A283).withOpacity(1),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                                border: null,
                              ),
                              child: Center(
                                child: Text(
                                  '''Add Task''',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: Color(0xFFFFFFFF).withOpacity(1),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.ltr,
                                ),
                              )),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
