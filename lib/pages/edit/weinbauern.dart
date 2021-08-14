import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:weindb/classes/classes.dart';
import 'package:weindb/theme/components/AllComponents.dart';

String _errorFieldEmpty = 'Das Feld darf nicht leer sein';

class WeinbauernForm extends StatefulWidget {
  final Weinbauer? startingValue;

  WeinbauernForm({this.startingValue, Key? key}) : super(key: key);

  @override
  _WeinbauernFormState createState() => _WeinbauernFormState();
}

class _WeinbauernFormState extends State<WeinbauernForm> {
  Region? regionValue;

  final nameController = TextEditingController();
  final beschreibungController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = this.widget.startingValue?.name ?? '';
    beschreibungController.text = this.widget.startingValue?.beschreibung ?? '';
    regionValue = this.widget.startingValue?.region;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    Widget regionSelect = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.grey
              : Color(0xff6B6B6B),
        ),
      ),
      padding: EdgeInsets.all(6),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              RegionenPage.icon,
              color: Theme.of(context).brightness == Brightness.light
                  ? Color(0xff898989)
                  : Color(0xffC1C1C1),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 1),
            child: DropdownButton<Region>(
              hint: Text('Region auswählen'),
              value: regionValue,
              icon: Icon(
                Icons.arrow_drop_down,
              ),
              iconSize: 24,
              elevation: 16,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Color(0xff646464)),
              underline: SizedBox(),
              onChanged: (Region? newValue) {
                setState(() {
                  regionValue = newValue!;
                });
              },
              items: Provider.of<Regionen>(context)
                  .values
                  .toList()
                  .map<DropdownMenuItem<Region>>((Region value) {
                return DropdownMenuItem<Region>(
                  value: value,
                  child: Text(value.name,
                      style: TextStyle(color: Theme.of(context).hintColor)),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );

   

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Weinbauer ${this.widget.startingValue != null ? 'bearbeiten' : 'erstellen'}'),
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
                  prefixIcon: Icon(WeinbauernPage.icon),
                ),
              ),
              SizedBox(height: 10),

              regionSelect,
              SizedBox(height: 10),
              TextFormField(
                controller: beschreibungController,
                maxLines: 1000000,
                minLines: 2,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: 'Beschreibung',
                  prefixIcon: Icon(Icons.subject),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

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

    if (!formKey.currentState!.validate()) return;

    Weinbauer newWeinbauer = Weinbauer(
      Provider.of<Weinbauern>(context, listen: false),
      id: this.widget.startingValue?.id ?? 0,
      name: nameController.text,
      region: regionValue,
      beschreibung: beschreibungController.text == ''
          ? null
          : beschreibungController.text,
    );

    Navigator.pop(context, newWeinbauer);
  }
}
