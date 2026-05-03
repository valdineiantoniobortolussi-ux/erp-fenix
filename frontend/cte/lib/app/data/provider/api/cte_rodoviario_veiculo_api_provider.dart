import 'dart:convert';
import 'package:cte/app/data/provider/api/api_provider_base.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteRodoviarioVeiculoApiProvider extends ApiProviderBase {

	Future<List<CteRodoviarioVeiculoModel>?> getList({Filter? filter}) async {
		List<CteRodoviarioVeiculoModel> cteRodoviarioVeiculoModelList = [];

		try {
			handleFilter(filter, '/cte-rodoviario-veiculo/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteRodoviarioVeiculoModelJson = json.decode(response.body) as List<dynamic>;
					for (var cteRodoviarioVeiculoModel in cteRodoviarioVeiculoModelJson) {
						cteRodoviarioVeiculoModelList.add(CteRodoviarioVeiculoModel.fromJson(cteRodoviarioVeiculoModel));
					}
					return cteRodoviarioVeiculoModelList;
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

	Future<CteRodoviarioVeiculoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/cte-rodoviario-veiculo/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteRodoviarioVeiculoModelJson = json.decode(response.body);
					return CteRodoviarioVeiculoModel.fromJson(cteRodoviarioVeiculoModelJson);		 
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

	Future<CteRodoviarioVeiculoModel?>? insert(CteRodoviarioVeiculoModel cteRodoviarioVeiculoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/cte-rodoviario-veiculo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteRodoviarioVeiculoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteRodoviarioVeiculoModelJson = json.decode(response.body);
					return CteRodoviarioVeiculoModel.fromJson(cteRodoviarioVeiculoModelJson);
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

	Future<CteRodoviarioVeiculoModel?>? update(CteRodoviarioVeiculoModel cteRodoviarioVeiculoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/cte-rodoviario-veiculo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteRodoviarioVeiculoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteRodoviarioVeiculoModelJson = json.decode(response.body);
					return CteRodoviarioVeiculoModel.fromJson(cteRodoviarioVeiculoModelJson);
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
				Uri.tryParse('$endpoint/cte-rodoviario-veiculo/$pk')!,
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
