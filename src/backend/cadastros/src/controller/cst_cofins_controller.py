from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.cst_cofins_service import CstCofinsService

cst_cofins_bp = Blueprint('cst-cofins', __name__)
service = CstCofinsService()

@cst_cofins_bp.route('/cst-cofins', methods=['GET'])
@cst_cofins_bp.route('/cst-cofins/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@cst_cofins_bp.route('/cst-cofins/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@cst_cofins_bp.route('/cst-cofins', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@cst_cofins_bp.route('/cst-cofins', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@cst_cofins_bp.route('/cst-cofins/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})