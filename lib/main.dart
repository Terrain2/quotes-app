import "package:flutter/material.dart";
import "quote.dart";
import "quote_card.dart";

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Quote> quotes = [
    Quote("Be yourself; everyone else is already taken", by: "Oscar Wilde"),
    Quote("I have nothing to declare except my genius", by: "Oscar Wilde"),
    Quote("The truth is rarely pure and never simple", by: "Oscar Wilde"),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Cool Quotes"),
      centerTitle: true,
      backgroundColor: Colors.blueAccent,
    ),
    body: Scrollbar(
      child: ListView(
        children: quotes.map((quote) => QuoteCard(
            quote,
            delete: () => setState( () => quotes.remove(quote) )
        )).toList(),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) => PopupForm(dialogContext, setState, quotes.add),
          barrierDismissible: true,
        ); // showDialog(
      }, // onPressed() {
      child: Icon(Icons.add),
    ),
  );
}

class PopupForm extends StatefulWidget {

  final Function add;
  final Function state;
  final BuildContext dialogContext;
  PopupForm(this.dialogContext, this.state, this.add);

  @override
  _PopupFormState createState() => _PopupFormState();
}

class _PopupFormState extends State<PopupForm> {

  final _formKey = GlobalKey<FormState>();
  final quoteController = TextEditingController();
  final authorController = TextEditingController();

  @override
  void dispose() {
    quoteController.dispose();
    authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SimpleDialog(
      title: Center(child: Text("Add Quote")),
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 8),
                    Text(
                      "\u201C",
                      style: TextStyle(
                        fontFamily: 'Noto Serif',
                        fontSize: 34,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: quoteController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "Quote",
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "You must enter a quote";
                          }
                          return null;
                        },
                        autofocus: true,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "\u201D",
                      style: TextStyle(
                        fontFamily: 'Noto Serif',
                        fontSize: 34,
                      ),
                    ),
                    SizedBox(width: 8),
                  ]
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                      flex: 5,
                      child: Container()
                  ),
                  Expanded(
                      flex: 4,
                      child: Row(
                          children: <Widget>[
                            Text("By:"),
                            Expanded(
                              child: TextFormField(
                                controller: authorController,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: "Author",
                                ),
                              ),
                            ),
                          ]
                      )
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
              Row(
                  children: <Widget>[
                    Expanded(
                        flex: 6,
                        child: Container(),
                    ),
                    Expanded(
                      flex: 4,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            widget.state( () => widget.add( Quote(quoteController.text, by: authorController.text) ) );
                            Navigator.pop(widget.dialogContext);
                          }
                        },
                        color: Colors.blue,
                        child: Text("Add"),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                  ]
              ),
            ],
          ),
        )
      ]
  );
}

