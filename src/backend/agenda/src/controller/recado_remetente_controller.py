from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.recado_remetente_service import RecadoRemetenteService

recado_remetente_bp = Blueprint('recado-remetente', __name__)
service = RecadoRemetenteService()

@recado_remetente_bp.route('/recado-remetente', methods=['GET'])
@recado_remetente_bp.route('/recado-remetente/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@recado_remetente_bp.route('/recado-remetente/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@recado_remetente_bp.route('/recado-remetente', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@recado_remetente_bp.route('/recado-remetente', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@recado_remetente_bp.route('/recado-remetente/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})