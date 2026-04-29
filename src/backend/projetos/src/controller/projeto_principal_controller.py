from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.projeto_principal_service import ProjetoPrincipalService

projeto_principal_bp = Blueprint('projeto-principal', __name__)
service = ProjetoPrincipalService()

@projeto_principal_bp.route('/projeto-principal', methods=['GET'])
@projeto_principal_bp.route('/projeto-principal/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@projeto_principal_bp.route('/projeto-principal/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@projeto_principal_bp.route('/projeto-principal', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@projeto_principal_bp.route('/projeto-principal', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@projeto_principal_bp.route('/projeto-principal/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})