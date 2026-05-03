from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.nfe_cana_deducoes_safra_service import NfeCanaDeducoesSafraService

nfe_cana_deducoes_safra_bp = Blueprint('nfe-cana-deducoes-safra', __name__)
service = NfeCanaDeducoesSafraService()

@nfe_cana_deducoes_safra_bp.route('/nfe-cana-deducoes-safra', methods=['GET'])
@nfe_cana_deducoes_safra_bp.route('/nfe-cana-deducoes-safra/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@nfe_cana_deducoes_safra_bp.route('/nfe-cana-deducoes-safra/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@nfe_cana_deducoes_safra_bp.route('/nfe-cana-deducoes-safra', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@nfe_cana_deducoes_safra_bp.route('/nfe-cana-deducoes-safra', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@nfe_cana_deducoes_safra_bp.route('/nfe-cana-deducoes-safra/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})