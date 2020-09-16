import 'package:cielo_payment_link/payment_link.dart';
import 'package:example_cielo_payment_link/pages/product_type_page.dart';
import 'package:example_cielo_payment_link/utils/share_url.dart';
import 'package:example_cielo_payment_link/widget/button_confirm_custom.dart';
import 'package:flutter/material.dart';

class ResponsePage extends StatelessWidget {
  final PaymentLinkResponse response;

  ResponsePage(this.response);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compartilhe seu Link'),
      ),
      body: DefaultTextStyle(
        style: Theme.of(context).textTheme.body2,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Container(
                  padding: EdgeInsets.all(6),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(response.shortUrl),
                        ButtonConfirmCustom(
                          text: 'Compartilhar',
                          onPressed: () async =>
                              await shareText(response.shortUrl),
                        ),
                        ButtonConfirmCustom(
                          text: 'Tela Inicial',
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => ProductTypePage()),
                                (Route<dynamic> route) => false);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
