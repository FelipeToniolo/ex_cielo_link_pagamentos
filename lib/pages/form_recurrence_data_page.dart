import 'package:cielo_payment_link/payment_link.dart';
import 'package:example_cielo_payment_link/pages/form_delivery_type_product_page.dart';
import 'package:example_cielo_payment_link/widget/button_confirm_custom.dart';
import 'package:example_cielo_payment_link/widget/text_form_field_custom.dart';
import 'package:flutter/material.dart';

class FormRecurrenceDataPage extends StatefulWidget {
  final PaymentLinkRequest request;

  FormRecurrenceDataPage({Key key, this.request}) : super(key: key);

  @override
  _FormRecurrenceDataPageState createState() => _FormRecurrenceDataPageState();
}

class _FormRecurrenceDataPageState extends State<FormRecurrenceDataPage> {
  List<DropdownMenuItem<RecurrentInterval>> _dropDownMenuItems;
  RecurrentInterval _recurrentIntervalSelect;
  final _controllerEndDate = TextEditingController(text: '2023-01-01');

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _recurrentIntervalSelect = _dropDownMenuItems[0].value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dados de Recorrencia'),
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
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: DropdownButton(
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            value: _recurrentIntervalSelect,
                            items: _dropDownMenuItems,
                            onChanged: _changedDropDownItems,
                          ),
                        ),
                        TextFormFieldCustom(
                            controller: _controllerEndDate,
                            labelText: 'Nome da Entrega'),
                        ButtonConfirmCustom(
                          onPressed: () {
                            widget.request.recurrent = Recurrent(
                                interval: _recurrentIntervalSelect,
                                endDate: _controllerEndDate.text);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FormDeliveryTypeProductPage(
                                        request: widget.request),
                              ),
                            );
                          },
                        ),
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

  List<DropdownMenuItem<RecurrentInterval>> getDropDownMenuItems() {
    List<DropdownMenuItem<RecurrentInterval>> items = List();
    items.add(
      DropdownMenuItem(
        value: RecurrentInterval.MONTHLY,
        child: Text('MENSAL'),
      ),
    );
    items.add(
      DropdownMenuItem(
        value: RecurrentInterval.BIMONTHLY,
        child: Text('BIMESTRAL'),
      ),
    );
    items.add(
      DropdownMenuItem(
        value: RecurrentInterval.QUARTERLY,
        child: Text('TRIMESTRAL'),
      ),
    );
    items.add(
      DropdownMenuItem(
        value: RecurrentInterval.SEMIANNUAL,
        child: Text('SEMESTRAL'),
      ),
    );
    items.add(
      DropdownMenuItem(
        value: RecurrentInterval.ANNUAL,
        child: Text('ANUAL'),
      ),
    );

    return items;
  }

  _changedDropDownItems(RecurrentInterval selectedItem) {
    setState(() {
      _recurrentIntervalSelect = selectedItem;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
