#!/bin/zsh
# Load your zsh profile
source ~/.zshrc
source ~/api_keys.env

# Log for debugging
LOG_FILE="/tmp/gpt-spelling.log"
echo "$(date): Script started" > "$LOG_FILE"
echo "Args: $*" >> "$LOG_FILE"

# Check if using file input method
if [[ "$1" == "--file" ]]; then
    echo "Using file input method" >> "$LOG_FILE"
    INPUT_FILE="$2"
    if [[ ! -f "$INPUT_FILE" ]]; then
        echo "Error: Input file not found: $INPUT_FILE" | tee -a "$LOG_FILE"
        exit 1
    fi
    TEXT=$(cat "$INPUT_FILE")
else
    # Standard input method
    TEXT="$*"
fi

echo "Text to process: $TEXT" >> "$LOG_FILE"

# Make sure we have some text to process
if [[ -z "$TEXT" ]]; then
    echo "Error: No text provided for processing" | tee -a "$LOG_FILE"
    exit 1
fi

# Make sure the API key is available
if [[ -z "$OPENAI_API_KEY" ]]; then
    echo "Error: OPENAI_API_KEY not set" | tee -a "$LOG_FILE"
    exit 1
fi

# Create JSON payload using a temporary file to avoid escaping issues
PAYLOAD_FILE="/tmp/gpt_payload.json"
cat > "$PAYLOAD_FILE" << EOF
{
  "model": "gpt-4o",
  "messages": [
    {"role": "system", "content": "You are a helpful assistant that fixes spelling and grammar errors. Return only the corrected version of the text. If the text is English, use UK British English, Oxford spelling."},
    {"role": "user", "content": "$TEXT"}
  ],
  "temperature": 0
}
EOF

echo "Payload file created" >> "$LOG_FILE"

# Make the API call using the payload file
RESPONSE=$(curl -s -X POST https://api.openai.com/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    --data @"$PAYLOAD_FILE")

echo "API response: $RESPONSE" >> "$LOG_FILE"

# Check if response contains an error
if echo "$RESPONSE" | grep -q "error"; then
    ERROR_MSG=$(echo "$RESPONSE" | jq -r '.error.message')
    echo "Error: $ERROR_MSG" | tee -a "$LOG_FILE"
    exit 1
fi

# Extract the content
CONTENT=$(echo "$RESPONSE" | jq -r '.choices[0].message.content')
echo "Final output: $CONTENT" >> "$LOG_FILE"

# Clean up
rm -f "$PAYLOAD_FILE"

echo "$CONTENT"
