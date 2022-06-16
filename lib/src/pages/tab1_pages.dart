import 'package:flutter/material.dart';
import 'package:flutter_miniaplicacion_noticias/src/widgets/lista_noticias.dart';
import 'package:flutter_miniaplicacion_noticias/src/services/news_service.dart';
import 'package:provider/provider.dart';


class Tab1Page extends StatefulWidget {
  const Tab1Page({Key? key}) : super(key: key);


  @override
  // ignore: library_private_types_in_public_api
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {

    final headlines = Provider.of<NewsService>(context).headlines;

    return Scaffold(
      body: ( headlines.length == 0 )
          ? const Center(child: CircularProgressIndicator() )
          : ListaNoticias( headlines )
   );
  }

  @override
  bool get wantKeepAlive => true;
}