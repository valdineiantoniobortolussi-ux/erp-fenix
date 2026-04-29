import 'dart:convert';
import 'package:contabil/app/data/provider/api/api_provider_base.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class ContabilDreCabecalhoApiProvider extends ApiProviderBase {

	Future<List<ContabilDreCabecalhoModel>?> getList({Filter? filter}) async {
		List<ContabilDreCabecalhoModel> contabilDreCabecalhoModelList = [];

		try {
			handleFilter(filter, '/contabil-dre-cabecalho/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilDreCabecalhoModelJson = json.decode(response.body) as List<dynamic>;
					for (var contabilDreCabecalhoModel in contabilDreCabecalhoModelJson) {
						contabilDreCabecalhoModelList.add(ContabilDreCabecalhoModel.fromJson(contabilDreCabecalhoModel));
					}
					return contabilDreCabecalhoModelList;
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

	Future<ContabilDreCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/contabil-dre-cabecalho/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilDreCabecalhoModelJson = json.decode(response.body);
					return ContabilDreCabecalhoModel.fromJson(contabilDreCabecalhoModelJson);		 
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

	Future<ContabilDreCabecalhoModel?>? insert(ContabilDreCabecalhoModel contabilDreCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/contabil-dre-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: contabilDreCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilDreCabecalhoModelJson = json.decode(response.body);
					return ContabilDreCabecalhoModel.fromJson(contabilDreCabecalhoModelJson);
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

	Future<ContabilDreCabecalhoModel?>? update(ContabilDreCabecalhoModel contabilDreCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/contabil-dre-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: contabilDreCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilDreCabecalhoModelJson = json.decode(response.body);
					return ContabilDreCabecalhoModel.fromJson(contabilDreCabecalhoModelJson);
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
				Uri.tryParse('$endpoint/contabil-dre-cabecalho/$pk')!,
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
