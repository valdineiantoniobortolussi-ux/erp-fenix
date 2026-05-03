from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.tribut_grupo_tributario_service import TributGrupoTributarioService

tribut_grupo_tributario_bp = Blueprint('tribut-grupo-tributario', __name__)
service = TributGrupoTributarioService()

@tribut_grupo_tributario_bp.route('/tribut-grupo-tributario', methods=['GET'])
@tribut_grupo_tributario_bp.route('/tribut-grupo-tributario/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@tribut_grupo_tributario_bp.route('/tribut-grupo-tributario/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@tribut_grupo_tributario_bp.route('/tribut-grupo-tributario', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@tribut_grupo_tributario_bp.route('/tribut-grupo-tributario', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@tribut_grupo_tributario_bp.route('/tribut-grupo-tributario/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})