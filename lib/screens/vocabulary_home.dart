import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary_app/database/app_db.dart';
import 'package:vocabulary_app/screens/add_vocabulary.dart';

import '../provider/vocabulary_provider.dart';

class VocabularyHome extends StatelessWidget {
  const VocabularyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){

      Navigator.push(context, MaterialPageRoute(builder: (_)=> AddVocabulary()));
      }, child: Icon(Icons.add),),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Vocabulary Learning App", style: TextStyle(
          color: Colors.white,
          
        ),
        
        
        ),
        centerTitle: true,

      ),
      body: Consumer<VocabularyProvider>(
        builder: (_, vocabularyProvider, __){

          if(vocabularyProvider.allVocabularies.isEmpty){
            return const Center(child: Text("No vocabularies added yet. Please add some useing + button"),);
          }
          else {
            return ListView.builder(
            itemCount: vocabularyProvider.allVocabularies.length,
            
            itemBuilder: (_, index){

              VocabularyData vocabulary = vocabularyProvider.allVocabularies[index];


            return ListTile(
              onLongPress: (){
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    title: Text("Are you sure want to delete this vocabulary?"),
                    actions: [
                      TextButton(onPressed: (){
                        vocabularyProvider.deleteVocabulary(vocabulary.id);
                        Navigator.pop(context);
                      }, child: Text("Yes")),
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text("No")),
                    ],
                  );
                });
              },
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> AddVocabulary(
                  vd: vocabulary,
                )));

              },
              leading: CircleAvatar(
                child: Center(
                  child: Text("${index+1}"),
                ),
              ),
              title: Text(vocabulary.word, style: TextStyle(
                fontWeight: FontWeight.bold
              ),),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(vocabulary.definition, ),
                  Text(vocabulary.exampleSentence??'')
                ],
              ),
              trailing: vocabulary.mastered? const Icon(Icons.check): null,
            );
          });
          }
        }
      )
    );
  }
}