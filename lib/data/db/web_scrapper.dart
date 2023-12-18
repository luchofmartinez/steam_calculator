import 'package:web_scraper/web_scraper.dart';

class DollarCardAPI {
  Future<String> fetchValueDollar() async {
    List<Map<String, dynamic>>? dollarValues = [];
    final webScraper = WebScraper('https://www.lanacion.com.ar');

    if (await webScraper.loadWebPage('/dolar-hoy')) {
      webScraper
          .loadFromString(webScraper.getPageContent().replaceAll('<br>', '\n')); 
      dollarValues = webScraper
          .getElement("div.dolar ul.dolar-subgroup.--even li div.currency-data p strong.--fourxs", ['class']); 
      return dollarValues[1]['title'].toString().replaceAll('\$', '').replaceAll(',', '.');
    } else {
      return '0.0';
    }
  }
}
