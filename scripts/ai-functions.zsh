# AI Conversation Logging Functions
# Source this in your ~/.zshrc

# Function to start logged conversation
ai_chat() {
    local model=${1:-"llama3.1:8b"}
    local topic=${2:-"general"}
    local timestamp=$(date +%Y%m%d-%H%M%S)
    local logfile="$HOME/ai-workspace/conversations/$topic/${model//[:.\/]/_}-$timestamp.txt"
    
    echo "🤖 Starting AI chat with $model"
    echo "📝 Logging to: $logfile"
    echo "Type 'exit' or '/bye' to end conversation"
    echo "----------------------------------------" | tee "$logfile"
    echo "Model: $model | Topic: $topic | Started: $(date)" | tee -a "$logfile"
    echo "----------------------------------------" | tee -a "$logfile"
    
    ollama run "$model" | tee -a "$logfile"
}

# Quick access aliases
alias ai-code='ai_chat "coding-ai" "code"'
alias ai-sec='ai_chat "security-ai" "security"' 
alias ai-blockchain='ai_chat "blockchain-ai" "blockchain"'
alias ai-general='ai_chat "llama3.1:8b" "general"'

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
