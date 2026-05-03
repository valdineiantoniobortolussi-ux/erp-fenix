import 'dart:convert';
import 'package:cte/app/data/provider/api/api_provider_base.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteFerroviarioFerroviaApiProvider extends ApiProviderBase {

	Future<List<CteFerroviarioFerroviaModel>?> getList({Filter? filter}) async {
		List<CteFerroviarioFerroviaModel> cteFerroviarioFerroviaModelList = [];

		try {
			handleFilter(filter, '/cte-ferroviario-ferrovia/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteFerroviarioFerroviaModelJson = json.decode(response.body) as List<dynamic>;
					for (var cteFerroviarioFerroviaModel in cteFerroviarioFerroviaModelJson) {
						cteFerroviarioFerroviaModelList.add(CteFerroviarioFerroviaModel.fromJson(cteFerroviarioFerroviaModel));
					}
					return cteFerroviarioFerroviaModelList;
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

	Future<CteFerroviarioFerroviaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/cte-ferroviario-ferrovia/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteFerroviarioFerroviaModelJson = json.decode(response.body);
					return CteFerroviarioFerroviaModel.fromJson(cteFerroviarioFerroviaModelJson);		 
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

	Future<CteFerroviarioFerroviaModel?>? insert(CteFerroviarioFerroviaModel cteFerroviarioFerroviaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/cte-ferroviario-ferrovia')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteFerroviarioFerroviaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteFerroviarioFerroviaModelJson = json.decode(response.body);
					return CteFerroviarioFerroviaModel.fromJson(cteFerroviarioFerroviaModelJson);
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

	Future<CteFerroviarioFerroviaModel?>? update(CteFerroviarioFerroviaModel cteFerroviarioFerroviaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/cte-ferroviario-ferrovia')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteFerroviarioFerroviaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteFerroviarioFerroviaModelJson = json.decode(response.body);
					return CteFerroviarioFerroviaModel.fromJson(cteFerroviarioFerroviaModelJson);
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
				Uri.tryParse('$endpoint/cte-ferroviario-ferrovia/$pk')!,
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
