import 'dart:convert';
import 'package:ged/app/data/provider/api/api_provider_base.dart';
import 'package:ged/app/data/model/model_imports.dart';

class GedTipoDocumentoApiProvider extends ApiProviderBase {

	Future<List<GedTipoDocumentoModel>?> getList({Filter? filter}) async {
		List<GedTipoDocumentoModel> gedTipoDocumentoModelList = [];

		try {
			handleFilter(filter, '/ged-tipo-documento/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var gedTipoDocumentoModelJson = json.decode(response.body) as List<dynamic>;
					for (var gedTipoDocumentoModel in gedTipoDocumentoModelJson) {
						gedTipoDocumentoModelList.add(GedTipoDocumentoModel.fromJson(gedTipoDocumentoModel));
					}
					return gedTipoDocumentoModelList;
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

	Future<GedTipoDocumentoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/ged-tipo-documento/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var gedTipoDocumentoModelJson = json.decode(response.body);
					return GedTipoDocumentoModel.fromJson(gedTipoDocumentoModelJson);		 
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

	Future<GedTipoDocumentoModel?>? insert(GedTipoDocumentoModel gedTipoDocumentoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/ged-tipo-documento')!,
				headers: ApiProviderBase.headerRequisition(),
				body: gedTipoDocumentoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var gedTipoDocumentoModelJson = json.decode(response.body);
					return GedTipoDocumentoModel.fromJson(gedTipoDocumentoModelJson);
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

	Future<GedTipoDocumentoModel?>? update(GedTipoDocumentoModel gedTipoDocumentoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/ged-tipo-documento')!,
				headers: ApiProviderBase.headerRequisition(),
				body: gedTipoDocumentoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var gedTipoDocumentoModelJson = json.decode(response.body);
					return GedTipoDocumentoModel.fromJson(gedTipoDocumentoModelJson);
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
				Uri.tryParse('$endpoint/ged-tipo-documento/$pk')!,
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
