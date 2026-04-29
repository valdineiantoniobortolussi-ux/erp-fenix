import 'dart:convert';
import 'package:ged/app/data/provider/api/api_provider_base.dart';
import 'package:ged/app/data/model/model_imports.dart';

class GedDocumentoCabecalhoApiProvider extends ApiProviderBase {

	Future<List<GedDocumentoCabecalhoModel>?> getList({Filter? filter}) async {
		List<GedDocumentoCabecalhoModel> gedDocumentoCabecalhoModelList = [];

		try {
			handleFilter(filter, '/ged-documento-cabecalho/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var gedDocumentoCabecalhoModelJson = json.decode(response.body) as List<dynamic>;
					for (var gedDocumentoCabecalhoModel in gedDocumentoCabecalhoModelJson) {
						gedDocumentoCabecalhoModelList.add(GedDocumentoCabecalhoModel.fromJson(gedDocumentoCabecalhoModel));
					}
					return gedDocumentoCabecalhoModelList;
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

	Future<GedDocumentoCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/ged-documento-cabecalho/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var gedDocumentoCabecalhoModelJson = json.decode(response.body);
					return GedDocumentoCabecalhoModel.fromJson(gedDocumentoCabecalhoModelJson);		 
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

	Future<GedDocumentoCabecalhoModel?>? insert(GedDocumentoCabecalhoModel gedDocumentoCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/ged-documento-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: gedDocumentoCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var gedDocumentoCabecalhoModelJson = json.decode(response.body);
					return GedDocumentoCabecalhoModel.fromJson(gedDocumentoCabecalhoModelJson);
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

	Future<GedDocumentoCabecalhoModel?>? update(GedDocumentoCabecalhoModel gedDocumentoCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/ged-documento-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: gedDocumentoCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var gedDocumentoCabecalhoModelJson = json.decode(response.body);
					return GedDocumentoCabecalhoModel.fromJson(gedDocumentoCabecalhoModelJson);
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
				Uri.tryParse('$endpoint/ged-documento-cabecalho/$pk')!,
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
