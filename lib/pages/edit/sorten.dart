import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:weindb/classes/classes.dart';
import 'package:weindb/theme/components/AllComponents.dart';

String _errorFieldEmpty = 'Das Feld darf nicht leer sein';

class SortenForm extends StatefulWidget {
  final Sorte? startingValue;

  SortenForm({this.startingValue, Key? key}) : super(key: key);

  @override
  _SortenFormState createState() => _SortenFormState();
}

class _SortenFormState extends State<SortenForm> {
  final nameController = TextEditingController();

  int? farbenValue;

  @override
  void initState() {
    super.initState();
    nameController.text = this.widget.startingValue?.name ?? '';
    farbenValue = this.widget.startingValue?.farbe;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    Widget farbenSelect = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: farbenValue == null
              ? Theme.of(context).errorColor
              : (Theme.of(context).brightness == Brightness.light
                  ? Colors.grey
                  : Color(0xff6B6B6B)),
        ),
      ),
      padding: EdgeInsets.all(6),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.palette,
              color: Theme.of(context).brightness == Brightness.light
                  ? Color(0xff898989)
                  : Color(0xffC1C1C1),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 1),
            child: DropdownButton<int>(
              hint: Text('Farbe auswählen'),
              value: farbenValue,
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
              onChanged: (int? newValue) {
                setState(() {
                  farbenValue = newValue!;
                });
              },
              items: [0, 1, 2, 3].map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(Sorte.deutscherFarbenName(value),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground)),
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
            'Sorte ${this.widget.startingValue != null ? 'bearbeiten' : 'erstellen'}'),
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
                  prefixIcon: Icon(SortenPage.icon),
                ),
              ),
              SizedBox(height: 10),

              farbenSelect,
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

    if (!formKey.currentState!.validate() || farbenValue == null) return;


    Sorte newSorte = Sorte(
      Provider.of<Sorten>(context, listen: false),
      id: this.widget.startingValue?.id ?? 0,
      name: nameController.text,
      farbe: farbenValue!,
    );

    Navigator.pop(context, newSorte);
  }
}
