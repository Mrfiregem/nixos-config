const self = path self

# A collection of tools to help during YuGiOh! games.
export def main [] {
  let name = $self | path basename
  print $"Calling ($name) directly does nothing. Use one of the following subcommands:\n"

  ^$nu.current-exe --no-config-file --commands $'use ($self)
    scope commands | where name starts-with "ygo " | to nuon'
  | from nuon
  | format pattern $' - (ansi cyan_bold){name}(ansi reset): (ansi attr_dimmed){description}(ansi attr_normal)'
  | to text
}

# Determine which cards to send to the graveyard for Simultaneous Equation Cannons
export def simul [
  total_cards: int # The total number of cards in both hands and on field.
  monster_level: int # The level of one of your opponent's monsters.
]: nothing -> oneof<record<xyz_ranks: int, fusion_level: int>, nothing> {
  let xyz = $total_cards - $monster_level
  let fus = $total_cards - 2 * $xyz

  if ($xyz >= 1 and $xyz <= 13) and ($fus >= 1 and $fus <= 12) {
    {xyz_ranks: $xyz, fusion_level: $fus}
  }
}

# Determine which cards to send to the graveyard for Simultaneous Equation Cannons
def "main simul" [
  total_cards: int # The total number of cards in both hands and on field.
  monster_level: int # The level of one of your opponent's monsters.
]: nothing -> string {
  match (simul $total_cards $monster_level) {
    null => $'Simultaneous Equation Cannon cannot be used when there are ($total_cards) cards targeting a level/rank ($monster_level) monster.'
    $send => { $send | format pattern 'Send two rank {xyz_ranks} XYZ and a level {fusion_level} fusion to the GY.' }
  }
}
