function player_mouse_angle()
  return math.atan2(player.y - camera:getY() , player.x - camera:getX()) + math.pi
end
