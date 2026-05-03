import 'dart:convert';
import 'package:nfe/app/data/provider/api/api_provider_base.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeCanaFornecimentoDiarioApiProvider extends ApiProviderBase {

	Future<List<NfeCanaFornecimentoDiarioModel>?> getList({Filter? filter}) async {
		List<NfeCanaFornecimentoDiarioModel> nfeCanaFornecimentoDiarioModelList = [];

		try {
			handleFilter(filter, '/nfe-cana-fornecimento-diario/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeCanaFornecimentoDiarioModelJson = json.decode(response.body) as List<dynamic>;
					for (var nfeCanaFornecimentoDiarioModel in nfeCanaFornecimentoDiarioModelJson) {
						nfeCanaFornecimentoDiarioModelList.add(NfeCanaFornecimentoDiarioModel.fromJson(nfeCanaFornecimentoDiarioModel));
					}
					return nfeCanaFornecimentoDiarioModelList;
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

	Future<NfeCanaFornecimentoDiarioModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/nfe-cana-fornecimento-diario/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeCanaFornecimentoDiarioModelJson = json.decode(response.body);
					return NfeCanaFornecimentoDiarioModel.fromJson(nfeCanaFornecimentoDiarioModelJson);		 
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

	Future<NfeCanaFornecimentoDiarioModel?>? insert(NfeCanaFornecimentoDiarioModel nfeCanaFornecimentoDiarioModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/nfe-cana-fornecimento-diario')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfeCanaFornecimentoDiarioModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeCanaFornecimentoDiarioModelJson = json.decode(response.body);
					return NfeCanaFornecimentoDiarioModel.fromJson(nfeCanaFornecimentoDiarioModelJson);
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

	Future<NfeCanaFornecimentoDiarioModel?>? update(NfeCanaFornecimentoDiarioModel nfeCanaFornecimentoDiarioModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/nfe-cana-fornecimento-diario')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfeCanaFornecimentoDiarioModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeCanaFornecimentoDiarioModelJson = json.decode(response.body);
					return NfeCanaFornecimentoDiarioModel.fromJson(nfeCanaFornecimentoDiarioModelJson);
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
				Uri.tryParse('$endpoint/nfe-cana-fornecimento-diario/$pk')!,
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
