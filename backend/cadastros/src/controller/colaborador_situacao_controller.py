from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.colaborador_situacao_service import ColaboradorSituacaoService

colaborador_situacao_bp = Blueprint('colaborador-situacao', __name__)
service = ColaboradorSituacaoService()

@colaborador_situacao_bp.route('/colaborador-situacao', methods=['GET'])
@colaborador_situacao_bp.route('/colaborador-situacao/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@colaborador_situacao_bp.route('/colaborador-situacao/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@colaborador_situacao_bp.route('/colaborador-situacao', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@colaborador_situacao_bp.route('/colaborador-situacao', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@colaborador_situacao_bp.route('/colaborador-situacao/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})