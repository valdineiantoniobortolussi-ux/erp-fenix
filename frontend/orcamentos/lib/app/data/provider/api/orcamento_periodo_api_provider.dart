import 'dart:convert';
import 'package:orcamentos/app/data/provider/api/api_provider_base.dart';
import 'package:orcamentos/app/data/model/model_imports.dart';

class OrcamentoPeriodoApiProvider extends ApiProviderBase {

	Future<List<OrcamentoPeriodoModel>?> getList({Filter? filter}) async {
		List<OrcamentoPeriodoModel> orcamentoPeriodoModelList = [];

		try {
			handleFilter(filter, '/orcamento-periodo/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var orcamentoPeriodoModelJson = json.decode(response.body) as List<dynamic>;
					for (var orcamentoPeriodoModel in orcamentoPeriodoModelJson) {
						orcamentoPeriodoModelList.add(OrcamentoPeriodoModel.fromJson(orcamentoPeriodoModel));
					}
					return orcamentoPeriodoModelList;
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

	Future<OrcamentoPeriodoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/orcamento-periodo/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var orcamentoPeriodoModelJson = json.decode(response.body);
					return OrcamentoPeriodoModel.fromJson(orcamentoPeriodoModelJson);		 
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

	Future<OrcamentoPeriodoModel?>? insert(OrcamentoPeriodoModel orcamentoPeriodoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/orcamento-periodo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: orcamentoPeriodoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var orcamentoPeriodoModelJson = json.decode(response.body);
					return OrcamentoPeriodoModel.fromJson(orcamentoPeriodoModelJson);
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

	Future<OrcamentoPeriodoModel?>? update(OrcamentoPeriodoModel orcamentoPeriodoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/orcamento-periodo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: orcamentoPeriodoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var orcamentoPeriodoModelJson = json.decode(response.body);
					return OrcamentoPeriodoModel.fromJson(orcamentoPeriodoModelJson);
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
				Uri.tryParse('$endpoint/orcamento-periodo/$pk')!,
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
