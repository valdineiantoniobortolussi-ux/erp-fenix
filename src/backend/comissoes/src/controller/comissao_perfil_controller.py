from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.comissao_perfil_service import ComissaoPerfilService

comissao_perfil_bp = Blueprint('comissao-perfil', __name__)
service = ComissaoPerfilService()

@comissao_perfil_bp.route('/comissao-perfil', methods=['GET'])
@comissao_perfil_bp.route('/comissao-perfil/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@comissao_perfil_bp.route('/comissao-perfil/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@comissao_perfil_bp.route('/comissao-perfil', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@comissao_perfil_bp.route('/comissao-perfil', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@comissao_perfil_bp.route('/comissao-perfil/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})