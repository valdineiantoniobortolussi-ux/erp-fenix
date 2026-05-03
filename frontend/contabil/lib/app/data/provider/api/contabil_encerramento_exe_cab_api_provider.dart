import 'dart:convert';
import 'package:contabil/app/data/provider/api/api_provider_base.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class ContabilEncerramentoExeCabApiProvider extends ApiProviderBase {

	Future<List<ContabilEncerramentoExeCabModel>?> getList({Filter? filter}) async {
		List<ContabilEncerramentoExeCabModel> contabilEncerramentoExeCabModelList = [];

		try {
			handleFilter(filter, '/contabil-encerramento-exe-cab/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilEncerramentoExeCabModelJson = json.decode(response.body) as List<dynamic>;
					for (var contabilEncerramentoExeCabModel in contabilEncerramentoExeCabModelJson) {
						contabilEncerramentoExeCabModelList.add(ContabilEncerramentoExeCabModel.fromJson(contabilEncerramentoExeCabModel));
					}
					return contabilEncerramentoExeCabModelList;
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

	Future<ContabilEncerramentoExeCabModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/contabil-encerramento-exe-cab/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilEncerramentoExeCabModelJson = json.decode(response.body);
					return ContabilEncerramentoExeCabModel.fromJson(contabilEncerramentoExeCabModelJson);		 
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

	Future<ContabilEncerramentoExeCabModel?>? insert(ContabilEncerramentoExeCabModel contabilEncerramentoExeCabModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/contabil-encerramento-exe-cab')!,
				headers: ApiProviderBase.headerRequisition(),
				body: contabilEncerramentoExeCabModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilEncerramentoExeCabModelJson = json.decode(response.body);
					return ContabilEncerramentoExeCabModel.fromJson(contabilEncerramentoExeCabModelJson);
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

	Future<ContabilEncerramentoExeCabModel?>? update(ContabilEncerramentoExeCabModel contabilEncerramentoExeCabModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/contabil-encerramento-exe-cab')!,
				headers: ApiProviderBase.headerRequisition(),
				body: contabilEncerramentoExeCabModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contabilEncerramentoExeCabModelJson = json.decode(response.body);
					return ContabilEncerramentoExeCabModel.fromJson(contabilEncerramentoExeCabModelJson);
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
				Uri.tryParse('$endpoint/contabil-encerramento-exe-cab/$pk')!,
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
