import 'dart:convert';
import 'package:nfse/app/data/provider/api/api_provider_base.dart';
import 'package:nfse/app/data/model/model_imports.dart';

class NfseListaServicoApiProvider extends ApiProviderBase {

	Future<List<NfseListaServicoModel>?> getList({Filter? filter}) async {
		List<NfseListaServicoModel> nfseListaServicoModelList = [];

		try {
			handleFilter(filter, '/nfse-lista-servico/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfseListaServicoModelJson = json.decode(response.body) as List<dynamic>;
					for (var nfseListaServicoModel in nfseListaServicoModelJson) {
						nfseListaServicoModelList.add(NfseListaServicoModel.fromJson(nfseListaServicoModel));
					}
					return nfseListaServicoModelList;
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

	Future<NfseListaServicoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/nfse-lista-servico/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfseListaServicoModelJson = json.decode(response.body);
					return NfseListaServicoModel.fromJson(nfseListaServicoModelJson);		 
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

	Future<NfseListaServicoModel?>? insert(NfseListaServicoModel nfseListaServicoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/nfse-lista-servico')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfseListaServicoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfseListaServicoModelJson = json.decode(response.body);
					return NfseListaServicoModel.fromJson(nfseListaServicoModelJson);
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

	Future<NfseListaServicoModel?>? update(NfseListaServicoModel nfseListaServicoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/nfse-lista-servico')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfseListaServicoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfseListaServicoModelJson = json.decode(response.body);
					return NfseListaServicoModel.fromJson(nfseListaServicoModelJson);
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
				Uri.tryParse('$endpoint/nfse-lista-servico/$pk')!,
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
