import 'dart:convert';
import 'package:fiscal/app/data/provider/api/api_provider_base.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class SimplesNacionalCabecalhoApiProvider extends ApiProviderBase {

	Future<List<SimplesNacionalCabecalhoModel>?> getList({Filter? filter}) async {
		List<SimplesNacionalCabecalhoModel> simplesNacionalCabecalhoModelList = [];

		try {
			handleFilter(filter, '/simples-nacional-cabecalho/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var simplesNacionalCabecalhoModelJson = json.decode(response.body) as List<dynamic>;
					for (var simplesNacionalCabecalhoModel in simplesNacionalCabecalhoModelJson) {
						simplesNacionalCabecalhoModelList.add(SimplesNacionalCabecalhoModel.fromJson(simplesNacionalCabecalhoModel));
					}
					return simplesNacionalCabecalhoModelList;
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

	Future<SimplesNacionalCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/simples-nacional-cabecalho/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var simplesNacionalCabecalhoModelJson = json.decode(response.body);
					return SimplesNacionalCabecalhoModel.fromJson(simplesNacionalCabecalhoModelJson);		 
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

	Future<SimplesNacionalCabecalhoModel?>? insert(SimplesNacionalCabecalhoModel simplesNacionalCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/simples-nacional-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: simplesNacionalCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var simplesNacionalCabecalhoModelJson = json.decode(response.body);
					return SimplesNacionalCabecalhoModel.fromJson(simplesNacionalCabecalhoModelJson);
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

	Future<SimplesNacionalCabecalhoModel?>? update(SimplesNacionalCabecalhoModel simplesNacionalCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/simples-nacional-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: simplesNacionalCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var simplesNacionalCabecalhoModelJson = json.decode(response.body);
					return SimplesNacionalCabecalhoModel.fromJson(simplesNacionalCabecalhoModelJson);
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
				Uri.tryParse('$endpoint/simples-nacional-cabecalho/$pk')!,
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
