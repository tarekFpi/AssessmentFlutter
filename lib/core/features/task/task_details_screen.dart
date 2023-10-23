
import 'dart:ffi';

import 'package:assessment/core/features/task/model/task_response.dart';
import 'package:assessment/core/features/theme/color_scheme.dart';
import 'package:assessment/core/features/utils/hexcolor.dart';
import 'package:flutter/material.dart';


class TaskDetailsScreen extends StatefulWidget {
  final TaskResponse tasklist;

  const TaskDetailsScreen({Key? key, required this.tasklist}) : super(key: key);

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  @override
  Widget build(BuildContext context) {

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(child: Scaffold(
      backgroundColor:colorScheme.surfaceVariant,
      appBar: AppBar(
        backgroundColor:colorScheme.surface,
        elevation: 2,
        title: Text("Task Details",style: textTheme.bodySmall?.copyWith(
            color: lightColorScheme.onTertiaryContainer, fontSize: 18,fontWeight: FontWeight.w500),),
      ),
      body: Container(
        decoration: BoxDecoration(
          color:  HexColor("#FAFDFC"),
        ),
        margin: EdgeInsets.all(8),
        child: Column(
          children: [

             SizedBox(height: 12,),


                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(),
                  child: Image.network('${widget.tasklist.image}',
                   fit: BoxFit.fill,height: 200,width: double.infinity,),
               ),


            SizedBox(height: 12,),

            Text("Name: ${widget.tasklist.name}",style: textTheme.bodySmall?.copyWith(
                color: lightColorScheme.onTertiaryContainer,
                fontSize: 18,fontWeight: FontWeight.w500),),

             Divider(height: 8, color: Colors.black38,),

            Text("Species: ${widget.tasklist.species}",style: textTheme.bodySmall?.copyWith(
                color: lightColorScheme.onTertiaryContainer,
                fontSize: 18,fontWeight: FontWeight.w500),),

            Divider(height: 8,color: Colors.black38),

            Text("Gender: ${widget.tasklist.gender}",style: textTheme.bodySmall?.copyWith(
                color: lightColorScheme.onTertiaryContainer,
                fontSize: 18,fontWeight: FontWeight.w500),),

            Divider(height: 8,color: Colors.black38),

            Text("House: ${widget.tasklist.house}",style: textTheme.bodySmall?.copyWith(
                color: lightColorScheme.onTertiaryContainer,
                fontSize: 18,fontWeight: FontWeight.w500),),
          ],
        ),
      ),
    ));
  }
}
