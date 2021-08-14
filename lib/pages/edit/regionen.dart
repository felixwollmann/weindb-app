import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:weindb/classes/classes.dart';
import 'package:weindb/theme/components/AllComponents.dart';

String _errorFieldEmpty = 'Das Feld darf nicht leer sein';

class RegionenForm extends StatefulWidget {
  final Region? startingValue;

  RegionenForm({this.startingValue, Key? key}) : super(key: key);

  @override
  _RegionenFormState createState() => _RegionenFormState();
}

class _RegionenFormState extends State<RegionenForm> {
  final nameController = TextEditingController();
  final landController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = this.widget.startingValue?.name ?? '';
    landController.text = this.widget.startingValue?.land ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Region ${this.widget.startingValue != null ? 'bearbeiten' : 'erstellen'}'),
        actions: [
          IconButton(
            onPressed: () {
              save(context, _formKey);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 10),
              TextFormField(
                controller: nameController,
                validator: (val) =>
                    val != null && val.length >= 1 ? null : _errorFieldEmpty,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(RegionenPage.icon),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: landController,
                validator: (val) => val != null && val.length == 2
                    ? null
                    : (val == null
                        ? _errorFieldEmpty
                        : 'Das Land muss ein Landescode mit 2 Buchstaben sein, z.B. AT für Österreich'),
                decoration: InputDecoration(
                  labelText: 'Land',
                  prefixIcon: Icon(Icons.flag),
                ),
              ),

              SizedBox(height: 10),

              // Add TextFormFields and ElevatedButton here.
            ],
          ),
        ),
      ),
    );
  }

  /// Sammelt alle Daten ein, erstellt daraus einen Wein, popt diesen Bildschirm vom Navigator
  /// und übergibt dabei den erstellten Wein
  void save(BuildContext context, GlobalKey<FormState> formKey) {
    // bool textFieldsValid = formKey.currentState!.validate();

    // bool textFieldValidation = formKey.currentState!.validate();

    if (!formKey.currentState!.validate() ) return;

    Region newRegion = Region(
      Provider.of<Regionen>(context, listen: false),
      id: this.widget.startingValue?.id ?? 0,
      name: nameController.text,
      land: landController.text,
    );

    Navigator.pop(context, newRegion);
  }
}
