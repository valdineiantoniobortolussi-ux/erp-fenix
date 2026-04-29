import 'dart:convert';
import 'package:agenda/app/data/provider/api/api_provider_base.dart';
import 'package:agenda/app/data/model/model_imports.dart';

class AgendaCompromissoApiProvider extends ApiProviderBase {

	Future<List<AgendaCompromissoModel>?> getList({Filter? filter}) async {
		List<AgendaCompromissoModel> agendaCompromissoModelList = [];

		try {
			handleFilter(filter, '/agenda-compromisso/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var agendaCompromissoModelJson = json.decode(response.body) as List<dynamic>;
					for (var agendaCompromissoModel in agendaCompromissoModelJson) {
						agendaCompromissoModelList.add(AgendaCompromissoModel.fromJson(agendaCompromissoModel));
					}
					return agendaCompromissoModelList;
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

	Future<AgendaCompromissoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/agenda-compromisso/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var agendaCompromissoModelJson = json.decode(response.body);
					return AgendaCompromissoModel.fromJson(agendaCompromissoModelJson);		 
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

	Future<AgendaCompromissoModel?>? insert(AgendaCompromissoModel agendaCompromissoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/agenda-compromisso')!,
				headers: ApiProviderBase.headerRequisition(),
				body: agendaCompromissoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var agendaCompromissoModelJson = json.decode(response.body);
					return AgendaCompromissoModel.fromJson(agendaCompromissoModelJson);
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

	Future<AgendaCompromissoModel?>? update(AgendaCompromissoModel agendaCompromissoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/agenda-compromisso')!,
				headers: ApiProviderBase.headerRequisition(),
				body: agendaCompromissoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var agendaCompromissoModelJson = json.decode(response.body);
					return AgendaCompromissoModel.fromJson(agendaCompromissoModelJson);
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
				Uri.tryParse('$endpoint/agenda-compromisso/$pk')!,
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
