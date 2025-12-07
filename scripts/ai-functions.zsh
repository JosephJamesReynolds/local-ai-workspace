# AI Assistant Functions and Aliases
# Source this in your ~/.zshrc

ai_chat() {
    local model=${1:-"llama3.1:8b"}        
    ollama run "$model"
}

# Specialized AI assistants
alias ai-code='ollama run coding-ai'
alias ai-sec='ollama run security-ai'  
alias ai-blockchain='ollama run blockchain-ai'
alias ai-general='ollama run llama3.1:8b'

# Model management
alias ai-list='ollama list'
alias ai-models='ls -la ~/.ollama/models/'



