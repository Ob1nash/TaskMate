import 'package:flutter/material.dart';
import 'package:todo_app/Utils/methods.dart';

HelperFunctions helperFunctions = HelperFunctions();


class TodoContainer extends StatelessWidget {
   int id;
   String title;
   String description;
   bool isdone;
   String date;
   Function()? onPress;

   TodoContainer({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.isdone,
    required this.date,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
  bool isDone = isdone; // Initialize with the current todo's status
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: 400,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Update your Todo",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: title,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Title",
                      ),
                      onChanged: (value) {
                        title = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: description,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Description",
                      ),
                      onChanged: (value) {
                        description = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Completed:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Switch(
                          value: isDone,
                          onChanged: (value) {
                            setState(() {
                              isDone = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Call your update function here
                      await helperFunctions.updateTodo(
                        id: id.toString(),
                        title: title,
                        description: description,
                        isdone: isDone,
                      );
                      Navigator.pop(context);
                      setState(() {}); // Update the UI
                    },
                    child: Text("Update"),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
},

        child: Container(
          width: double.infinity,
          height: 160,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 9, 102, 165),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 31, 38, 43).withOpacity(0.7),
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    IconButton(
                      onPressed: onPress,
                      icon: Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 252, 31, 2),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  date,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 254, 254),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isdone ? "Completed" : "Not Completed",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
