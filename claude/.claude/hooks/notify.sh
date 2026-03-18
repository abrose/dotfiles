#!/bin/bash
EVENT_TYPE="${1:-stop}"
PROJECT=$(basename "$PWD")

if [ "$EVENT_TYPE" = "stop" ]; then
	TITLE="Claude Code — ${PROJECT}"
	MESSAGE="Task completed"
	SOUND="/System/Library/Sounds/Hero.aiff"
else
	TITLE="Claude Code — ${PROJECT}"
	MESSAGE="Waiting for input"
	SOUND="/System/Library/Sounds/Glass.aiff"
fi

afplay "$SOUND" &

terminal-notifier \
	-title "$TITLE" \
	-message "$MESSAGE" \
	-group "claude-code-${PROJECT}" &
TNPID=$!

sleep 1
kill "$TNPID" 2>/dev/null

exit 0
