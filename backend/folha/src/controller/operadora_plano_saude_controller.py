from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.operadora_plano_saude_service import OperadoraPlanoSaudeService

operadora_plano_saude_bp = Blueprint('operadora-plano-saude', __name__)
service = OperadoraPlanoSaudeService()

@operadora_plano_saude_bp.route('/operadora-plano-saude', methods=['GET'])
@operadora_plano_saude_bp.route('/operadora-plano-saude/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@operadora_plano_saude_bp.route('/operadora-plano-saude/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@operadora_plano_saude_bp.route('/operadora-plano-saude', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@operadora_plano_saude_bp.route('/operadora-plano-saude', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@operadora_plano_saude_bp.route('/operadora-plano-saude/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})