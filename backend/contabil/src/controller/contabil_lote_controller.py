from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.contabil_lote_service import ContabilLoteService

contabil_lote_bp = Blueprint('contabil-lote', __name__)
service = ContabilLoteService()

@contabil_lote_bp.route('/contabil-lote', methods=['GET'])
@contabil_lote_bp.route('/contabil-lote/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@contabil_lote_bp.route('/contabil-lote/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@contabil_lote_bp.route('/contabil-lote', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@contabil_lote_bp.route('/contabil-lote', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@contabil_lote_bp.route('/contabil-lote/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})