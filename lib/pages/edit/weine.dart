import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:weindb/classes/classes.dart';
import 'package:weindb/theme/components/AllComponents.dart';

String _errorFieldEmpty = 'Das Feld darf nicht leer sein';

class WeineForm extends StatefulWidget {
  final Wein? startingValue;

  WeineForm({this.startingValue, Key? key}) : super(key: key);

  @override
  _WeineFormState createState() => _WeineFormState();
}

class _WeineFormState extends State<WeineForm> {
  Weinbauer? weinbauerValue;
  Sorte? sorteValue;

  DateTime? selectedDate;

  final nameController = TextEditingController();
  final anzahlController = TextEditingController();
  final getrunkenController = TextEditingController();
  final fachController = TextEditingController();
  final jahrController = TextEditingController();
  final inhaltController = TextEditingController();
  final preisController = TextEditingController();
  final beschreibungController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = this.widget.startingValue?.name ?? '';
    anzahlController.text = this.widget.startingValue?.anzahl.toString() ?? '';
    getrunkenController.text =
        this.widget.startingValue?.getrunken.toString() ??
            (this.widget.startingValue == null ? "0" : '');
    fachController.text = this.widget.startingValue?.fach?.toString() ?? '';
    jahrController.text = this.widget.startingValue?.jahr?.toString() ?? '';
    inhaltController.text = this.widget.startingValue?.inhalt?.toString() ??
        (this.widget.startingValue == null ? "0,75" : '');
    preisController.text = this.widget.startingValue?.preis?.toString() ?? '';
    beschreibungController.text = this.widget.startingValue?.beschreibung ?? '';

    selectedDate = this.widget.startingValue?.gekauft ?? null;

    sorteValue = this.widget.startingValue?.sorte ?? null;
    weinbauerValue = this.widget.startingValue?.weinbauer ?? null;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final List<Sorte> sorten = Provider.of<Sorten>(context).values.toList()
      ..sort((sorte1, sorte2) => sorte1.name.compareTo(sorte2.name));
    final List<Weinbauer> weinbauern = Provider.of<Weinbauern>(context)
        .values
        .toList()
      ..sort((wb1, wb2) => wb1.name.compareTo(wb2.name));

    Widget weinbauerSelect = Container(
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
              WeinbauernPage.icon,
              color: Theme.of(context).brightness == Brightness.light
                  ? Color(0xff898989)
                  : Color(0xffC1C1C1),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 1),
            child: DropdownButton<Weinbauer>(
              hint: Text('Weinbauer auswählen'),
              value: weinbauerValue,
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
              onChanged: (Weinbauer? newValue) {
                setState(() {
                  weinbauerValue = newValue!;
                });
              },
              items: weinbauern
                  .map<DropdownMenuItem<Weinbauer>>((Weinbauer value) {
                return DropdownMenuItem<Weinbauer>(
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

    Widget sortenSelect = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: sorteValue == null
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
              SortenPage.icon,
              color: Theme.of(context).brightness == Brightness.light
                  ? Color(0xff898989)
                  : Color(0xffC1C1C1),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 1),
            child: DropdownButton<Sorte>(
              hint: Text('Sorte auswählen'),
              value: sorteValue,
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
              onChanged: (Sorte? newValue) {
                setState(() {
                  sorteValue = newValue!;
                });
              },
              items: sorten.map<DropdownMenuItem<Sorte>>((Sorte value) {
                return DropdownMenuItem<Sorte>(
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

    Widget dateSelect = InkWell(
      onTap: () {
        _showDatePicker(context);
      },
      child: Container(
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).brightness == Brightness.light
                    ? Color(0xff898989)
                    : Color(0xffC1C1C1),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 1),
              child: Text(
                selectedDate != null
                    ? ('${selectedDate!.day}.${selectedDate!.month}.${selectedDate!.year}')
                    : 'Datum auswählen',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Theme.of(context).hintColor),
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Wein ${this.widget.startingValue != null ? 'bearbeiten' : 'erstellen'}'),
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
                  prefixIcon: Icon(WeinePage.icon),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: anzahlController,
                keyboardType: TextInputType.number,
                validator: (val) {
                  bool isInt = int.tryParse(val ?? '') != null;
                  if (val == null || val == '') {
                    return _errorFieldEmpty;
                  } else if (!isInt) {
                    return 'Der Wert muss eine Zahl sein';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Vorhanden',
                  prefixIcon: Icon(Icons.tag),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: getrunkenController,
                keyboardType: TextInputType.number,
                validator: (val) {
                  bool isInt = int.tryParse(val ?? '') != null;
                  if (val == null || val == '') {
                    return _errorFieldEmpty;
                  } else if (!isInt) {
                    return 'Der Wert muss eine Zahl sein';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Getrunken',
                  prefixIcon: Icon(WeinePage.icon),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: fachController,
                keyboardType: TextInputType.number,
                validator: (val) {
                  bool isInt = int.tryParse(val ?? '') != null;
                  if (val == null || val == '') {
                    return null;
                  } else if (!isInt) {
                    return 'Der Wert muss eine Zahl sein';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Fach',
                  prefixIcon: Icon(Icons.place),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              weinbauerSelect,
              SizedBox(height: 10),
              sortenSelect,
              SizedBox(height: 10),
              TextFormField(
                controller: jahrController,
                keyboardType: TextInputType.number,
                validator: (val) {
                  bool isInt = int.tryParse(val ?? '') != null;
                  if (val == null || val == '') {
                    return null;
                  } else if (!isInt) {
                    return 'Der Wert muss eine Zahl sein';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Jahrgang',
                  prefixIcon: Icon(Icons.date_range),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: inhaltController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (val) {
                  bool isDouble = double.tryParse(val ?? '') != null;
                  if (val == null || val == '') {
                    return null;
                  } else if (!isDouble) {
                    return 'Der Wert muss eine Zahl sein';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Inhalt',
                  prefixIcon: Icon(Icons.local_drink),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: preisController,
                keyboardType: TextInputType.number,
                validator: (val) {
                  bool isDouble = double.tryParse(val ?? '') != null;
                  if (val == null || val == '') {
                    return null;
                  } else if (!isDouble) {
                    return 'Der Wert muss eine Zahl sein';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Preis',
                  prefixIcon: Icon(Icons.euro_symbol),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              dateSelect,
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
              SizedBox(height: 10),
              // Add TextFormFields and ElevatedButton here.
            ],
          ),
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context) async {
    DateTime? selected = await showDatePicker(
        helpText: 'Kaufdatum',
        cancelText: 'Abbrechen',
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.fromMillisecondsSinceEpoch(0),
        lastDate: DateTime.now());
    setState(() {
      selectedDate = selected;
    });
  }

  /// Sammelt alle Daten ein, erstellt daraus einen Wein, popt diesen Bildschirm vom Navigator
  /// und übergibt dabei den erstellten Wein
  void save(BuildContext context, GlobalKey<FormState> formKey) {
    // bool textFieldsValid = formKey.currentState!.validate();

    // bool textFieldValidation = formKey.currentState!.validate();

    if (!formKey.currentState!.validate() || sorteValue == null) return;

    Wein newWein = Wein(
      Provider.of<Weine>(context, listen: false),
      id: this.widget.startingValue?.id ?? 0,
      name: nameController.text,
      sorte: sorteValue!,
      anzahl: int.parse(anzahlController.text),
      getrunken: int.parse(getrunkenController.text),
      jahr: int.tryParse(jahrController.text),
      weinbauer: weinbauerValue,
      gekauft: selectedDate,
      beschreibung: beschreibungController.text == ''
          ? null
          : beschreibungController.text,
      inhalt: double.tryParse(inhaltController.text),
      fach: int.tryParse(fachController.text),
      preis: double.tryParse(preisController.text),
    );

    Navigator.pop(context, newWein);
  }
}
