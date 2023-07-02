extends Control

var count

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var score = 0 
var enemy_score = 0


signal _ready
signal start_ani


# 만들 적을 여기 넣습니다.
export var Enemy_K : PackedScene 
export var Enemy_M : PackedScene 
export var Enemy_W : PackedScene 

# 적을 배치할 시작점을 정합니다. 
export var CreateBeginPositionX = 590

# 적 생성 숫자
export var CreateEnemyCount = 3

# 적 사이 거리
export var CreateEnemyXGap = -120

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	if NiKE.Retry == true :
		pass
		NiKE.Retry = false
	
	else :
		NiKE.stage += 1

	if NiKE.Clear_count == 1 :
		NiKE.stage = 1
		NiKE.Clear_count = 2

		
	for i in range(CreateEnemyCount): # CreateEnemyCount만큼 반복!
			var rate = rand_range(1.0, 100.0)
			var inst_enemy = []
			if rate <= 40 :
				inst_enemy = Enemy_K.instance()  # 공장에서 찍어냄
			if rate > 40 and rate <= 70 :
				inst_enemy = Enemy_M.instance()  # 공장에서 찍어냄
			if rate > 70 :
				inst_enemy = Enemy_W.instance()  # 공장에서 찍어냄

			add_child(inst_enemy) # Node2D의 자식으로 추가!
			inst_enemy.position = Vector2(
				CreateBeginPositionX + (CreateEnemyXGap * i),
				460 )




	
		
	NiKE.Bettel_end = false
	
#	if NiKE.stage == 5 :	
#		$enemy.position = NiKE.enemy_5_position 
#	else :
#		$enemy.position = NiKE.enemy_position

	$player.position = NiKE.player_position
	$Line.position = NiKE.Line_position
#	$enemy2.position = NiKE.enemy2_position
	
	emit_signal("_ready")
	
	
	 
func _process(_delta):
	pass
	#count += delta
	
	#if count == 3 :
		#count
		#$Button.StartTimer.start()
		#$Button.StartTimer.AnimatedSprite.playing = true
		
		
#	$PlayerLabel.text = "Button : " + str(score) 
#	$PlayerLabel2.text = "player_C_ark : " + str(NiKE.player_C_ark) 
#	$PlayerLabel3.text = "player_S_ark : " + str(NiKE.player_S_ark) 
#
#	$EnemyLabel.text = "Button : " + str(enemy_score)
#	$EnemyLabel2.text = "get_enemy_atk : " + str(NiKE.get_enemy_atk())
#
#	$StageLabel.text = "Stage : " + str(NiKE.stage)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Button_pressed():
	if NiKE.Bettel_end == false :
		score += 1 
		#보통은 객체(인스턴트)대상으로 콜함 
		#씬(클래스) 호출 방법은 다른 방식이여야만 함 
		get_tree().call_group("EAL","_player_C_ark")
		get_tree().call_group("PAL","_player_C_ark")
		

func _on_Timer2_timeout():
	if NiKE.Bettel_end == false :
		get_tree().call_group("EAL","_enemy_C_ark")
		get_tree().call_group("PAL","_enemy_C_ark")



func _on_Timer_timeout():
	if NiKE.Bettel_end == false :
		
		print("초당버튼은 작용하는가.")
		enemy_score += 1
		print(NiKE.player_S_ark)
		get_tree().call_group("EAL","_player_S_ark")
		get_tree().call_group("PAL","_player_S_ark")
		
		get_tree().call_group("EAL","_enemy_S_ark")
		get_tree().call_group("PAL","_enemy_S_ark")


func _on_AnimatedSprite_animation_finished():
	$Timer.start()
	get_tree().call_group("enemy","_on_Control_start_ani")
	get_tree().call_group("player","_on_Control_start_ani")
	$AnimatedSprite.animation = "start"




