import 'dart:convert';
import 'package:fiscal/app/data/provider/api/api_provider_base.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class NfeCabecalhoApiProvider extends ApiProviderBase {

	Future<List<NfeCabecalhoModel>?> getList({Filter? filter}) async {
		List<NfeCabecalhoModel> nfeCabecalhoModelList = [];

		try {
			handleFilter(filter, '/nfe-cabecalho/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeCabecalhoModelJson = json.decode(response.body) as List<dynamic>;
					for (var nfeCabecalhoModel in nfeCabecalhoModelJson) {
						nfeCabecalhoModelList.add(NfeCabecalhoModel.fromJson(nfeCabecalhoModel));
					}
					return nfeCabecalhoModelList;
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

	Future<NfeCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/nfe-cabecalho/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeCabecalhoModelJson = json.decode(response.body);
					return NfeCabecalhoModel.fromJson(nfeCabecalhoModelJson);		 
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

	Future<NfeCabecalhoModel?>? insert(NfeCabecalhoModel nfeCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/nfe-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfeCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeCabecalhoModelJson = json.decode(response.body);
					return NfeCabecalhoModel.fromJson(nfeCabecalhoModelJson);
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

	Future<NfeCabecalhoModel?>? update(NfeCabecalhoModel nfeCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/nfe-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfeCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeCabecalhoModelJson = json.decode(response.body);
					return NfeCabecalhoModel.fromJson(nfeCabecalhoModelJson);
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
				Uri.tryParse('$endpoint/nfe-cabecalho/$pk')!,
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
