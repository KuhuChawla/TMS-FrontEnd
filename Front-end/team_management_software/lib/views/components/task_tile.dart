import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:team_management_software/change_notifier.dart';
import 'package:provider/provider.dart';

class TaskListItem extends StatefulWidget {
  bool isChecked = false;
  int index;
  String taskName;
  String taskDescription;
  String dueDate;

  TaskListItem(
      {Key? key,
      required this.isChecked,
      required this.index,
      required this.taskName,
      required this.taskDescription,
      required this.dueDate})
      : super(key: key);

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  String dateToShow = " ";
  updateList() async {
    await context.read<Data>().updateTaskList(widget.index);
  }

  resolveDate(String date) {
    if (date != " ") {
      var resolvedDate = DateTime.parse(date);
      String month;
      if (resolvedDate.month == 9) {
        month = "Sep";
      } else {
        month = resolvedDate.month.toString();
      }
      dateToShow = resolvedDate.day.toString() + " " + month;
    }
  }

  @override
  void initState() {
    print(widget.dueDate+"..............................");
    resolveDate(widget.dueDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(


      actionExtentRatio: 0.15,
      actionPane: const SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Archive',
          color: Colors.blue[400],
          icon: Icons.archive,
          onTap: () {},
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red[400],
          icon: Icons.delete,
          onTap: () {},
        ),
       // SlideAction(child: Icon(Icons.add))
      ],
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
              width: 1.0,
            ),
          ),
        ),
        child: ListTile(
          // tileColor: Colors.red,
          dense: true,
          horizontalTitleGap: 0,
          contentPadding:
              EdgeInsets.only(left: 0, right: 10, top: 5, bottom: 5),

          subtitle: Container(
            margin: EdgeInsets.only(right: 50),
            // color: Colors.red[100],
            child: Row(
              children: [
                Flexible(
                    child: RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: widget.taskDescription,
                          style: TextStyle(
                              color: !widget.isChecked
                                  ? Colors.grey
                                  : Colors.grey[300]),
                        ))),
              ],
            ),
          ),
          trailing: Container(
              child: Text(
            dateToShow,
            style: TextStyle(
                color: widget.isChecked ? Colors.black54 : Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w500),
          )),
          //tileColor: Colors.red,
          title: Container(
            //color: Colors.red,
            margin: const EdgeInsets.only(right: 30, bottom: 5),
            //width: 200,
            child: Row(
              children: [
                Flexible(
                    child: RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: widget.taskName,
                          style: TextStyle(
                              fontSize: 19,
                              color: !widget.isChecked
                                  ? Colors.grey[900]
                                  : Colors.grey[350],
                              fontWeight: FontWeight.w400),
                        ))),
              ],
            ),
          ),
          leading: Transform.scale(
            scale: 1.5,
            child: Checkbox(
              checkColor: Colors.yellow[800],
              activeColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22)),
              value: widget.isChecked,
              onChanged: (v) {
                updateList();
                // setState(() {
                //   isChecked=!isChecked;
                // }
                //);
              },
            ),
          ),
        ),
      ),
    );
  }
}
