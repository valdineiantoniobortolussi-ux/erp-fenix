import 'package:drift/drift.dart';
import 'package:comissoes/app/data/provider/drift/database/database.dart';
import 'package:comissoes/app/data/provider/drift/database/database_imports.dart';

part 'comissao_objetivo_dao.g.dart';

@DriftAccessor(tables: [
	ComissaoObjetivos,
	ComissaoPerfils,
])
class ComissaoObjetivoDao extends DatabaseAccessor<AppDatabase> with _$ComissaoObjetivoDaoMixin {
	final AppDatabase db;

	List<ComissaoObjetivo> comissaoObjetivoList = []; 
	List<ComissaoObjetivoGrouped> comissaoObjetivoGroupedList = []; 

	ComissaoObjetivoDao(this.db) : super(db);

	Future<List<ComissaoObjetivo>> getList() async {
		comissaoObjetivoList = await select(comissaoObjetivos).get();
		return comissaoObjetivoList;
	}

	Future<List<ComissaoObjetivo>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		comissaoObjetivoList = await (select(comissaoObjetivos)..where((t) => expression)).get();
		return comissaoObjetivoList;	 
	}

	Future<List<ComissaoObjetivoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(comissaoObjetivos)
			.join([ 
				leftOuterJoin(comissaoPerfils, comissaoPerfils.id.equalsExp(comissaoObjetivos.idComissaoPerfil)), 
			]);

		if (field != null && field != '') { 
			final column = comissaoObjetivos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		comissaoObjetivoGroupedList = await query.map((row) {
			final comissaoObjetivo = row.readTableOrNull(comissaoObjetivos); 
			final comissaoPerfil = row.readTableOrNull(comissaoPerfils); 

			return ComissaoObjetivoGrouped(
				comissaoObjetivo: comissaoObjetivo, 
				comissaoPerfil: comissaoPerfil, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var comissaoObjetivoGrouped in comissaoObjetivoGroupedList) {
		//}		

		return comissaoObjetivoGroupedList;	
	}

	Future<ComissaoObjetivo?> getObject(dynamic pk) async {
		return await (select(comissaoObjetivos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ComissaoObjetivo?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM comissao_objetivo WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ComissaoObjetivo;		 
	} 

	Future<ComissaoObjetivoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ComissaoObjetivoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.comissaoObjetivo = object.comissaoObjetivo!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(comissaoObjetivos).insert(object.comissaoObjetivo!);
			object.comissaoObjetivo = object.comissaoObjetivo!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ComissaoObjetivoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(comissaoObjetivos).replace(object.comissaoObjetivo!);
		});	 
	} 

	Future<int> deleteObject(ComissaoObjetivoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(comissaoObjetivos).delete(object.comissaoObjetivo!);
		});		
	}

	Future<void> insertChildren(ComissaoObjetivoGrouped object) async {
	}
	
	Future<void> deleteChildren(ComissaoObjetivoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from comissao_objetivo").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}