extends NinePatchRect # Certifique-se que o script está no nó "Interface"

@onready var progress_bar: ProgressBar = $NinePatchRect/MarginContainer/VBoxContainer/MeuProgressBar
@onready var botao: Button = $NinePatchRect/MarginContainer/VBoxContainer/BotaoAnimar

var meu_tween: Tween

func _ready() -> void:
	# 1. Configura o estado inicial (Requisito da atividade)
	progress_bar.value = 0
	
	# 2. Conecta o botão via código (Garante o disparo da animação)
	botao.pressed.connect(_ao_pressionar_botao)

func _ao_pressionar_botao() -> void:
	# Reinicia se estiver cheio para testar de novo
	if progress_bar.value >= 100:
		progress_bar.value = 0
	
	animar_barra()

func animar_barra() -> void:
	if meu_tween:
		meu_tween.kill() # Limpa animações anteriores para não bugar
	
	meu_tween = create_tween()
	
	# REQUISITOS TÉCNICOS DO CHECKLIST:
	# tween_property: anima o 'value'
	# set_trans: TRANS_BOUNCE (o efeito de ricochete/quique)
	# set_ease: EASE_OUT (suaviza a chegada no 100)
	meu_tween.tween_property(progress_bar, "value", 100, 1.5)\
		.set_trans(Tween.TRANS_BOUNCE)\
		.set_ease(Tween.EASE_OUT)
