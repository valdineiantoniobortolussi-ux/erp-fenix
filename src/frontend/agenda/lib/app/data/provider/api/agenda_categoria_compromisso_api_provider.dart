import 'dart:convert';
import 'package:agenda/app/data/provider/api/api_provider_base.dart';
import 'package:agenda/app/data/model/model_imports.dart';

class AgendaCategoriaCompromissoApiProvider extends ApiProviderBase {

	Future<List<AgendaCategoriaCompromissoModel>?> getList({Filter? filter}) async {
		List<AgendaCategoriaCompromissoModel> agendaCategoriaCompromissoModelList = [];

		try {
			handleFilter(filter, '/agenda-categoria-compromisso/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var agendaCategoriaCompromissoModelJson = json.decode(response.body) as List<dynamic>;
					for (var agendaCategoriaCompromissoModel in agendaCategoriaCompromissoModelJson) {
						agendaCategoriaCompromissoModelList.add(AgendaCategoriaCompromissoModel.fromJson(agendaCategoriaCompromissoModel));
					}
					return agendaCategoriaCompromissoModelList;
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

	Future<AgendaCategoriaCompromissoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/agenda-categoria-compromisso/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var agendaCategoriaCompromissoModelJson = json.decode(response.body);
					return AgendaCategoriaCompromissoModel.fromJson(agendaCategoriaCompromissoModelJson);		 
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

	Future<AgendaCategoriaCompromissoModel?>? insert(AgendaCategoriaCompromissoModel agendaCategoriaCompromissoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/agenda-categoria-compromisso')!,
				headers: ApiProviderBase.headerRequisition(),
				body: agendaCategoriaCompromissoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var agendaCategoriaCompromissoModelJson = json.decode(response.body);
					return AgendaCategoriaCompromissoModel.fromJson(agendaCategoriaCompromissoModelJson);
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

	Future<AgendaCategoriaCompromissoModel?>? update(AgendaCategoriaCompromissoModel agendaCategoriaCompromissoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/agenda-categoria-compromisso')!,
				headers: ApiProviderBase.headerRequisition(),
				body: agendaCategoriaCompromissoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var agendaCategoriaCompromissoModelJson = json.decode(response.body);
					return AgendaCategoriaCompromissoModel.fromJson(agendaCategoriaCompromissoModelJson);
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
				Uri.tryParse('$endpoint/agenda-categoria-compromisso/$pk')!,
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
