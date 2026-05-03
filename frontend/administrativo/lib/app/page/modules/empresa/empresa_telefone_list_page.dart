import 'package:flutter/material.dart';
import 'package:administrativo/app/page/shared_page/list_page_base.dart';
import 'package:administrativo/app/page/shared_widget/shared_widget_imports.dart';
import 'package:administrativo/app/controller/empresa_telefone_controller.dart';

class EmpresaTelefoneListPage extends ListPageBase<EmpresaTelefoneController> {
  const EmpresaTelefoneListPage({Key? key}) : super(key: key);

  @override
  List<Map<String, dynamic>> get mobileItems => controller.mobileItems;

  @override
  Map<String, dynamic> get mobileConfig => controller.mobileConfig;

  @override
  String get standardFieldForFilter => controller.standardFieldForFilter;

  @override
  List<Widget> standardAppBarActions() { 
    return [];
  }

  @override
  List<Widget> standardBottomActions() { 
    return [
      editButton(onPressed: controller.canUpdate ? controller.editSelectedItem : controller.noPrivilegeMessage),
      deleteButton(onPressed: controller.canDelete ? controller.deleteSelected : controller.noPrivilegeMessage),
    ];
  }

  @override
  PreferredSizeWidget? appBar() { 
    return null;
  }
}