import 'dart:developer';

// import 'package:flutter/foundation.dart';

import '../database/app_db.dart';
import '../locator.dart';

class CategoryRepository{

   AppDb db = locator.get<AppDb>();

  Future<List<VCategoryData>> allVCategories() async {
    try {
      return await db.select(db.vCategory).get();
    } catch (e) {
      log(e.toString());

      return [];
    }
  }

  addVCategory(VCategoryCompanion vc)async{

     try {
      return await db.into(db.vCategory).insert(vc);
    } catch (e) {
      log(e.toString());

      // return [];
    }



  }




}