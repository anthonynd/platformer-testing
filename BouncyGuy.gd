extends RigidBody2D

#export (int) var jump_speed = -1250
#export (int) var ground_speed = 450

#const MAX_GROUND_SPEED = 500
#const MAX_AIR_SPEED = 500
#const JUMP_FRAMES = 3
#const MAX_FALL_SPEED = 500
#const GRAVITY = 2000

#var velocity = Vector2()
#var jump_timer = 0
    
func _integrate_forces(state):
    pass

func _physics_process(delta):
#    var x_deceleration
#    if is_on_floor():
#        x_deceleration = 2400
#    else:
#        x_deceleration = 1200
    
#    if velocity.x > 0:
#        velocity.x -= x_deceleration * delta
#        if velocity.x < 0:
#            velocity.x = 0
#    elif velocity.x < 0:
#        velocity.x += x_deceleration * delta
#        if velocity.x > 0:
#            velocity.x = 0

#    velocity.y += GRAVITY * delta

#    var snap = Vector2.DOWN * 20
    
#    velocity.x = 0
    if Input.is_action_pressed("left"):
        apply_central_impulse((Vector2.LEFT * 15))
#        velocity.x = -ground_speed
    if Input.is_action_pressed("right"):
        apply_central_impulse((Vector2.RIGHT * 15))
#        velocity.x = +ground_speed
        
    if Input.is_action_just_pressed("jump"):
        pass
#        jump_timer = JUMP_FRAMES
#        $JumpFire.visible = true
#        $JumpFire.play()
        
#    if $JumpFire.frame == 8:
#        $JumpFire.visible = false
#        $JumpFire.stop()
#        $JumpFire.frame = 0

#    if jump_timer >= 0:
#        jump_timer -= 1
#
#    if jump_timer == 0:
##        snap = Vector2.ZERO
#        velocity.y = jump_speed
    
#    velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP)
#    velocity = move_and_slide(velocity, Vector2.UP, false, 4, 0, false)
    
#    if is_on_floor():
#        velocity.x = clamp(velocity.x, -MAX_GROUND_SPEED, MAX_GROUND_SPEED)
#    else:
#        velocity.x = clamp(velocity.x, -MAX_AIR_SPEED, MAX_AIR_SPEED)
#    velocity.y = clamp(velocity.y, -999999, 1000)
    
#    print(velocity)
