#!/usr/bin/env bash
# vim:foldmethod=marker

# Pause & Play {{{

pause() {
  printf '%s\n' '{ "command": ["set_property", "pause", true] }' | \
    socat - "$socket" > /dev/null
}

play() {
  printf '%s\n' '{ "command": ["set_property", "pause", false] }' | \
  socat - "$socket" > /dev/null
}
# }}}

# Process {{{

# Cleanup on exit
cleanup() {
  # Play the video if the daemon is killed
  play
}

trap cleanup EXIT
# }}}

# Player Status {{{

player_status() {
  local last_status
  
  # Pause video on focus
  if [[ "$pause_player" != "$last_status" ]]; then
    if [[ "$pause_player" = "yes" ]]; then
      pause
    else
      play
    fi

    # Save last status
    last_status="$pause_player"
  fi
}
# }}}

# Window Monitor {{{

window_monitor() {
  local window_id

  # Detect if a window is open
  while IFS= read -r window_id; do
    if [[ "$window_id" == "_NET_ACTIVE_WINDOW(WINDOW): window id # 0x0" ]]; then
      pause_player="no" 
    else
      pause_player="yes"
    fi

    # Set status
    player_status

  done < <(xprop -spy -root _NET_ACTIVE_WINDOW)
}
# }}}

window_monitor
