from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.patrim_estado_conservacao_service import PatrimEstadoConservacaoService

patrim_estado_conservacao_bp = Blueprint('patrim-estado-conservacao', __name__)
service = PatrimEstadoConservacaoService()

@patrim_estado_conservacao_bp.route('/patrim-estado-conservacao', methods=['GET'])
@patrim_estado_conservacao_bp.route('/patrim-estado-conservacao/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@patrim_estado_conservacao_bp.route('/patrim-estado-conservacao/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@patrim_estado_conservacao_bp.route('/patrim-estado-conservacao', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@patrim_estado_conservacao_bp.route('/patrim-estado-conservacao', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@patrim_estado_conservacao_bp.route('/patrim-estado-conservacao/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})