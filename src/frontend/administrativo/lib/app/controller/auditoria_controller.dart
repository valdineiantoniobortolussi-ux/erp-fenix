import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:administrativo/app/page/grid_columns/grid_columns_imports.dart';
import 'package:administrativo/app/controller/controller_imports.dart';
import 'package:administrativo/app/data/model/model_imports.dart';
import 'package:administrativo/app/data/repository/auditoria_repository.dart';

class AuditoriaController extends ControllerBase<AuditoriaModel, AuditoriaRepository> {

  AuditoriaController({required super.repository}) {
    dbColumns = AuditoriaModel.dbColumns;
    aliasColumns = AuditoriaModel.aliasColumns;
    gridColumns = auditoriaGridColumns();
    functionName = "auditoria";
    screenTitle = "Auditoria";
  }

  @override
  AuditoriaModel createNewModel() => AuditoriaModel();

  @override
  final standardFieldForFilter = AuditoriaModel.aliasColumns[AuditoriaModel.dbColumns.indexOf('data_registro')];

  final Map<String, dynamic> mobileConfig = {
    'primaryColumns': ['data_registro'],
    'secondaryColumns': ['hora_registro'],
  };

  List<Map<String, dynamic>> get mobileItems {
    return modelList.map((auditoria) => auditoria.toJson).toList();
  }

  @override
  void prepareForInsert() {}

  @override
  void selectRowForEditingById(int id) {
    final model = modelList.firstWhere((m) => m.id == id);
    currentModel = model.clone();
    mostrarDetalhes();
  }

  @override
  Future<void> save() async {}

  String processarConteudo(String acao, String conteudo) {
    if (acao == 'GET') {
      final uri = Uri.tryParse(conteudo);
      if (uri != null && uri.queryParameters.containsKey('filter')) {
        return 'Consulta com filtro: \n - Rota: ${uri.path} \n - Filtro: ${uri.queryParameters['filter']}';
      }
      return 'Consulta sem filtro: \n - Rota: $conteudo';
    } else if (acao == 'PUT' || acao == 'POST') {
      try {
        final decoded = json.decode(conteudo);
        final tipoOperacao = acao == 'PUT' ? 'Alteração' : 'Inclusão';
        return '$tipoOperacao: \n - Dados enviados:\n${const JsonEncoder.withIndent('  ').convert(decoded)}';
      } catch (e) {
        return 'Conteúdo inválido para $acao.';
      }
    } else if (acao == 'DELETE') {
      return 'Exclusão: \n - Rota: $conteudo';
    }
    return 'Ação desconhecida.';
  }

  void mostrarDetalhes() {
    final usuarioLogin = currentModel.usuarioTokenModel?.login ?? 'Desconhecido';
    final conteudoDetalhes = processarConteudo(currentModel.acao ?? '', currentModel.conteudo ?? '');

    Get.dialog(
      AlertDialog(
        title: const Text('Detalhes da Auditoria'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Usuário: $usuarioLogin', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text('Detalhes da Ação', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(conteudoDetalhes),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(Get.context!).pop(); // Fecha apenas o diálogo
            },
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

}