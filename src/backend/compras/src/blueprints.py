from src.controller.login_controller import login_bp
from src.controller.compra_requisicao_controller import compra_requisicao_bp
from src.controller.compra_cotacao_controller import compra_cotacao_bp
from src.controller.compra_pedido_controller import compra_pedido_bp
from src.controller.produto_grupo_controller import produto_grupo_bp
from src.controller.produto_subgrupo_controller import produto_subgrupo_bp
from src.controller.produto_marca_controller import produto_marca_bp
from src.controller.produto_unidade_controller import produto_unidade_bp
from src.controller.tribut_icms_custom_cab_controller import tribut_icms_custom_cab_bp
from src.controller.tribut_grupo_tributario_controller import tribut_grupo_tributario_bp
from src.controller.produto_controller import produto_bp
from src.controller.compra_tipo_requisicao_controller import compra_tipo_requisicao_bp
from src.controller.compra_tipo_pedido_controller import compra_tipo_pedido_bp
from src.controller.view_controle_acesso_controller import view_controle_acesso_bp
from src.controller.view_pessoa_usuario_controller import view_pessoa_usuario_bp
from src.controller.view_pessoa_fornecedor_controller import view_pessoa_fornecedor_bp
from src.controller.view_pessoa_colaborador_controller import view_pessoa_colaborador_bp

# Register the blueprints with the Flask application
def register_blueprints(app):
		app.register_blueprint(compra_requisicao_bp)
		app.register_blueprint(compra_cotacao_bp)
		app.register_blueprint(compra_pedido_bp)
		app.register_blueprint(produto_grupo_bp)
		app.register_blueprint(produto_subgrupo_bp)
		app.register_blueprint(produto_marca_bp)
		app.register_blueprint(produto_unidade_bp)
		app.register_blueprint(tribut_icms_custom_cab_bp)
		app.register_blueprint(tribut_grupo_tributario_bp)
		app.register_blueprint(produto_bp)
		app.register_blueprint(compra_tipo_requisicao_bp)
		app.register_blueprint(compra_tipo_pedido_bp)
		app.register_blueprint(view_controle_acesso_bp)
		app.register_blueprint(view_pessoa_usuario_bp)
		app.register_blueprint(view_pessoa_fornecedor_bp)
		app.register_blueprint(view_pessoa_colaborador_bp)
		app.register_blueprint(login_bp)