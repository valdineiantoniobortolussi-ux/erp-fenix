import 'dart:convert';
import 'package:gondolas/app/data/provider/api/api_provider_base.dart';
import 'package:gondolas/app/data/model/model_imports.dart';

class GondolaEstanteApiProvider extends ApiProviderBase {

	Future<List<GondolaEstanteModel>?> getList({Filter? filter}) async {
		List<GondolaEstanteModel> gondolaEstanteModelList = [];

		try {
			handleFilter(filter, '/gondola-estante/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var gondolaEstanteModelJson = json.decode(response.body) as List<dynamic>;
					for (var gondolaEstanteModel in gondolaEstanteModelJson) {
						gondolaEstanteModelList.add(GondolaEstanteModel.fromJson(gondolaEstanteModel));
					}
					return gondolaEstanteModelList;
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

	Future<GondolaEstanteModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/gondola-estante/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var gondolaEstanteModelJson = json.decode(response.body);
					return GondolaEstanteModel.fromJson(gondolaEstanteModelJson);		 
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

	Future<GondolaEstanteModel?>? insert(GondolaEstanteModel gondolaEstanteModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/gondola-estante')!,
				headers: ApiProviderBase.headerRequisition(),
				body: gondolaEstanteModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var gondolaEstanteModelJson = json.decode(response.body);
					return GondolaEstanteModel.fromJson(gondolaEstanteModelJson);
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

	Future<GondolaEstanteModel?>? update(GondolaEstanteModel gondolaEstanteModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/gondola-estante')!,
				headers: ApiProviderBase.headerRequisition(),
				body: gondolaEstanteModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var gondolaEstanteModelJson = json.decode(response.body);
					return GondolaEstanteModel.fromJson(gondolaEstanteModelJson);
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
				Uri.tryParse('$endpoint/gondola-estante/$pk')!,
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
