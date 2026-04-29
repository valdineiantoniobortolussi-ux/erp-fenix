import 'dart:convert';
import 'package:cadastros/app/data/provider/api/api_provider_base.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class ColaboradorSituacaoApiProvider extends ApiProviderBase {

	Future<List<ColaboradorSituacaoModel>?> getList({Filter? filter}) async {
		List<ColaboradorSituacaoModel> colaboradorSituacaoModelList = [];

		try {
			handleFilter(filter, '/colaborador-situacao/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var colaboradorSituacaoModelJson = json.decode(response.body) as List<dynamic>;
					for (var colaboradorSituacaoModel in colaboradorSituacaoModelJson) {
						colaboradorSituacaoModelList.add(ColaboradorSituacaoModel.fromJson(colaboradorSituacaoModel));
					}
					return colaboradorSituacaoModelList;
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

	Future<ColaboradorSituacaoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/colaborador-situacao/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var colaboradorSituacaoModelJson = json.decode(response.body);
					return ColaboradorSituacaoModel.fromJson(colaboradorSituacaoModelJson);		 
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

	Future<ColaboradorSituacaoModel?>? insert(ColaboradorSituacaoModel colaboradorSituacaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/colaborador-situacao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: colaboradorSituacaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var colaboradorSituacaoModelJson = json.decode(response.body);
					return ColaboradorSituacaoModel.fromJson(colaboradorSituacaoModelJson);
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

	Future<ColaboradorSituacaoModel?>? update(ColaboradorSituacaoModel colaboradorSituacaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/colaborador-situacao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: colaboradorSituacaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var colaboradorSituacaoModelJson = json.decode(response.body);
					return ColaboradorSituacaoModel.fromJson(colaboradorSituacaoModelJson);
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
				Uri.tryParse('$endpoint/colaborador-situacao/$pk')!,
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
