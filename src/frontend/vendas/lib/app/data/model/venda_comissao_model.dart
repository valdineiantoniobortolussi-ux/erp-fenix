import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:vendas/app/infra/infra_imports.dart';
import 'package:vendas/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:vendas/app/data/domain/domain_imports.dart';

class VendaComissaoModel {
	int? id;
	int? idVendaCabecalho;
	int? idVendedor;
	double? valorVenda;
	String? tipoContabil;
	double? valorComissao;
	String? situacao;
	DateTime? dataLancamento;
	ViewPessoaVendedorModel? viewPessoaVendedorModel;

	VendaComissaoModel({
		this.id,
		this.idVendaCabecalho,
		this.idVendedor,
		this.valorVenda,
		this.tipoContabil,
		this.valorComissao,
		this.situacao,
		this.dataLancamento,
		this.viewPessoaVendedorModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'valor_venda',
		'tipo_contabil',
		'valor_comissao',
		'situacao',
		'data_lancamento',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Valor Venda',
		'Tipo Contabil',
		'Valor Comissao',
		'Situacao',
		'Data Lancamento',
	];

	VendaComissaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idVendaCabecalho = jsonData['idVendaCabecalho'];
		idVendedor = jsonData['idVendedor'];
		valorVenda = jsonData['valorVenda']?.toDouble();
		tipoContabil = VendaComissaoDomain.getTipoContabil(jsonData['tipoContabil']);
		valorComissao = jsonData['valorComissao']?.toDouble();
		situacao = VendaComissaoDomain.getSituacao(jsonData['situacao']);
		dataLancamento = jsonData['dataLancamento'] != null ? DateTime.tryParse(jsonData['dataLancamento']) : null;
		viewPessoaVendedorModel = jsonData['viewPessoaVendedorModel'] == null ? ViewPessoaVendedorModel() : ViewPessoaVendedorModel.fromJson(jsonData['viewPessoaVendedorModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idVendaCabecalho'] = idVendaCabecalho != 0 ? idVendaCabecalho : null;
		jsonData['idVendedor'] = idVendedor != 0 ? idVendedor : null;
		jsonData['valorVenda'] = valorVenda;
		jsonData['tipoContabil'] = VendaComissaoDomain.setTipoContabil(tipoContabil);
		jsonData['valorComissao'] = valorComissao;
		jsonData['situacao'] = VendaComissaoDomain.setSituacao(situacao);
		jsonData['dataLancamento'] = dataLancamento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataLancamento!) : null;
		jsonData['viewPessoaVendedorModel'] = viewPessoaVendedorModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idVendaCabecalho = plutoRow.cells['idVendaCabecalho']?.value;
		idVendedor = plutoRow.cells['idVendedor']?.value;
		valorVenda = plutoRow.cells['valorVenda']?.value?.toDouble();
		tipoContabil = plutoRow.cells['tipoContabil']?.value != '' ? plutoRow.cells['tipoContabil']?.value : 'Crédito';
		valorComissao = plutoRow.cells['valorComissao']?.value?.toDouble();
		situacao = plutoRow.cells['situacao']?.value != '' ? plutoRow.cells['situacao']?.value : 'Aberto';
		dataLancamento = Util.stringToDate(plutoRow.cells['dataLancamento']?.value);
		viewPessoaVendedorModel = ViewPessoaVendedorModel();
		viewPessoaVendedorModel?.nome = plutoRow.cells['viewPessoaVendedorModel']?.value;
	}	

	VendaComissaoModel clone() {
		return VendaComissaoModel(
			id: id,
			idVendaCabecalho: idVendaCabecalho,
			idVendedor: idVendedor,
			valorVenda: valorVenda,
			tipoContabil: tipoContabil,
			valorComissao: valorComissao,
			situacao: situacao,
			dataLancamento: dataLancamento,
		);			
	}

	
}