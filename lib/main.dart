import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_miniaplicacion_noticias/src/pages/tabs_pages.dart';
import 'package:flutter_miniaplicacion_noticias/src/services/news_service.dart';
import 'package:flutter_miniaplicacion_noticias/src/theme/Theme.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(const MyApp());
 
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> NewsService() ),
      ],
      child: MaterialApp(
        title: 'Material App',
        theme: miTema,
        debugShowCheckedModeBanner: false,
        home: const TabsPage()
      ),
    );
  }
}