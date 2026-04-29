import 'dart:convert';
import 'package:nfe/app/data/provider/api/api_provider_base.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeNumeroApiProvider extends ApiProviderBase {

	Future<List<NfeNumeroModel>?> getList({Filter? filter}) async {
		List<NfeNumeroModel> nfeNumeroModelList = [];

		try {
			handleFilter(filter, '/nfe-numero/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeNumeroModelJson = json.decode(response.body) as List<dynamic>;
					for (var nfeNumeroModel in nfeNumeroModelJson) {
						nfeNumeroModelList.add(NfeNumeroModel.fromJson(nfeNumeroModel));
					}
					return nfeNumeroModelList;
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

	Future<NfeNumeroModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/nfe-numero/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeNumeroModelJson = json.decode(response.body);
					return NfeNumeroModel.fromJson(nfeNumeroModelJson);		 
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

	Future<NfeNumeroModel?>? insert(NfeNumeroModel nfeNumeroModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/nfe-numero')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfeNumeroModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeNumeroModelJson = json.decode(response.body);
					return NfeNumeroModel.fromJson(nfeNumeroModelJson);
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

	Future<NfeNumeroModel?>? update(NfeNumeroModel nfeNumeroModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/nfe-numero')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfeNumeroModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeNumeroModelJson = json.decode(response.body);
					return NfeNumeroModel.fromJson(nfeNumeroModelJson);
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
				Uri.tryParse('$endpoint/nfe-numero/$pk')!,
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
