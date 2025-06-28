# AI Conversation Logging Functions
# Source this in your ~/.zshrc

# Function to start logged conversation
ai_chat() {
    local model=${1:-"llama3.1:8b"}
    local topic=${2:-"general"}
    
    echo "🤖 Starting AI chat with $model (Topic: $topic)"
    echo "Type '/bye' to end conversation"
    echo "----------------------------------------"
    
    ollama run "$model"
}
# Clean, fast aliases for daily use
alias ai-code='ollama run coding-ai'
alias ai-sec='ollama run security-ai'  
alias ai-blockchain='ollama run blockchain-ai'
alias ai-general='ollama run llama3.1:8b'

# Private versions (same thing, just for clarity)
alias ai-private='ollama run llama3.1:8b'
alias ai-private-code='ollama run coding-ai'
alias ai-private-sec='ollama run security-ai'
alias ai-private-blockchain='ollama run blockchain-ai'

# Model management
alias ai-list='ollama list'
alias ai-models='ls -la ~/.ollama/models/'
alias ai-logs='ls -la ~/ai-workspace/conversations/'

# Conversation search
ai_search() {
    local query="$1"
    if [[ -z "$query" ]]; then
        echo "Usage: ai_search 'search term'"
        return 1
    fi
    
    echo "🔍 Searching conversations for: $query"
    grep -r -i --include="*.txt" "$query" ~/ai-workspace/conversations/
}

# Show recent conversations
ai_recent() {
    local count=${1:-5}
    echo "📚 Recent AI conversations:"
    find ~/ai-workspace/conversations/ -name "*.txt" -type f -printf '%T@ %p\n' | sort -n | tail -$count | cut -d' ' -f2- | while read file; do
        echo "$(stat -c %y "$file" | cut -d' ' -f1) - $(basename "$file")"
    done
}

# Clean old conversations (older than 30 days)
ai_cleanup() {
    echo "🧹 Cleaning conversations older than 30 days..."
    find ~/ai-workspace/conversations/ -name "*.txt" -type f -mtime +30 -delete
    echo "✅ Cleanup complete"
}
