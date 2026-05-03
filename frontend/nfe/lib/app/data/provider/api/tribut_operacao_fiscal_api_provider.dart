import 'dart:convert';
import 'package:nfe/app/data/provider/api/api_provider_base.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class TributOperacaoFiscalApiProvider extends ApiProviderBase {

	Future<List<TributOperacaoFiscalModel>?> getList({Filter? filter}) async {
		List<TributOperacaoFiscalModel> tributOperacaoFiscalModelList = [];

		try {
			handleFilter(filter, '/tribut-operacao-fiscal/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tributOperacaoFiscalModelJson = json.decode(response.body) as List<dynamic>;
					for (var tributOperacaoFiscalModel in tributOperacaoFiscalModelJson) {
						tributOperacaoFiscalModelList.add(TributOperacaoFiscalModel.fromJson(tributOperacaoFiscalModel));
					}
					return tributOperacaoFiscalModelList;
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

	Future<TributOperacaoFiscalModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/tribut-operacao-fiscal/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tributOperacaoFiscalModelJson = json.decode(response.body);
					return TributOperacaoFiscalModel.fromJson(tributOperacaoFiscalModelJson);		 
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

	Future<TributOperacaoFiscalModel?>? insert(TributOperacaoFiscalModel tributOperacaoFiscalModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/tribut-operacao-fiscal')!,
				headers: ApiProviderBase.headerRequisition(),
				body: tributOperacaoFiscalModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tributOperacaoFiscalModelJson = json.decode(response.body);
					return TributOperacaoFiscalModel.fromJson(tributOperacaoFiscalModelJson);
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

	Future<TributOperacaoFiscalModel?>? update(TributOperacaoFiscalModel tributOperacaoFiscalModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/tribut-operacao-fiscal')!,
				headers: ApiProviderBase.headerRequisition(),
				body: tributOperacaoFiscalModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var tributOperacaoFiscalModelJson = json.decode(response.body);
					return TributOperacaoFiscalModel.fromJson(tributOperacaoFiscalModelJson);
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
				Uri.tryParse('$endpoint/tribut-operacao-fiscal/$pk')!,
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
