from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.cte_informacao_nf_carga_service import CteInformacaoNfCargaService

cte_informacao_nf_carga_bp = Blueprint('cte-informacao-nf-carga', __name__)
service = CteInformacaoNfCargaService()

@cte_informacao_nf_carga_bp.route('/cte-informacao-nf-carga', methods=['GET'])
@cte_informacao_nf_carga_bp.route('/cte-informacao-nf-carga/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@cte_informacao_nf_carga_bp.route('/cte-informacao-nf-carga/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@cte_informacao_nf_carga_bp.route('/cte-informacao-nf-carga', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@cte_informacao_nf_carga_bp.route('/cte-informacao-nf-carga', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@cte_informacao_nf_carga_bp.route('/cte-informacao-nf-carga/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})