from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.mdfe_rodoviario_motorista_service import MdfeRodoviarioMotoristaService

mdfe_rodoviario_motorista_bp = Blueprint('mdfe-rodoviario-motorista', __name__)
service = MdfeRodoviarioMotoristaService()

@mdfe_rodoviario_motorista_bp.route('/mdfe-rodoviario-motorista', methods=['GET'])
@mdfe_rodoviario_motorista_bp.route('/mdfe-rodoviario-motorista/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@mdfe_rodoviario_motorista_bp.route('/mdfe-rodoviario-motorista/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@mdfe_rodoviario_motorista_bp.route('/mdfe-rodoviario-motorista', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@mdfe_rodoviario_motorista_bp.route('/mdfe-rodoviario-motorista', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@mdfe_rodoviario_motorista_bp.route('/mdfe-rodoviario-motorista/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})