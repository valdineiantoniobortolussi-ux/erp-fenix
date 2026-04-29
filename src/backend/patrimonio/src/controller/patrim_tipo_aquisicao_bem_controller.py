from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.patrim_tipo_aquisicao_bem_service import PatrimTipoAquisicaoBemService

patrim_tipo_aquisicao_bem_bp = Blueprint('patrim-tipo-aquisicao-bem', __name__)
service = PatrimTipoAquisicaoBemService()

@patrim_tipo_aquisicao_bem_bp.route('/patrim-tipo-aquisicao-bem', methods=['GET'])
@patrim_tipo_aquisicao_bem_bp.route('/patrim-tipo-aquisicao-bem/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@patrim_tipo_aquisicao_bem_bp.route('/patrim-tipo-aquisicao-bem/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@patrim_tipo_aquisicao_bem_bp.route('/patrim-tipo-aquisicao-bem', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@patrim_tipo_aquisicao_bem_bp.route('/patrim-tipo-aquisicao-bem', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@patrim_tipo_aquisicao_bem_bp.route('/patrim-tipo-aquisicao-bem/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})