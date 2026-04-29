import 'dart:convert';
import 'package:contabil/app/data/provider/api/api_provider_base.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class RegistroCartorioApiProvider extends ApiProviderBase {

	Future<List<RegistroCartorioModel>?> getList({Filter? filter}) async {
		List<RegistroCartorioModel> registroCartorioModelList = [];

		try {
			handleFilter(filter, '/registro-cartorio/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var registroCartorioModelJson = json.decode(response.body) as List<dynamic>;
					for (var registroCartorioModel in registroCartorioModelJson) {
						registroCartorioModelList.add(RegistroCartorioModel.fromJson(registroCartorioModel));
					}
					return registroCartorioModelList;
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

	Future<RegistroCartorioModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/registro-cartorio/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var registroCartorioModelJson = json.decode(response.body);
					return RegistroCartorioModel.fromJson(registroCartorioModelJson);		 
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

	Future<RegistroCartorioModel?>? insert(RegistroCartorioModel registroCartorioModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/registro-cartorio')!,
				headers: ApiProviderBase.headerRequisition(),
				body: registroCartorioModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var registroCartorioModelJson = json.decode(response.body);
					return RegistroCartorioModel.fromJson(registroCartorioModelJson);
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

	Future<RegistroCartorioModel?>? update(RegistroCartorioModel registroCartorioModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/registro-cartorio')!,
				headers: ApiProviderBase.headerRequisition(),
				body: registroCartorioModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var registroCartorioModelJson = json.decode(response.body);
					return RegistroCartorioModel.fromJson(registroCartorioModelJson);
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
				Uri.tryParse('$endpoint/registro-cartorio/$pk')!,
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
