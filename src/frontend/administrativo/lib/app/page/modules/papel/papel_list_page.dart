import 'package:flutter/material.dart';
import 'package:administrativo/app/controller/papel_controller.dart';
import 'package:administrativo/app/page/shared_page/list_page_base.dart';

class PapelListPage extends ListPageBase<PapelController> {
  const PapelListPage({Key? key}) : super(key: key);

  @override
  List<Map<String, dynamic>> get mobileItems => controller.mobileItems;

  @override
  Map<String, dynamic> get mobileConfig => controller.mobileConfig;

  @override
  String get standardFieldForFilter => controller.standardFieldForFilter;
}