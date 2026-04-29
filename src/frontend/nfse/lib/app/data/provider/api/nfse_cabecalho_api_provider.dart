import 'dart:convert';
import 'package:nfse/app/data/provider/api/api_provider_base.dart';
import 'package:nfse/app/data/model/model_imports.dart';

class NfseCabecalhoApiProvider extends ApiProviderBase {

	Future<List<NfseCabecalhoModel>?> getList({Filter? filter}) async {
		List<NfseCabecalhoModel> nfseCabecalhoModelList = [];

		try {
			handleFilter(filter, '/nfse-cabecalho/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfseCabecalhoModelJson = json.decode(response.body) as List<dynamic>;
					for (var nfseCabecalhoModel in nfseCabecalhoModelJson) {
						nfseCabecalhoModelList.add(NfseCabecalhoModel.fromJson(nfseCabecalhoModel));
					}
					return nfseCabecalhoModelList;
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

	Future<NfseCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/nfse-cabecalho/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfseCabecalhoModelJson = json.decode(response.body);
					return NfseCabecalhoModel.fromJson(nfseCabecalhoModelJson);		 
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

	Future<NfseCabecalhoModel?>? insert(NfseCabecalhoModel nfseCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/nfse-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfseCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfseCabecalhoModelJson = json.decode(response.body);
					return NfseCabecalhoModel.fromJson(nfseCabecalhoModelJson);
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

	Future<NfseCabecalhoModel?>? update(NfseCabecalhoModel nfseCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/nfse-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfseCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfseCabecalhoModelJson = json.decode(response.body);
					return NfseCabecalhoModel.fromJson(nfseCabecalhoModelJson);
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
				Uri.tryParse('$endpoint/nfse-cabecalho/$pk')!,
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
