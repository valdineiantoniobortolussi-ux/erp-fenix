import 'dart:convert';
import 'package:nfe/app/data/provider/api/api_provider_base.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeImportacaoDetalheApiProvider extends ApiProviderBase {

	Future<List<NfeImportacaoDetalheModel>?> getList({Filter? filter}) async {
		List<NfeImportacaoDetalheModel> nfeImportacaoDetalheModelList = [];

		try {
			handleFilter(filter, '/nfe-importacao-detalhe/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeImportacaoDetalheModelJson = json.decode(response.body) as List<dynamic>;
					for (var nfeImportacaoDetalheModel in nfeImportacaoDetalheModelJson) {
						nfeImportacaoDetalheModelList.add(NfeImportacaoDetalheModel.fromJson(nfeImportacaoDetalheModel));
					}
					return nfeImportacaoDetalheModelList;
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

	Future<NfeImportacaoDetalheModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/nfe-importacao-detalhe/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeImportacaoDetalheModelJson = json.decode(response.body);
					return NfeImportacaoDetalheModel.fromJson(nfeImportacaoDetalheModelJson);		 
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

	Future<NfeImportacaoDetalheModel?>? insert(NfeImportacaoDetalheModel nfeImportacaoDetalheModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/nfe-importacao-detalhe')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfeImportacaoDetalheModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeImportacaoDetalheModelJson = json.decode(response.body);
					return NfeImportacaoDetalheModel.fromJson(nfeImportacaoDetalheModelJson);
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

	Future<NfeImportacaoDetalheModel?>? update(NfeImportacaoDetalheModel nfeImportacaoDetalheModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/nfe-importacao-detalhe')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfeImportacaoDetalheModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeImportacaoDetalheModelJson = json.decode(response.body);
					return NfeImportacaoDetalheModel.fromJson(nfeImportacaoDetalheModelJson);
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
				Uri.tryParse('$endpoint/nfe-importacao-detalhe/$pk')!,
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
