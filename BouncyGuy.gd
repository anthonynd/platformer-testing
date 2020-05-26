extends KinematicBody2D

export (int) var jump_speed = 2000
#export (int) var ground_speed = 450
export (int) var ground_acceleration = 2000
export (int) var friction = 1500
export (int) var air_friction = 500

#const MAX_GROUND_SPEED = 500
#const MAX_AIR_SPEED = 500
#const JUMP_FRAMES = 3
#const MAX_FALL_SPEED = 500
const X_MAX_SPEED := 700
const Y_MAX_SPEED := 700
const GRAVITY := 2000

var net_acceleration := Vector2()
var velocity := Vector2()
var surface_normal: Vector2
var snap: Vector2
#var jump_timer = 0

func _draw():
#    pass
#    draw_line(Vector2.ZERO, net_normal * 100, Color.green, 2)
    draw_line(Vector2.ZERO, surface_normal * 100, Color.green, 2)
#    draw_line(Vector2.ZERO, snap, Color.yellow, 5)
    draw_line(Vector2.ZERO, net_acceleration.normalized() * 100, Color.red, 5)

func get_surface_normal() -> Vector2:
    var normal := Vector2.ZERO
    for i in range(0, get_slide_count()):
        normal += get_slide_collision(i).normal
    normal = normal.normalized()
    return normal

func _physics_process(delta: float):
#    net_acceleration = Vector2(0, GRAVITY * 0.9)
#    net_acceleration = Vector2(GRAVITY * -0.9, 0)

    if Input.is_action_pressed("left"):
        net_acceleration.x = -ground_acceleration
    if Input.is_action_pressed("right"):
        net_acceleration.x = ground_acceleration
    
    surface_normal = get_surface_normal()
    var is_touching_surface := surface_normal != Vector2.ZERO
    snap = -surface_normal * 60
    update()
    
    # Acceleration modifiers
    if is_touching_surface:
        net_acceleration += -velocity.normalized() * friction
        
        # Gravity control
        net_acceleration.y = 0
        net_acceleration += -surface_normal * GRAVITY
    else:
#        print(" ")
        net_acceleration += -velocity.normalized() * air_friction
        net_acceleration.y = GRAVITY * 0.9
    
    if Input.is_action_just_pressed("jump"):
        snap = Vector2.ZERO
        velocity += surface_normal * jump_speed

    update()

    var new_velocity = velocity + (net_acceleration * delta)
    
    # Prevent velocity jitter
    if (velocity.x > 0 and new_velocity.x < 0) or (velocity.x < 0 and new_velocity.x > 0):
        new_velocity.x = 0
    
    velocity = new_velocity
    
    var floor_normal := get_floor_normal()
    var up_dir := Vector2.UP
    if floor_normal.angle() < PI and floor_normal.angle() > 0:
        up_dir = Vector2.DOWN
    
    velocity = move_and_slide_with_snap(velocity, snap, up_dir, true, 4, PI)
    
    velocity.x = clamp(velocity.x, -X_MAX_SPEED, X_MAX_SPEED)
    velocity.y = clamp(velocity.y, -Y_MAX_SPEED, Y_MAX_SPEED)
