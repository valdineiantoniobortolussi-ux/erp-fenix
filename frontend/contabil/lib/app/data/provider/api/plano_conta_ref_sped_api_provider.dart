import 'dart:convert';
import 'package:contabil/app/data/provider/api/api_provider_base.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class PlanoContaRefSpedApiProvider extends ApiProviderBase {

	Future<List<PlanoContaRefSpedModel>?> getList({Filter? filter}) async {
		List<PlanoContaRefSpedModel> planoContaRefSpedModelList = [];

		try {
			handleFilter(filter, '/plano-conta-ref-sped/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var planoContaRefSpedModelJson = json.decode(response.body) as List<dynamic>;
					for (var planoContaRefSpedModel in planoContaRefSpedModelJson) {
						planoContaRefSpedModelList.add(PlanoContaRefSpedModel.fromJson(planoContaRefSpedModel));
					}
					return planoContaRefSpedModelList;
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

	Future<PlanoContaRefSpedModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/plano-conta-ref-sped/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var planoContaRefSpedModelJson = json.decode(response.body);
					return PlanoContaRefSpedModel.fromJson(planoContaRefSpedModelJson);		 
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

	Future<PlanoContaRefSpedModel?>? insert(PlanoContaRefSpedModel planoContaRefSpedModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/plano-conta-ref-sped')!,
				headers: ApiProviderBase.headerRequisition(),
				body: planoContaRefSpedModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var planoContaRefSpedModelJson = json.decode(response.body);
					return PlanoContaRefSpedModel.fromJson(planoContaRefSpedModelJson);
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

	Future<PlanoContaRefSpedModel?>? update(PlanoContaRefSpedModel planoContaRefSpedModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/plano-conta-ref-sped')!,
				headers: ApiProviderBase.headerRequisition(),
				body: planoContaRefSpedModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var planoContaRefSpedModelJson = json.decode(response.body);
					return PlanoContaRefSpedModel.fromJson(planoContaRefSpedModelJson);
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
				Uri.tryParse('$endpoint/plano-conta-ref-sped/$pk')!,
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
