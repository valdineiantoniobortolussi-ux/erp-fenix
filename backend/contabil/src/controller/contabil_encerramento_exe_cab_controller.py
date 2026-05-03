from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.contabil_encerramento_exe_cab_service import ContabilEncerramentoExeCabService

contabil_encerramento_exe_cab_bp = Blueprint('contabil-encerramento-exe-cab', __name__)
service = ContabilEncerramentoExeCabService()

@contabil_encerramento_exe_cab_bp.route('/contabil-encerramento-exe-cab', methods=['GET'])
@contabil_encerramento_exe_cab_bp.route('/contabil-encerramento-exe-cab/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@contabil_encerramento_exe_cab_bp.route('/contabil-encerramento-exe-cab/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@contabil_encerramento_exe_cab_bp.route('/contabil-encerramento-exe-cab', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@contabil_encerramento_exe_cab_bp.route('/contabil-encerramento-exe-cab', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@contabil_encerramento_exe_cab_bp.route('/contabil-encerramento-exe-cab/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})