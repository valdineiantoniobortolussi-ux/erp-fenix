import 'dart:convert';
import 'package:ged/app/data/provider/api/api_provider_base.dart';
import 'package:ged/app/data/model/model_imports.dart';

class GedVersaoDocumentoApiProvider extends ApiProviderBase {

	Future<List<GedVersaoDocumentoModel>?> getList({Filter? filter}) async {
		List<GedVersaoDocumentoModel> gedVersaoDocumentoModelList = [];

		try {
			handleFilter(filter, '/ged-versao-documento/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var gedVersaoDocumentoModelJson = json.decode(response.body) as List<dynamic>;
					for (var gedVersaoDocumentoModel in gedVersaoDocumentoModelJson) {
						gedVersaoDocumentoModelList.add(GedVersaoDocumentoModel.fromJson(gedVersaoDocumentoModel));
					}
					return gedVersaoDocumentoModelList;
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

	Future<GedVersaoDocumentoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/ged-versao-documento/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var gedVersaoDocumentoModelJson = json.decode(response.body);
					return GedVersaoDocumentoModel.fromJson(gedVersaoDocumentoModelJson);		 
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

	Future<GedVersaoDocumentoModel?>? insert(GedVersaoDocumentoModel gedVersaoDocumentoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/ged-versao-documento')!,
				headers: ApiProviderBase.headerRequisition(),
				body: gedVersaoDocumentoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var gedVersaoDocumentoModelJson = json.decode(response.body);
					return GedVersaoDocumentoModel.fromJson(gedVersaoDocumentoModelJson);
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

	Future<GedVersaoDocumentoModel?>? update(GedVersaoDocumentoModel gedVersaoDocumentoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/ged-versao-documento')!,
				headers: ApiProviderBase.headerRequisition(),
				body: gedVersaoDocumentoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var gedVersaoDocumentoModelJson = json.decode(response.body);
					return GedVersaoDocumentoModel.fromJson(gedVersaoDocumentoModelJson);
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
				Uri.tryParse('$endpoint/ged-versao-documento/$pk')!,
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
