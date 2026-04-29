from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.esocial_motivo_desligamento_service import EsocialMotivoDesligamentoService

esocial_motivo_desligamento_bp = Blueprint('esocial-motivo-desligamento', __name__)
service = EsocialMotivoDesligamentoService()

@esocial_motivo_desligamento_bp.route('/esocial-motivo-desligamento', methods=['GET'])
@esocial_motivo_desligamento_bp.route('/esocial-motivo-desligamento/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@esocial_motivo_desligamento_bp.route('/esocial-motivo-desligamento/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@esocial_motivo_desligamento_bp.route('/esocial-motivo-desligamento', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@esocial_motivo_desligamento_bp.route('/esocial-motivo-desligamento', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@esocial_motivo_desligamento_bp.route('/esocial-motivo-desligamento/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})