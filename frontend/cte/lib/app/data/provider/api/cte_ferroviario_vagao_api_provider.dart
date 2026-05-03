import 'dart:convert';
import 'package:cte/app/data/provider/api/api_provider_base.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteFerroviarioVagaoApiProvider extends ApiProviderBase {

	Future<List<CteFerroviarioVagaoModel>?> getList({Filter? filter}) async {
		List<CteFerroviarioVagaoModel> cteFerroviarioVagaoModelList = [];

		try {
			handleFilter(filter, '/cte-ferroviario-vagao/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteFerroviarioVagaoModelJson = json.decode(response.body) as List<dynamic>;
					for (var cteFerroviarioVagaoModel in cteFerroviarioVagaoModelJson) {
						cteFerroviarioVagaoModelList.add(CteFerroviarioVagaoModel.fromJson(cteFerroviarioVagaoModel));
					}
					return cteFerroviarioVagaoModelList;
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

	Future<CteFerroviarioVagaoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/cte-ferroviario-vagao/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteFerroviarioVagaoModelJson = json.decode(response.body);
					return CteFerroviarioVagaoModel.fromJson(cteFerroviarioVagaoModelJson);		 
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

	Future<CteFerroviarioVagaoModel?>? insert(CteFerroviarioVagaoModel cteFerroviarioVagaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/cte-ferroviario-vagao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteFerroviarioVagaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteFerroviarioVagaoModelJson = json.decode(response.body);
					return CteFerroviarioVagaoModel.fromJson(cteFerroviarioVagaoModelJson);
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

	Future<CteFerroviarioVagaoModel?>? update(CteFerroviarioVagaoModel cteFerroviarioVagaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/cte-ferroviario-vagao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteFerroviarioVagaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteFerroviarioVagaoModelJson = json.decode(response.body);
					return CteFerroviarioVagaoModel.fromJson(cteFerroviarioVagaoModelJson);
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
				Uri.tryParse('$endpoint/cte-ferroviario-vagao/$pk')!,
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
