import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class PatrimGrupoBemModel {
	int? id;
	String? codigo;
	String? nome;
	String? descricao;
	String? contaAtivoImobilizado;
	String? contaDepreciacaoAcumulada;
	String? contaDespesaDepreciacao;
	int? codigoHistorico;

	PatrimGrupoBemModel({
		this.id,
		this.codigo,
		this.nome,
		this.descricao,
		this.contaAtivoImobilizado,
		this.contaDepreciacaoAcumulada,
		this.contaDespesaDepreciacao,
		this.codigoHistorico,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'nome',
		'descricao',
		'conta_ativo_imobilizado',
		'conta_depreciacao_acumulada',
		'conta_despesa_depreciacao',
		'codigo_historico',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Nome',
		'Descricao',
		'Conta Ativo Imobilizado',
		'Conta Depreciacao Acumulada',
		'Conta Despesa Depreciacao',
		'Codigo Historico',
	];

	PatrimGrupoBemModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		codigo = jsonData['codigo'];
		nome = jsonData['nome'];
		descricao = jsonData['descricao'];
		contaAtivoImobilizado = jsonData['contaAtivoImobilizado'];
		contaDepreciacaoAcumulada = jsonData['contaDepreciacaoAcumulada'];
		contaDespesaDepreciacao = jsonData['contaDespesaDepreciacao'];
		codigoHistorico = jsonData['codigoHistorico'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['codigo'] = codigo;
		jsonData['nome'] = nome;
		jsonData['descricao'] = descricao;
		jsonData['contaAtivoImobilizado'] = contaAtivoImobilizado;
		jsonData['contaDepreciacaoAcumulada'] = contaDepreciacaoAcumulada;
		jsonData['contaDespesaDepreciacao'] = contaDespesaDepreciacao;
		jsonData['codigoHistorico'] = codigoHistorico;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		codigo = plutoRow.cells['codigo']?.value;
		nome = plutoRow.cells['nome']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		contaAtivoImobilizado = plutoRow.cells['contaAtivoImobilizado']?.value;
		contaDepreciacaoAcumulada = plutoRow.cells['contaDepreciacaoAcumulada']?.value;
		contaDespesaDepreciacao = plutoRow.cells['contaDespesaDepreciacao']?.value;
		codigoHistorico = plutoRow.cells['codigoHistorico']?.value;
	}	

	PatrimGrupoBemModel clone() {
		return PatrimGrupoBemModel(
			id: id,
			codigo: codigo,
			nome: nome,
			descricao: descricao,
			contaAtivoImobilizado: contaAtivoImobilizado,
			contaDepreciacaoAcumulada: contaDepreciacaoAcumulada,
			contaDespesaDepreciacao: contaDespesaDepreciacao,
			codigoHistorico: codigoHistorico,
		);			
	}

	
}