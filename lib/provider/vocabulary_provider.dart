import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vocabulary_app/database/db_tables.dart';
import 'package:vocabulary_app/repository/voacabulary_repository.dart';

import '../database/app_db.dart';

class VocabularyProvider extends ChangeNotifier{

  VocabularyProvider(){
    getAllVocabularies();
  }


  VoacabularyRepository _voacabularyRepository = VoacabularyRepository();
  List<VocabularyData> _allVocabularies = [];
  List<VocabularyData> get allVocabularies => _allVocabularies;

  bool _checkBoxValue = false;
  bool get checkBoxValue => _checkBoxValue;

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