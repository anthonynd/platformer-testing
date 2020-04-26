extends KinematicBody2D

export (int) var jump_speed = -1000
export (int) var ground_speed = 4000

const MAX_GROUND_SPEED = 500
const MAX_AIR_SPEED = 500
const JUMP_FRAMES = 3
const MAX_FALL_SPEED = 500
const GRAVITY = 3000

var velocity = Vector2()
var jump_timer = 0

func _physics_process(delta):
    var x_deceleration
    if is_on_floor():
        x_deceleration = 2400
    else:
        x_deceleration = 1200
    
    if velocity.x > 0:
        velocity.x -= x_deceleration * delta
        if velocity.x < 0:
            velocity.x = 0
    elif velocity.x < 0:
        velocity.x += x_deceleration * delta
        if velocity.x > 0:
            velocity.x = 0

    velocity.y += GRAVITY * delta

    var snap = Vector2.DOWN * 20

    if Input.is_action_pressed("left"):
        velocity.x -= ground_speed * delta
    if Input.is_action_pressed("right"):
        velocity.x += ground_speed * delta
    if Input.is_action_just_pressed("jump") and is_on_floor():
        jump_timer = JUMP_FRAMES
#        $JumpFire.visible = true
#        $JumpFire.play()
        
#    if $JumpFire.frame == 8:
#        $JumpFire.visible = false
#        $JumpFire.stop()
#        $JumpFire.frame = 0

    if jump_timer >= 0:
        jump_timer -= 1

    if jump_timer == 0:
        snap = Vector2.ZERO
        velocity.y = jump_speed
    
    velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP, true)
    
    if is_on_floor():
        velocity.x = clamp(velocity.x, -MAX_GROUND_SPEED, MAX_GROUND_SPEED)
    else:
        velocity.x = clamp(velocity.x, -MAX_AIR_SPEED, MAX_AIR_SPEED)
#    velocity.y = clamp(velocity.y, -999999, MAX_FALL_SPEED)
    
    print(velocity)
