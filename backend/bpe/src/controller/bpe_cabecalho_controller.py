from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.bpe_cabecalho_service import BpeCabecalhoService

bpe_cabecalho_bp = Blueprint('bpe-cabecalho', __name__)
service = BpeCabecalhoService()

@bpe_cabecalho_bp.route('/bpe-cabecalho', methods=['GET'])
@bpe_cabecalho_bp.route('/bpe-cabecalho/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@bpe_cabecalho_bp.route('/bpe-cabecalho/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@bpe_cabecalho_bp.route('/bpe-cabecalho', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@bpe_cabecalho_bp.route('/bpe-cabecalho', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@bpe_cabecalho_bp.route('/bpe-cabecalho/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})