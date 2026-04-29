import 'dart:convert';
import 'package:financeiro/app/data/provider/api/api_provider_base.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinLancamentoReceberApiProvider extends ApiProviderBase {

	Future<List<FinLancamentoReceberModel>?> getList({Filter? filter}) async {
		List<FinLancamentoReceberModel> finLancamentoReceberModelList = [];

		try {
			handleFilter(filter, '/fin-lancamento-receber/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finLancamentoReceberModelJson = json.decode(response.body) as List<dynamic>;
					for (var finLancamentoReceberModel in finLancamentoReceberModelJson) {
						finLancamentoReceberModelList.add(FinLancamentoReceberModel.fromJson(finLancamentoReceberModel));
					}
					return finLancamentoReceberModelList;
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

	Future<FinLancamentoReceberModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/fin-lancamento-receber/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finLancamentoReceberModelJson = json.decode(response.body);
					return FinLancamentoReceberModel.fromJson(finLancamentoReceberModelJson);		 
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

	Future<FinLancamentoReceberModel?>? insert(FinLancamentoReceberModel finLancamentoReceberModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/fin-lancamento-receber')!,
				headers: ApiProviderBase.headerRequisition(),
				body: finLancamentoReceberModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finLancamentoReceberModelJson = json.decode(response.body);
					return FinLancamentoReceberModel.fromJson(finLancamentoReceberModelJson);
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

	Future<FinLancamentoReceberModel?>? update(FinLancamentoReceberModel finLancamentoReceberModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/fin-lancamento-receber')!,
				headers: ApiProviderBase.headerRequisition(),
				body: finLancamentoReceberModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var finLancamentoReceberModelJson = json.decode(response.body);
					return FinLancamentoReceberModel.fromJson(finLancamentoReceberModelJson);
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
				Uri.tryParse('$endpoint/fin-lancamento-receber/$pk')!,
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
