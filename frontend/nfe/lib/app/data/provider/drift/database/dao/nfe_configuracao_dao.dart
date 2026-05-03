import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'nfe_configuracao_dao.g.dart';

@DriftAccessor(tables: [
	NfeConfiguracaos,
])
class NfeConfiguracaoDao extends DatabaseAccessor<AppDatabase> with _$NfeConfiguracaoDaoMixin {
	final AppDatabase db;

	List<NfeConfiguracao> nfeConfiguracaoList = []; 
	List<NfeConfiguracaoGrouped> nfeConfiguracaoGroupedList = []; 

	NfeConfiguracaoDao(this.db) : super(db);

	Future<List<NfeConfiguracao>> getList() async {
		nfeConfiguracaoList = await select(nfeConfiguracaos).get();
		return nfeConfiguracaoList;
	}

	Future<List<NfeConfiguracao>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		nfeConfiguracaoList = await (select(nfeConfiguracaos)..where((t) => expression)).get();
		return nfeConfiguracaoList;	 
	}

	Future<List<NfeConfiguracaoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(nfeConfiguracaos)
			.join([]);

		if (field != null && field != '') { 
			final column = nfeConfiguracaos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		nfeConfiguracaoGroupedList = await query.map((row) {
			final nfeConfiguracao = row.readTableOrNull(nfeConfiguracaos); 

			return NfeConfiguracaoGrouped(
				nfeConfiguracao: nfeConfiguracao, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var nfeConfiguracaoGrouped in nfeConfiguracaoGroupedList) {
		//}		

		return nfeConfiguracaoGroupedList;	
	}

	Future<NfeConfiguracao?> getObject(dynamic pk) async {
		return await (select(nfeConfiguracaos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<NfeConfiguracao?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM nfe_configuracao WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as NfeConfiguracao;		 
	} 

	Future<NfeConfiguracaoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(NfeConfiguracaoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.nfeConfiguracao = object.nfeConfiguracao!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(nfeConfiguracaos).insert(object.nfeConfiguracao!);
			object.nfeConfiguracao = object.nfeConfiguracao!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(NfeConfiguracaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(nfeConfiguracaos).replace(object.nfeConfiguracao!);
		});	 
	} 

	Future<int> deleteObject(NfeConfiguracaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(nfeConfiguracaos).delete(object.nfeConfiguracao!);
		});		
	}

	Future<void> insertChildren(NfeConfiguracaoGrouped object) async {
	}
	
	Future<void> deleteChildren(NfeConfiguracaoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from nfe_configuracao").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}