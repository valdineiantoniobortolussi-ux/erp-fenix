import 'dart:convert';
import 'package:nfe/app/data/provider/api/api_provider_base.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeNumeroInutilizadoApiProvider extends ApiProviderBase {

	Future<List<NfeNumeroInutilizadoModel>?> getList({Filter? filter}) async {
		List<NfeNumeroInutilizadoModel> nfeNumeroInutilizadoModelList = [];

		try {
			handleFilter(filter, '/nfe-numero-inutilizado/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeNumeroInutilizadoModelJson = json.decode(response.body) as List<dynamic>;
					for (var nfeNumeroInutilizadoModel in nfeNumeroInutilizadoModelJson) {
						nfeNumeroInutilizadoModelList.add(NfeNumeroInutilizadoModel.fromJson(nfeNumeroInutilizadoModel));
					}
					return nfeNumeroInutilizadoModelList;
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

	Future<NfeNumeroInutilizadoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/nfe-numero-inutilizado/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeNumeroInutilizadoModelJson = json.decode(response.body);
					return NfeNumeroInutilizadoModel.fromJson(nfeNumeroInutilizadoModelJson);		 
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

	Future<NfeNumeroInutilizadoModel?>? insert(NfeNumeroInutilizadoModel nfeNumeroInutilizadoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/nfe-numero-inutilizado')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfeNumeroInutilizadoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeNumeroInutilizadoModelJson = json.decode(response.body);
					return NfeNumeroInutilizadoModel.fromJson(nfeNumeroInutilizadoModelJson);
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

	Future<NfeNumeroInutilizadoModel?>? update(NfeNumeroInutilizadoModel nfeNumeroInutilizadoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/nfe-numero-inutilizado')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfeNumeroInutilizadoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeNumeroInutilizadoModelJson = json.decode(response.body);
					return NfeNumeroInutilizadoModel.fromJson(nfeNumeroInutilizadoModelJson);
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
				Uri.tryParse('$endpoint/nfe-numero-inutilizado/$pk')!,
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
