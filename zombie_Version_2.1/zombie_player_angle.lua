
function zombie_player_angle(enemy)
  return math.atan2(player.y - enemy.y, player.x - enemy.x)
end
