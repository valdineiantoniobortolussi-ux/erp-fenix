from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.mdfe_rodoviario_ciot_service import MdfeRodoviarioCiotService

mdfe_rodoviario_ciot_bp = Blueprint('mdfe-rodoviario-ciot', __name__)
service = MdfeRodoviarioCiotService()

@mdfe_rodoviario_ciot_bp.route('/mdfe-rodoviario-ciot', methods=['GET'])
@mdfe_rodoviario_ciot_bp.route('/mdfe-rodoviario-ciot/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@mdfe_rodoviario_ciot_bp.route('/mdfe-rodoviario-ciot/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@mdfe_rodoviario_ciot_bp.route('/mdfe-rodoviario-ciot', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@mdfe_rodoviario_ciot_bp.route('/mdfe-rodoviario-ciot', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@mdfe_rodoviario_ciot_bp.route('/mdfe-rodoviario-ciot/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})