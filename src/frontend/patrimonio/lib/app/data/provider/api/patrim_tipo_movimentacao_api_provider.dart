import 'dart:convert';
import 'package:patrimonio/app/data/provider/api/api_provider_base.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';

class PatrimTipoMovimentacaoApiProvider extends ApiProviderBase {

	Future<List<PatrimTipoMovimentacaoModel>?> getList({Filter? filter}) async {
		List<PatrimTipoMovimentacaoModel> patrimTipoMovimentacaoModelList = [];

		try {
			handleFilter(filter, '/patrim-tipo-movimentacao/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var patrimTipoMovimentacaoModelJson = json.decode(response.body) as List<dynamic>;
					for (var patrimTipoMovimentacaoModel in patrimTipoMovimentacaoModelJson) {
						patrimTipoMovimentacaoModelList.add(PatrimTipoMovimentacaoModel.fromJson(patrimTipoMovimentacaoModel));
					}
					return patrimTipoMovimentacaoModelList;
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

	Future<PatrimTipoMovimentacaoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/patrim-tipo-movimentacao/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var patrimTipoMovimentacaoModelJson = json.decode(response.body);
					return PatrimTipoMovimentacaoModel.fromJson(patrimTipoMovimentacaoModelJson);		 
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

	Future<PatrimTipoMovimentacaoModel?>? insert(PatrimTipoMovimentacaoModel patrimTipoMovimentacaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/patrim-tipo-movimentacao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: patrimTipoMovimentacaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var patrimTipoMovimentacaoModelJson = json.decode(response.body);
					return PatrimTipoMovimentacaoModel.fromJson(patrimTipoMovimentacaoModelJson);
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

	Future<PatrimTipoMovimentacaoModel?>? update(PatrimTipoMovimentacaoModel patrimTipoMovimentacaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/patrim-tipo-movimentacao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: patrimTipoMovimentacaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var patrimTipoMovimentacaoModelJson = json.decode(response.body);
					return PatrimTipoMovimentacaoModel.fromJson(patrimTipoMovimentacaoModelJson);
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
				Uri.tryParse('$endpoint/patrim-tipo-movimentacao/$pk')!,
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
