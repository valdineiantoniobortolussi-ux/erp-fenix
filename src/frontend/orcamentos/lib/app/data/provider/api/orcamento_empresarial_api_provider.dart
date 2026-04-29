import 'dart:convert';
import 'package:orcamentos/app/data/provider/api/api_provider_base.dart';
import 'package:orcamentos/app/data/model/model_imports.dart';

class OrcamentoEmpresarialApiProvider extends ApiProviderBase {

	Future<List<OrcamentoEmpresarialModel>?> getList({Filter? filter}) async {
		List<OrcamentoEmpresarialModel> orcamentoEmpresarialModelList = [];

		try {
			handleFilter(filter, '/orcamento-empresarial/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var orcamentoEmpresarialModelJson = json.decode(response.body) as List<dynamic>;
					for (var orcamentoEmpresarialModel in orcamentoEmpresarialModelJson) {
						orcamentoEmpresarialModelList.add(OrcamentoEmpresarialModel.fromJson(orcamentoEmpresarialModel));
					}
					return orcamentoEmpresarialModelList;
				}
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<OrcamentoEmpresarialModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/orcamento-empresarial/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var orcamentoEmpresarialModelJson = json.decode(response.body);
					return OrcamentoEmpresarialModel.fromJson(orcamentoEmpresarialModelJson);		 
				}
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<OrcamentoEmpresarialModel?>? insert(OrcamentoEmpresarialModel orcamentoEmpresarialModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/orcamento-empresarial')!,
				headers: ApiProviderBase.headerRequisition(),
				body: orcamentoEmpresarialModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var orcamentoEmpresarialModelJson = json.decode(response.body);
					return OrcamentoEmpresarialModel.fromJson(orcamentoEmpresarialModelJson);
				}
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<OrcamentoEmpresarialModel?>? update(OrcamentoEmpresarialModel orcamentoEmpresarialModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/orcamento-empresarial')!,
				headers: ApiProviderBase.headerRequisition(),
				body: orcamentoEmpresarialModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var orcamentoEmpresarialModelJson = json.decode(response.body);
					return OrcamentoEmpresarialModel.fromJson(orcamentoEmpresarialModelJson);
				}
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.delete(
				Uri.tryParse('$endpoint/orcamento-empresarial/$pk')!,
				headers: ApiProviderBase.headerRequisition(),
			);

			if (response.statusCode == 200) {
				return true;
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	
}
