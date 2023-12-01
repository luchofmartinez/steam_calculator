import 'package:web_scraper/web_scraper.dart';

class DollarCardAPI {
  Future<String> fetchValueDollar() async {
    List<Map<String, dynamic>>? dollarValues = [];
    final webScraper = WebScraper('https://www.cronista.com');

    if (await webScraper.loadWebPage('/MercadosOnline/moneda.html?id=ARS')) {
      webScraper
          .loadFromString(webScraper.getPageContent().replaceAll('<br>', '\n'));
      dollarValues = webScraper.getElement(
          "table#market-scrll-1 tbody tr td.sell a div.sell-wrapper div.sell-value",
          ['class']);
      return dollarValues[0]['title'].toString().replaceAll('\$', '').replaceAll(',', '.');
    } else {
      return '0.0';
    }
  }
}
