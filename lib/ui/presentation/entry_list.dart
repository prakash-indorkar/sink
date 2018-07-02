import 'package:flutter/material.dart';
import 'package:sink/models/entry.dart';
import 'package:sink/ui/containers/entry_item.dart';
import 'package:sink/ui/containers/expense_form.dart';

class EntryList extends StatelessWidget {
  final List<Entry> entries;
  final Function(Entry, int) onDismissed;
  final Function onUndo;

  EntryList({this.entries, this.onDismissed, this.onUndo});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      shrinkWrap: true,
      reverse: true,
      padding: EdgeInsets.all(8.0),
      itemCount: entries.length,
      itemBuilder: (context, position) {
        return new Dismissible(
          key: ObjectKey(entries[position]),
          background: Card(
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Icon(Icons.delete),
                )
              ],
            ),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (DismissDirection direction) {
            onDismissed(entries[position], position);
            Scaffold.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 5),
                  content: Text('Entry removed'),
                  action: SnackBarAction(
                    label: "UNDO",
                    onPressed: onUndo,
                  ),
                ));
          },
          child: new InkWell(
              onTap: () => showDialog(
                  context: context,
                  builder: (context) =>
                      EditExpenseScreen(entries[position], position)),
              enableFeedback: true,
              child: Card(child: EntryItem(entries[position]))),
        );
      },
    );
  }
}
