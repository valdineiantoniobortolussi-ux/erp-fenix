import 'dart:convert';
import 'package:estoque/app/data/provider/api/api_provider_base.dart';
import 'package:estoque/app/data/model/model_imports.dart';

class RequisicaoInternaCabecalhoApiProvider extends ApiProviderBase {

	Future<List<RequisicaoInternaCabecalhoModel>?> getList({Filter? filter}) async {
		List<RequisicaoInternaCabecalhoModel> requisicaoInternaCabecalhoModelList = [];

		try {
			handleFilter(filter, '/requisicao-interna-cabecalho/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var requisicaoInternaCabecalhoModelJson = json.decode(response.body) as List<dynamic>;
					for (var requisicaoInternaCabecalhoModel in requisicaoInternaCabecalhoModelJson) {
						requisicaoInternaCabecalhoModelList.add(RequisicaoInternaCabecalhoModel.fromJson(requisicaoInternaCabecalhoModel));
					}
					return requisicaoInternaCabecalhoModelList;
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

	Future<RequisicaoInternaCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/requisicao-interna-cabecalho/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var requisicaoInternaCabecalhoModelJson = json.decode(response.body);
					return RequisicaoInternaCabecalhoModel.fromJson(requisicaoInternaCabecalhoModelJson);		 
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

	Future<RequisicaoInternaCabecalhoModel?>? insert(RequisicaoInternaCabecalhoModel requisicaoInternaCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/requisicao-interna-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: requisicaoInternaCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var requisicaoInternaCabecalhoModelJson = json.decode(response.body);
					return RequisicaoInternaCabecalhoModel.fromJson(requisicaoInternaCabecalhoModelJson);
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

	Future<RequisicaoInternaCabecalhoModel?>? update(RequisicaoInternaCabecalhoModel requisicaoInternaCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/requisicao-interna-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: requisicaoInternaCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var requisicaoInternaCabecalhoModelJson = json.decode(response.body);
					return RequisicaoInternaCabecalhoModel.fromJson(requisicaoInternaCabecalhoModelJson);
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
				Uri.tryParse('$endpoint/requisicao-interna-cabecalho/$pk')!,
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
