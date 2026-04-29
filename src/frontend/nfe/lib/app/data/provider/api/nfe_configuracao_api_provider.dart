import 'dart:convert';
import 'package:nfe/app/data/provider/api/api_provider_base.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeConfiguracaoApiProvider extends ApiProviderBase {

	Future<List<NfeConfiguracaoModel>?> getList({Filter? filter}) async {
		List<NfeConfiguracaoModel> nfeConfiguracaoModelList = [];

		try {
			handleFilter(filter, '/nfe-configuracao/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeConfiguracaoModelJson = json.decode(response.body) as List<dynamic>;
					for (var nfeConfiguracaoModel in nfeConfiguracaoModelJson) {
						nfeConfiguracaoModelList.add(NfeConfiguracaoModel.fromJson(nfeConfiguracaoModel));
					}
					return nfeConfiguracaoModelList;
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

	Future<NfeConfiguracaoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/nfe-configuracao/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeConfiguracaoModelJson = json.decode(response.body);
					return NfeConfiguracaoModel.fromJson(nfeConfiguracaoModelJson);		 
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

	Future<NfeConfiguracaoModel?>? insert(NfeConfiguracaoModel nfeConfiguracaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/nfe-configuracao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfeConfiguracaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeConfiguracaoModelJson = json.decode(response.body);
					return NfeConfiguracaoModel.fromJson(nfeConfiguracaoModelJson);
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

	Future<NfeConfiguracaoModel?>? update(NfeConfiguracaoModel nfeConfiguracaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/nfe-configuracao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfeConfiguracaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeConfiguracaoModelJson = json.decode(response.body);
					return NfeConfiguracaoModel.fromJson(nfeConfiguracaoModelJson);
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
				Uri.tryParse('$endpoint/nfe-configuracao/$pk')!,
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
