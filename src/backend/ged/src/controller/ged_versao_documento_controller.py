from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.ged_versao_documento_service import GedVersaoDocumentoService

ged_versao_documento_bp = Blueprint('ged-versao-documento', __name__)
service = GedVersaoDocumentoService()

@ged_versao_documento_bp.route('/ged-versao-documento', methods=['GET'])
@ged_versao_documento_bp.route('/ged-versao-documento/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@ged_versao_documento_bp.route('/ged-versao-documento/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@ged_versao_documento_bp.route('/ged-versao-documento', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@ged_versao_documento_bp.route('/ged-versao-documento', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@ged_versao_documento_bp.route('/ged-versao-documento/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})