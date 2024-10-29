import 'package:drift/drift.dart' as db;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary_app/database/app_db.dart';
import 'package:vocabulary_app/provider/vocabulary_provider.dart';
import 'package:vocabulary_app/repository/category_repository.dart';


class AddVcategory extends StatefulWidget {
  const AddVcategory({super.key});

  @override
  State<AddVcategory> createState() => _AddVcategoryState();
}

class _AddVcategoryState extends State<AddVcategory> {
  TextEditingController _nameController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Vcategory"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
        
        
             Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                       validator: (value){
                      if(value!.isEmpty){
                        return "Category name cannot be empty";
                      }
                    },
                     
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: "Example",
                        helperText: "Enter your category name here",
                        hintText: "Enter the category of the word",
            
                        border: OutlineInputBorder()
                      ),
                      
                      
                    ),
                  ),


                  ElevatedButton(onPressed: ()async{

                    if(_formKey.currentState!.validate()){

                      VCategoryCompanion vc = VCategoryCompanion(
                        name: db.Value(_nameController.text)
                      );

                   await  CategoryRepository().addVCategory(vc);
                   await Provider.of<VocabularyProvider>(context, listen: false).getAllCategories();
                   Navigator.pop(context);


                    }

                  }, child: Text("Add Category"))
        
          ],
        ),
      ),
    );
  }
}