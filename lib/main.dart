  import 'dart:io';
  import 'package:flutter/services.dart';
  import 'package:flutter/material.dart';
  import 'package:splash_screen_view/SplashScreenView.dart';
  import 'package:sizer/sizer.dart';
  import 'package:supabase_flutter/supabase_flutter.dart';
  
  
  
  import 'package:myapp/src/pages/entrypoint/page.dart';
  import 'package:teta_cms/teta_cms.dart';

  ///NOTE:
  ///if you have an error while running <flutter run> 
  ///run <flutter pub upgrade> and than <flutter run --no-sound-null-safety>
  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    await TetaCMS.initialize(
      token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InN0aWxsbWFuZ282N0BnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwicHJvamVjdHMiOlsxNDE0NTMsMTM1ODY5LDEwNzE0Nl0sImltYWdlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUFUWEFKemU3QnYwSkx1akdvWnh0V3JLSWowWEx1c2VoME1LNy1PYVlTaXc9czk2LWMiLCJuYW1lIjoibWFuZ28ganVpY2UiLCJlbWl0dGVyIjoiVGV0YS1BdXRoIiwiaWF0IjoxNjU2ODM5MzQ1LCJleHAiOjQ4MTI1OTkzNDV9.E7YBZXJIqskA4Q0h-50qpaG_OeLG4FOHdVwRYIi3lYI',
      prjId: 135869,
    );
    
      Supabase.initialize(
    url: 'https://fgvduxlhegdcudajspzv.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZndmR1eGxoZWdkY3VkYWpzcHp2Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY1NjgzNDY0OSwiZXhwIjoxOTcyNDEwNjQ5fQ.AJojeWx0Lx2GH40YgO6Q3JQKMLgakn0ZKkgIszJ2YFg',
  );
  
    
    
    runApp(MyApp());
  }
  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Sizer(
        builder: (
          final context,
          final orientation,
          final deviceType,
        ) => MaterialApp(
          title: 'tru',
          home: SplashScreenView(
            navigateRoute: PageEntryPoint(),
            duration: 2200,
            imageSize: 80,
            imageSrc: 'assets/teta-app.png',
            text: '',
            textType: TextType.NormalText,
            textStyle: TextStyle(
              fontSize: 30.0,
            ),
            backgroundColor: Colors.black,
          ),
        ),
      );
    }
  }
  