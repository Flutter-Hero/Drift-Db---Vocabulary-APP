import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vocabulary_app/database/db_tables.dart';
import 'package:vocabulary_app/repository/category_repository.dart';
import 'package:vocabulary_app/repository/voacabulary_repository.dart';

import '../database/app_db.dart';

class VocabularyProvider extends ChangeNotifier{

  VocabularyProvider(){
    getAllVocabularies();
    getAllCategories();
  }

  VCategoryData? _dropDownSelcetedCategory;
  VCategoryData? get dropDownSelectedCategory => _dropDownSelcetedCategory;

  setDropDownSelectedCategory(VCategoryData vc){
    _dropDownSelcetedCategory= vc;
    notifyListeners();

  }


  VoacabularyRepository _voacabularyRepository = VoacabularyRepository();
  CategoryRepository _categoryRepository = CategoryRepository();


  List<VocabularyData> _allVocabularies = [];
  List<VocabularyData> get allVocabularies => _allVocabularies;

  List<VCategoryData> _allCategories = [];
  List<VCategoryData> get allCategories => _allCategories;

 int? _selectedCategoryId;
 int? get selectedCategoryId => _selectedCategoryId;


 setSelectedCategory(int id){
  _selectedCategoryId = id;
  notifyListeners();
 }

  bool _checkBoxValue = false;
  bool get checkBoxValue => _checkBoxValue;


  getAllCategories()async {

    _allCategories = await _categoryRepository.allVCategories();
    notifyListeners();
  }

  getVocabulariesByCategoryId(){

    // getAllVocabularies();

    // debugPrint(_selectedCategoryId!);
    log("The selected category id is $_selectedCategoryId");

    _allVocabularies =  _allVocabularies.where((vocabulary)=> vocabulary.categoryId== _selectedCategoryId).toList();
    print(" the all vocabularies having id $_selectedCategoryId are $_allVocabularies");
    notifyListeners();
  }

  // initialize

  setCheckBoxValue(bool value){

    _checkBoxValue = value;
    notifyListeners();

  }


  getAllVocabularies()async {

   _allVocabularies = await _voacabularyRepository.allVocabularies();
   log("the all vocabularies are $_allVocabularies");
   notifyListeners();
  }

  addVocabulary(VocabularyCompanion vc)async {

    await _voacabularyRepository.addVocabulary(vc);
    getAllVocabularies();
  }

   updateVocabulary(VocabularyCompanion vc)async {


    await _voacabularyRepository.updateVocabulary(vc);
    getAllVocabularies();
  }

   deleteVocabulary(int id)async {

    await _voacabularyRepository.deleteVocabulary(id);
    getAllVocabularies();
  }

  // updateVocabulary



}