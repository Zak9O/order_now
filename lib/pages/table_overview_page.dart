import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:order_now/constants.dart';
import 'package:order_now/view_models/account_doc_vm.dart';
import 'package:order_now/view_models/table_overview_vm.dart';
import 'package:order_now/widgets/elevated_card.dart';
import 'package:provider/provider.dart';

class TableOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TableOverviewVM(),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        children: [
          ElevatedCard(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Places',
                      style: kTitleTextStyle,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    MaterialButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: kPrimaryColor,
                      child: Text(
                        'Manage places',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          ElevatedCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tables',
                  style: kTitleTextStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                _ToolBox(),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 500.0,
                  child: Material(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20.0),
                    clipBehavior: Clip.antiAlias,
                    child: _TableOverview(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ToolBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TableOverviewVM>(
      builder: (context, model, _) => Row(
        children: [
          MaterialButton(
            child: Row(
              children: [
                Text(
                  'Add table',
                  style: TextStyle(color: Colors.white),
                ),
                model.isAddingTables
                    ? Row(
                        children: [
                          SizedBox(
                            width: 5.0,
                          ),
                          SizedBox(
                            width: 15.0,
                            height: 15.0,
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 15.0,
                      ),
              ],
            ),
            color: kPrimaryColor,
            onPressed: () async {
              //Prompts the user for amount of tables to add
              int amount = await showDialog(
                context: context,
                builder: (context) => _AddTablesDialog(),
              );
              if (amount == null) return;
              await model.addTable(context, amount);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Tables added')));
            },
          ),
          SizedBox(
            width: 20.0,
          ),
          MaterialButton(
            child: Row(
              children: [
                Text(
                  'Download all QR-codes',
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  Icons.download_rounded,
                  color: Colors.white,
                  size: 15.0,
                ),
              ],
            ),
            onPressed: () {},
            color: kPrimaryColor,
          ),
          SizedBox(
            width: 20.0,
          ),
          MaterialButton(
            child: Row(
              children: [
                Text(
                  'Download selected table${model.selectedTablesLen <= 1 ? "'s" : "s'"} QR-code',
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  Icons.download_rounded,
                  color: Colors.white,
                  size: 15.0,
                ),
              ],
            ),
            onPressed: model.isNoTablesSelected ? null : () {},
            color: kPrimaryColor,
            disabledColor: kPrimaryColor.withOpacity(0.5),
          ),
          SizedBox(
            width: 20.0,
          ),
          MaterialButton(
            child: Row(
              children: [
                Text(
                  'Delete tables',
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.white,
                  size: 15.0,
                ),
              ],
            ),
            onPressed: () async {
              await showDialog(
                  context: context, builder: (_) => _RemoveTablesDialog());
            },
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

class _TableOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountDocVM>(
      builder: (context, model, _) => model.doc == null
          ?
          //Doc has not loaded yet
          Center(child: RefreshProgressIndicator())
          : model.getField('tables') == null || model.getField('tables') == 0
              //No tables exist
              ? Center(
                  child: Text(
                  'Looks like you have got no tables yet',
                ))
              :
              //Displaying tables
              Scrollbar(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return _TableTile(
                          index: index,
                        );
                      }
                      return Column(
                        children: [
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.black12,
                          ),
                          _TableTile(index: index),
                        ],
                      );
                    },
                    itemCount: model.getField('tables'),
                  ),
                ),
    );
  }
}

class _TableTile extends StatelessWidget {
  _TableTile({@required this.index}) : assert(index != null);

  final int index;
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<TableOverviewVM>(context, listen: true);
    return CheckboxListTile(
      value: model.isTableSelected(index),
      selected: model.isTableSelected(index),
      onChanged: (val) {
        if (val) {
          model.selectTable(index);
        } else {
          model.deselectTable(index);
        }
      },
      title: Text('Table ${index + 1}'),
    );
  }
}

class _AddTablesDialog extends StatefulWidget {
  _AddTablesDialog({this.existingTables = 0});

  final existingTables;

  @override
  _AddTablesDialogState createState() => _AddTablesDialogState();
}

class _AddTablesDialogState extends State<_AddTablesDialog> {
  final controller = TextEditingController();

  int tables;

  @override
  Widget build(BuildContext context) {
    //The amount of tables the user wants to add
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: SizedBox(
          width: 200.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Tables',
                style: kTitleTextStyle,
              ),
              SizedBox(
                height: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Note:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'The amount will be added to the existing amount of tables',
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Amount of tables:'),
                  SizedBox(
                    width: 40.0,
                    child: TextField(
                      autofocus: true,
                      maxLength: 3,
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        isDense: true,
                        counterText: '',
                      ),
                      controller: controller,
                      onChanged: (str) {
                        var num = int.tryParse(str);
                        if (num == null) {
                          controller.text = '';
                          return;
                        }
                        tables = num;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'You will have a total of ${tables + widget.existingTables} tables',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  color: kPrimaryColor,
                  child: Text(
                    'Create Tables',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (tables > 250) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Cannot add more than 250 tables at once'),
                        ),
                      );
                      return;
                    }
                    Navigator.pop(context, tables);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RemoveTablesDialog extends StatefulWidget {
  @override
  _RemoveTablesDialogState createState() => _RemoveTablesDialogState();
}

class _RemoveTablesDialogState extends State<_RemoveTablesDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog();
  }
}
