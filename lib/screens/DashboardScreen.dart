import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notes_app/bloc/notes_bloc.dart';
import 'package:notes_app/data/notes.dart';
import 'package:notes_app/notesCard.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  addNotes(Notes notes){
    context.read<NotesBloc>().add(
      AddNotes(notes),
    );
  }

  removeNotes(Notes notes){
    context.read<NotesBloc>().add(
      RemoveNotes(notes)
    );
  }

  updateNotes(int index){
    context.read<NotesBloc>().add(
      updateNotes(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    final titlecontroller = TextEditingController();
    final descController= TextEditingController();
    final size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(

        title: Text('Notes',style: TextStyle(fontSize:  size.height*0.04,fontWeight: FontWeight.bold),),
        elevation: 0,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.settings_outlined))
        ],
      ),

      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(size.height*0.05)),
        onPressed: (){
          showModalBottomSheet(
              context: context, builder: (context){
                return Scaffold(
                  body: SingleChildScrollView(
                    child: Padding(
                      padding:  EdgeInsets.all(size.height*0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left:size.height*0.01),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Add Notes",
                                  style:TextStyle(
                                    fontSize: size.height*0.035,
                                    fontWeight: FontWeight.w400
                                  ) ,),
                                ElevatedButton(
                                    onPressed: (){
                                      print("Adding Notes called !!!!!!!!!!");
                                      if(titlecontroller.text.isNotEmpty && descController.text.isNotEmpty){
                                        addNotes(
                                            Notes(
                                              title: titlecontroller.text,
                                              desc: descController.text,
                                            ),
                                        );
                                        print(Notes);

                                        titlecontroller.text ='';
                                        descController.text = '';
                                        Navigator.pop(context);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green[800],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(size.height*0.02)
                                      )
                                      
                                    ),
                                    child: Text('Submit'))
                              ],
                            ),
                          ),
                          SizedBox(height: size.height*0.03,),
                           TextField(
                             textInputAction: TextInputAction.next,
                             controller: titlecontroller,
                            decoration: InputDecoration(
                              labelText: "Title",
                              labelStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              hintText: "Enter the title",

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(size.height*0.02),
                                borderSide: BorderSide(
                                  color:Colors.white,
                                  width: size.height*0.002,

                                )
                              ),
                              focusedBorder:  OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(size.height*0.02),
                                  borderSide: BorderSide(
                                      color:Colors.green,
                                      width: size.height*0.002
                                  )
                              )
                            ),


                          ),
                          SizedBox(height: size.height*0.02,),
                          TextField(
                            textInputAction: TextInputAction.done,
                            controller: descController,
                            decoration: InputDecoration(
                                labelText: "Description",
                                labelStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                hintText: "Enter the description",

                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(size.height*0.02),
                                    borderSide: BorderSide(
                                        color:Colors.white,
                                        width: size.height*0.002
                                    )
                                ),
                                focusedBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(size.height*0.02),
                                    borderSide: BorderSide(
                                        color:Colors.green,
                                        width: size.height*0.002
                                    )
                                )
                            ),
                            minLines: 8,
                            maxLines: 20,

                          )
                        ],
                      ),
                    ),
                  ),
                );
          });
        },
      child: Icon(
        Icons.add
      ),
      ),
      body:Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<NotesBloc, NotesState>(
          builder: ( context,  state) {
            if(state.status==NotesStatus.success){
              return GridView.builder(
                itemCount: state.notes.length,
                  gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ) ,
                  itemBuilder: (context, int i){
                  return NotesCard(
                    title: state.notes[i].title,
                    desc: state.notes[i].desc,
                  );
                  });
            }else if(state.status== NotesStatus.initial){
              return Center(child: Text("Please add some notes!!"));
            }else{
              return Container();
            }
          },

        ),
      )    );
  }
}
