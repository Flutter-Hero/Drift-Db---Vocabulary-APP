import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary_app/database/app_db.dart';
import 'package:vocabulary_app/screens/add_vcategory.dart';
import 'package:vocabulary_app/screens/add_vocabulary.dart';

import '../provider/vocabulary_provider.dart';

class VocabularyHome extends StatelessWidget {
  const VocabularyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        showDialog(context: context, builder: (context){

          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (_)=> const AddVcategory()));

                }, child: const Text("Add Category")),
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);

      Navigator.push(context, MaterialPageRoute(builder: (_)=> const AddVocabulary()));



                }, child: const Text("Add Vocabulary")),
              ],
            ),
          );
        });

      }, child: const Icon(Icons.add),),
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

         
       
            return Column(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height*0.08,

                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: vocabularyProvider.allCategories.length,
                    
                    itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          vocabularyProvider.setSelectedCategory(vocabularyProvider.allCategories[index].id);
                          vocabularyProvider.getVocabulariesByCategoryId();

                        },
                        
                        child: Chip(label: Text(vocabularyProvider.allCategories[index].name))),
                    );
                  }),

                ),

                Expanded(
                  child: vocabularyProvider.currentVocabularies.isEmpty? const Center(child: Text("No vocabularies added yet. Please add some useing + button"),):   ListView.builder(
                  itemCount: vocabularyProvider.currentVocabularies.length,
                  
                  itemBuilder: (_, index){
                  
                    VocabularyData vocabulary = vocabularyProvider.currentVocabularies[index];
                  
                  
                  return ListTile(
                    onLongPress: (){
                      showDialog(context: context, builder: (context){
                        return AlertDialog(
                          title: const Text("Are you sure want to delete this vocabulary?"),
                          actions: [
                            TextButton(onPressed: (){
                              vocabularyProvider.deleteVocabulary(vocabulary.id);
                              Navigator.pop(context);
                            }, child: const Text("Yes")),
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: const Text("No")),
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
                    title: Text(vocabulary.word, style: const TextStyle(
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
                            }),
                ),
              ],
            );
          
        }
      )
    );
  }
}