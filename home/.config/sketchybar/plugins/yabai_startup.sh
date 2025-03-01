#!/bin/sh

wait_for_yabai() {
  local max_attempts=100
  local attempt=1
  
  while [ $attempt -le $max_attempts ]; do
    if yabai -m query --spaces >/dev/null 2>&1; then
      return 0
    fi
    
    echo "Waiting for yabai to start (attempt $attempt/$max_attempts)..."
    sleep 1
    attempt=$((attempt + 1))
  done
  
  echo "Failed to connect to yabai after $max_attempts attempts"
  return 1
}

if ! wait_for_yabai; then
  exit 1
fi