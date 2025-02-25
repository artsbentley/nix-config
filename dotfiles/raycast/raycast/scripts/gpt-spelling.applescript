#!/usr/bin/osascript
# @raycast.schemaVersion 1
# @raycast.title Spelling check
# @raycast.mode silent
#
# @raycast.packageName Text Tools
# @raycast.icon 🖊️
#
# @raycast.description Improves highlighted text using AI for spelling and grammar correction.
# @raycast.author Your Name
# @raycast.authorURL https://yourwebsite.com

set originalClipboard to the clipboard as text

tell application "System Events"
	keystroke "c" using {command down}
end tell

delay 0.5
set selectedText to the clipboard as text

if selectedText is "" then
	display alert "No text selected."
	return
end if

try
	-- Save selected text to a temporary file to avoid escaping issues
	set tmpFile to "/tmp/raycast_text_input.txt"
	do shell script "echo " & quoted form of selectedText & " > " & quoted form of tmpFile
	
	-- Call the script with the file as input to avoid command line escaping issues
	set improvedText to do shell script "/Users/arar/.config/scripts/gpt-spelling.sh --file " & quoted form of tmpFile
	
	if improvedText is "" or improvedText contains "I'm sorry" then
		display alert "Error: Empty or error response received."
		set the clipboard to originalClipboard
	else
		set the clipboard to improvedText
		tell application "System Events"
			keystroke "v" using {command down}
		end tell
	end if
on error errMsg
	display alert "Error: " & errMsg
	set the clipboard to originalClipboard
end try

-- Clean up
do shell script "rm -f /tmp/raycast_text_input.txt"
