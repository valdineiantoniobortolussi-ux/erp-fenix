from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.mdfe_informacao_nfe_service import MdfeInformacaoNfeService

mdfe_informacao_nfe_bp = Blueprint('mdfe-informacao-nfe', __name__)
service = MdfeInformacaoNfeService()

@mdfe_informacao_nfe_bp.route('/mdfe-informacao-nfe', methods=['GET'])
@mdfe_informacao_nfe_bp.route('/mdfe-informacao-nfe/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@mdfe_informacao_nfe_bp.route('/mdfe-informacao-nfe/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@mdfe_informacao_nfe_bp.route('/mdfe-informacao-nfe', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@mdfe_informacao_nfe_bp.route('/mdfe-informacao-nfe', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@mdfe_informacao_nfe_bp.route('/mdfe-informacao-nfe/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})