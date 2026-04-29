from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.contrato_template_service import ContratoTemplateService

contrato_template_bp = Blueprint('contrato-template', __name__)
service = ContratoTemplateService()

@contrato_template_bp.route('/contrato-template', methods=['GET'])
@contrato_template_bp.route('/contrato-template/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@contrato_template_bp.route('/contrato-template/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@contrato_template_bp.route('/contrato-template', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@contrato_template_bp.route('/contrato-template', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@contrato_template_bp.route('/contrato-template/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})