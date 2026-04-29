import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteRodoviarioPedagioModel {
	int? id;
	int? idCteRodoviario;
	String? cnpjFornecedor;
	String? comprovanteCompra;
	String? cnpjResponsavel;
	double? valor;
	CteRodoviarioModel? cteRodoviarioModel;

	CteRodoviarioPedagioModel({
		this.id,
		this.idCteRodoviario,
		this.cnpjFornecedor,
		this.comprovanteCompra,
		this.cnpjResponsavel,
		this.valor,
		this.cteRodoviarioModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'cnpj_fornecedor',
		'comprovante_compra',
		'cnpj_responsavel',
		'valor',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Cnpj Fornecedor',
		'Comprovante Compra',
		'Cnpj Responsavel',
		'Valor',
	];

	CteRodoviarioPedagioModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteRodoviario = jsonData['idCteRodoviario'];
		cnpjFornecedor = jsonData['cnpjFornecedor'];
		comprovanteCompra = jsonData['comprovanteCompra'];
		cnpjResponsavel = jsonData['cnpjResponsavel'];
		valor = jsonData['valor']?.toDouble();
		cteRodoviarioModel = jsonData['cteRodoviarioModel'] == null ? CteRodoviarioModel() : CteRodoviarioModel.fromJson(jsonData['cteRodoviarioModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteRodoviario'] = idCteRodoviario != 0 ? idCteRodoviario : null;
		jsonData['cnpjFornecedor'] = Util.removeMask(cnpjFornecedor);
		jsonData['comprovanteCompra'] = comprovanteCompra;
		jsonData['cnpjResponsavel'] = Util.removeMask(cnpjResponsavel);
		jsonData['valor'] = valor;
		jsonData['cteRodoviarioModel'] = cteRodoviarioModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteRodoviario = plutoRow.cells['idCteRodoviario']?.value;
		cnpjFornecedor = plutoRow.cells['cnpjFornecedor']?.value;
		comprovanteCompra = plutoRow.cells['comprovanteCompra']?.value;
		cnpjResponsavel = plutoRow.cells['cnpjResponsavel']?.value;
		valor = plutoRow.cells['valor']?.value?.toDouble();
		cteRodoviarioModel = CteRodoviarioModel();
		cteRodoviarioModel?.rntrc = plutoRow.cells['cteRodoviarioModel']?.value;
	}	

	CteRodoviarioPedagioModel clone() {
		return CteRodoviarioPedagioModel(
			id: id,
			idCteRodoviario: idCteRodoviario,
			cnpjFornecedor: cnpjFornecedor,
			comprovanteCompra: comprovanteCompra,
			cnpjResponsavel: cnpjResponsavel,
			valor: valor,
		);			
	}

	
}