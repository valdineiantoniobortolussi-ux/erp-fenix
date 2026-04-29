import 'dart:convert';
import 'package:cadastros/app/data/provider/api/api_provider_base.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class NivelFormacaoApiProvider extends ApiProviderBase {

	Future<List<NivelFormacaoModel>?> getList({Filter? filter}) async {
		List<NivelFormacaoModel> nivelFormacaoModelList = [];

		try {
			handleFilter(filter, '/nivel-formacao/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nivelFormacaoModelJson = json.decode(response.body) as List<dynamic>;
					for (var nivelFormacaoModel in nivelFormacaoModelJson) {
						nivelFormacaoModelList.add(NivelFormacaoModel.fromJson(nivelFormacaoModel));
					}
					return nivelFormacaoModelList;
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

	Future<NivelFormacaoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/nivel-formacao/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nivelFormacaoModelJson = json.decode(response.body);
					return NivelFormacaoModel.fromJson(nivelFormacaoModelJson);		 
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

	Future<NivelFormacaoModel?>? insert(NivelFormacaoModel nivelFormacaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/nivel-formacao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nivelFormacaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nivelFormacaoModelJson = json.decode(response.body);
					return NivelFormacaoModel.fromJson(nivelFormacaoModelJson);
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

	Future<NivelFormacaoModel?>? update(NivelFormacaoModel nivelFormacaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/nivel-formacao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nivelFormacaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nivelFormacaoModelJson = json.decode(response.body);
					return NivelFormacaoModel.fromJson(nivelFormacaoModelJson);
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
				Uri.tryParse('$endpoint/nivel-formacao/$pk')!,
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
