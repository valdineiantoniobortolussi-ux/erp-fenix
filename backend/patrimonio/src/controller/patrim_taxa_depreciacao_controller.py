from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.patrim_taxa_depreciacao_service import PatrimTaxaDepreciacaoService

patrim_taxa_depreciacao_bp = Blueprint('patrim-taxa-depreciacao', __name__)
service = PatrimTaxaDepreciacaoService()

@patrim_taxa_depreciacao_bp.route('/patrim-taxa-depreciacao', methods=['GET'])
@patrim_taxa_depreciacao_bp.route('/patrim-taxa-depreciacao/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@patrim_taxa_depreciacao_bp.route('/patrim-taxa-depreciacao/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@patrim_taxa_depreciacao_bp.route('/patrim-taxa-depreciacao', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@patrim_taxa_depreciacao_bp.route('/patrim-taxa-depreciacao', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@patrim_taxa_depreciacao_bp.route('/patrim-taxa-depreciacao/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})