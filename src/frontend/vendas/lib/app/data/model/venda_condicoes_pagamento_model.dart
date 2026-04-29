import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:vendas/app/data/model/model_imports.dart';
import 'package:vendas/app/data/domain/domain_imports.dart';

class VendaCondicoesPagamentoModel {
	int? id;
	String? nome;
	String? descricao;
	double? faturamentoMinimo;
	double? faturamentoMaximo;
	double? indiceCorrecao;
	int? diasTolerancia;
	double? valorTolerancia;
	int? prazoMedio;
	String? vistaPrazo;
	List<VendaCondicoesParcelasModel>? vendaCondicoesParcelasModelList;

	VendaCondicoesPagamentoModel({
		this.id,
		this.nome,
		this.descricao,
		this.faturamentoMinimo,
		this.faturamentoMaximo,
		this.indiceCorrecao,
		this.diasTolerancia,
		this.valorTolerancia,
		this.prazoMedio,
		this.vistaPrazo,
		this.vendaCondicoesParcelasModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'descricao',
		'faturamento_minimo',
		'faturamento_maximo',
		'indice_correcao',
		'dias_tolerancia',
		'valor_tolerancia',
		'prazo_medio',
		'vista_prazo',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Descricao',
		'Faturamento Minimo',
		'Faturamento Maximo',
		'Indice Correcao',
		'Dias Tolerancia',
		'Valor Tolerancia',
		'Prazo Medio',
		'Vista Prazo',
	];

	VendaCondicoesPagamentoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		descricao = jsonData['descricao'];
		faturamentoMinimo = jsonData['faturamentoMinimo']?.toDouble();
		faturamentoMaximo = jsonData['faturamentoMaximo']?.toDouble();
		indiceCorrecao = jsonData['indiceCorrecao']?.toDouble();
		diasTolerancia = jsonData['diasTolerancia'];
		valorTolerancia = jsonData['valorTolerancia']?.toDouble();
		prazoMedio = jsonData['prazoMedio'];
		vistaPrazo = VendaCondicoesPagamentoDomain.getVistaPrazo(jsonData['vistaPrazo']);
		vendaCondicoesParcelasModelList = (jsonData['vendaCondicoesParcelasModelList'] as Iterable?)?.map((m) => VendaCondicoesParcelasModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nome'] = nome;
		jsonData['descricao'] = descricao;
		jsonData['faturamentoMinimo'] = faturamentoMinimo;
		jsonData['faturamentoMaximo'] = faturamentoMaximo;
		jsonData['indiceCorrecao'] = indiceCorrecao;
		jsonData['diasTolerancia'] = diasTolerancia;
		jsonData['valorTolerancia'] = valorTolerancia;
		jsonData['prazoMedio'] = prazoMedio;
		jsonData['vistaPrazo'] = VendaCondicoesPagamentoDomain.setVistaPrazo(vistaPrazo);
		
		var vendaCondicoesParcelasModelLocalList = []; 
		for (VendaCondicoesParcelasModel object in vendaCondicoesParcelasModelList ?? []) { 
			vendaCondicoesParcelasModelLocalList.add(object.toJson); 
		}
		jsonData['vendaCondicoesParcelasModelList'] = vendaCondicoesParcelasModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		nome = plutoRow.cells['nome']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		faturamentoMinimo = plutoRow.cells['faturamentoMinimo']?.value?.toDouble();
		faturamentoMaximo = plutoRow.cells['faturamentoMaximo']?.value?.toDouble();
		indiceCorrecao = plutoRow.cells['indiceCorrecao']?.value?.toDouble();
		diasTolerancia = plutoRow.cells['diasTolerancia']?.value;
		valorTolerancia = plutoRow.cells['valorTolerancia']?.value?.toDouble();
		prazoMedio = plutoRow.cells['prazoMedio']?.value;
		vistaPrazo = plutoRow.cells['vistaPrazo']?.value != '' ? plutoRow.cells['vistaPrazo']?.value : 'A Vista';
		vendaCondicoesParcelasModelList = [];
	}	

	VendaCondicoesPagamentoModel clone() {
		return VendaCondicoesPagamentoModel(
			id: id,
			nome: nome,
			descricao: descricao,
			faturamentoMinimo: faturamentoMinimo,
			faturamentoMaximo: faturamentoMaximo,
			indiceCorrecao: indiceCorrecao,
			diasTolerancia: diasTolerancia,
			valorTolerancia: valorTolerancia,
			prazoMedio: prazoMedio,
			vistaPrazo: vistaPrazo,
			vendaCondicoesParcelasModelList: vendaCondicoesParcelasModelListClone(vendaCondicoesParcelasModelList!),
		);			
	}

	vendaCondicoesParcelasModelListClone(List<VendaCondicoesParcelasModel> vendaCondicoesParcelasModelList) { 
		List<VendaCondicoesParcelasModel> resultList = [];
		for (var vendaCondicoesParcelasModel in vendaCondicoesParcelasModelList) {
			resultList.add(
				VendaCondicoesParcelasModel(
					id: vendaCondicoesParcelasModel.id,
					idVendaCondicoesPagamento: vendaCondicoesParcelasModel.idVendaCondicoesPagamento,
					parcela: vendaCondicoesParcelasModel.parcela,
					dias: vendaCondicoesParcelasModel.dias,
					taxa: vendaCondicoesParcelasModel.taxa,
				)
			);
		}
		return resultList;
	}

	
}