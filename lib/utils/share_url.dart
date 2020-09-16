import 'package:esys_flutter_share/esys_flutter_share.dart';

Future<void> shareText(String shortUrl) async {
  try {
    Share.text('Compartilhe seu Link', "Clicou, pagou e pronto! \n\n $shortUrl",
        'text/plain');
  } catch (e) {
    print('error: $e');
  }
}
