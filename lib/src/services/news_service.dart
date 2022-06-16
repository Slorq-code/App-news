import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_miniaplicacion_noticias/src/models/news_models.dart';
import 'package:flutter_miniaplicacion_noticias/src/models/category_model.dart';
import 'package:http/http.dart' as http;


// ignore: constant_identifier_names
const _URL_NEWS = "https://newsapi.org/v2/";
// ignore: constant_identifier_names
const _APIKEY = "b97161d335624af2b030437605539ed9";

class NewsService with ChangeNotifier {

  List<Article> headlines = [];
  String _selectedCategory = "business";

  bool _isLoading = true;

  List<Category> categories = [
    Category( FontAwesomeIcons.building, 'business'  ),
    Category( FontAwesomeIcons.tv, 'entertainment'  ),
    Category( FontAwesomeIcons.addressCard, 'general'  ),
    Category( FontAwesomeIcons.headSideVirus, 'health'  ),
    Category( FontAwesomeIcons.vials, 'science'  ),
    Category( Icons.sports_baseball, 'sports'  ),
    Category( FontAwesomeIcons.memory, 'technology'  ),
  ];

  Map<String, List<Article>> categoryArticles = {};


      
NewsService() {
    getTopHeadlines();

    for (var item in categories) {
      categoryArticles[item.name] =  [];
    }

    getArticlesByCategory( _selectedCategory );
  }

  bool get isLoading => _isLoading;


  get selectedCategory => _selectedCategory;
  set selectedCategory( valor ) {
    _selectedCategory = valor;

    _isLoading = true;
    getArticlesByCategory( valor );
    notifyListeners();
  }
  
  List<Article>? get getArticulosCategoriaSeleccionada => categoryArticles[selectedCategory];



  getTopHeadlines() async {
    
      const url ='$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us';
      final resp = await http.get(Uri.parse(url));

      final newsResponse = newsResponseFromJson( resp.body );

      headlines.addAll( newsResponse.articles );
      notifyListeners();
  }

  getArticlesByCategory( String category ) async {
       
      // ignore: non_constant_identifier_names
      final size = categoryArticles[category]?.length; 
      if ( size! > 0 ) {
        _isLoading = false;
        notifyListeners();
        return categoryArticles[category];
      }

      final url ='$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ca&category=$category';
      final resp = await http.get(Uri.parse(url));

      final newsResponse = newsResponseFromJson( resp.body );

      categoryArticles[category]?.addAll( newsResponse.articles );

      _isLoading = false;
      notifyListeners();

  }


}