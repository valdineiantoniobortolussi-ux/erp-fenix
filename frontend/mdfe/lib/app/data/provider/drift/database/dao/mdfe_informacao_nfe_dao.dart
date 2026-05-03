import 'package:drift/drift.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';
import 'package:mdfe/app/data/provider/drift/database/database_imports.dart';

part 'mdfe_informacao_nfe_dao.g.dart';

@DriftAccessor(tables: [
	MdfeInformacaoNfes,
	MdfeMunicipioDescarregas,
])
class MdfeInformacaoNfeDao extends DatabaseAccessor<AppDatabase> with _$MdfeInformacaoNfeDaoMixin {
	final AppDatabase db;

	List<MdfeInformacaoNfe> mdfeInformacaoNfeList = []; 
	List<MdfeInformacaoNfeGrouped> mdfeInformacaoNfeGroupedList = []; 

	MdfeInformacaoNfeDao(this.db) : super(db);

	Future<List<MdfeInformacaoNfe>> getList() async {
		mdfeInformacaoNfeList = await select(mdfeInformacaoNfes).get();
		return mdfeInformacaoNfeList;
	}

	Future<List<MdfeInformacaoNfe>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		mdfeInformacaoNfeList = await (select(mdfeInformacaoNfes)..where((t) => expression)).get();
		return mdfeInformacaoNfeList;	 
	}

	Future<List<MdfeInformacaoNfeGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(mdfeInformacaoNfes)
			.join([ 
				leftOuterJoin(mdfeMunicipioDescarregas, mdfeMunicipioDescarregas.id.equalsExp(mdfeInformacaoNfes.idMdfeMunicipioDescarrega)), 
			]);

		if (field != null && field != '') { 
			final column = mdfeInformacaoNfes.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		mdfeInformacaoNfeGroupedList = await query.map((row) {
			final mdfeInformacaoNfe = row.readTableOrNull(mdfeInformacaoNfes); 
			final mdfeMunicipioDescarrega = row.readTableOrNull(mdfeMunicipioDescarregas); 

			return MdfeInformacaoNfeGrouped(
				mdfeInformacaoNfe: mdfeInformacaoNfe, 
				mdfeMunicipioDescarrega: mdfeMunicipioDescarrega, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var mdfeInformacaoNfeGrouped in mdfeInformacaoNfeGroupedList) {
		//}		

		return mdfeInformacaoNfeGroupedList;	
	}

	Future<MdfeInformacaoNfe?> getObject(dynamic pk) async {
		return await (select(mdfeInformacaoNfes)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<MdfeInformacaoNfe?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM mdfe_informacao_nfe WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as MdfeInformacaoNfe;		 
	} 

	Future<MdfeInformacaoNfeGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(MdfeInformacaoNfeGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.mdfeInformacaoNfe = object.mdfeInformacaoNfe!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(mdfeInformacaoNfes).insert(object.mdfeInformacaoNfe!);
			object.mdfeInformacaoNfe = object.mdfeInformacaoNfe!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(MdfeInformacaoNfeGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(mdfeInformacaoNfes).replace(object.mdfeInformacaoNfe!);
		});	 
	} 

	Future<int> deleteObject(MdfeInformacaoNfeGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(mdfeInformacaoNfes).delete(object.mdfeInformacaoNfe!);
		});		
	}

	Future<void> insertChildren(MdfeInformacaoNfeGrouped object) async {
	}
	
	Future<void> deleteChildren(MdfeInformacaoNfeGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from mdfe_informacao_nfe").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}