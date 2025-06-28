#!/bin/bash

# Local AI Organization Setup Script
# Run this to set up organized structure for your local LLMs

echo "🤖 Setting up Local AI Organization Structure..."

# Create directory structure
echo "📁 Creating directory structure..."
mkdir -p ~/ai-workspace/{conversations,models,configs,scripts,prompts}
mkdir -p ~/ai-workspace/conversations/{llama,mistral,code,security,general}
mkdir -p ~/ai-workspace/prompts/{coding,security,blockchain,general}

# Create specialized prompt templates
echo "📝 Creating prompt templates..."

cat > ~/ai-workspace/prompts/coding/system-prompt.txt << 'EOF'
You are an expert software engineer specializing in blockchain development, cybersecurity, and Linux systems. 
- Focus on clean, secure code
- Explain complex concepts clearly
- Prioritize best practices
- Consider security implications
EOF

cat > ~/ai-workspace/prompts/security/system-prompt.txt << 'EOF'
You are a cybersecurity expert with deep knowledge of:
- Network security and penetration testing
- Blockchain security and smart contract auditing  
- Linux system hardening
- Privacy and digital sovereignty
Provide detailed, practical security advice.
EOF

cat > ~/ai-workspace/prompts/blockchain/system-prompt.txt << 'EOF'
You are a blockchain development expert specializing in:
- Solidity smart contract development
- DeFi protocols and DAOs
- Web3 frontend development (React, ethers.js)
- Ethereum ecosystem and tooling
Focus on secure, gas-efficient solutions.
EOF

# Create model management scripts
echo "🔧 Creating management scripts..."

cat > ~/ai-workspace/scripts/create-specialized-models.sh << 'EOF'
#!/bin/bash
# Create specialized AI models with custom prompts

echo "Creating specialized AI models..."

# Coding assistant
cat > /tmp/coding-modelfile << 'EOMODEL'
FROM llama3.1:8b
SYSTEM $(cat ~/ai-workspace/prompts/coding/system-prompt.txt)
PARAMETER temperature 0.1
PARAMETER top_p 0.9
EOMODEL

ollama create coding-ai -f /tmp/coding-modelfile

# Security expert
cat > /tmp/security-modelfile << 'EOMODEL'
FROM llama3.1:8b  
SYSTEM $(cat ~/ai-workspace/prompts/security/system-prompt.txt)
PARAMETER temperature 0.2
PARAMETER top_p 0.9
EOMODEL

ollama create security-ai -f /tmp/security-modelfile

# Blockchain expert
cat > /tmp/blockchain-modelfile << 'EOMODEL'
FROM llama3.1:8b
SYSTEM $(cat ~/ai-workspace/prompts/blockchain/system-prompt.txt)
PARAMETER temperature 0.1
PARAMETER top_p 0.9
EOMODEL

ollama create blockchain-ai -f /tmp/blockchain-modelfile

echo "✅ Created specialized models: coding-ai, security-ai, blockchain-ai"
echo "Test with: ollama run coding-ai"

# Cleanup
rm /tmp/*-modelfile
EOF

chmod +x ~/ai-workspace/scripts/create-specialized-models.sh

# Create conversation logging functions
cat > ~/ai-workspace/scripts/ai-functions.zsh << 'EOF'
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
EOF

# Create configuration file
cat > ~/ai-workspace/configs/ai-config.yaml << 'EOF'
# Local AI Configuration
models:
  primary: "llama3.1:8b"
  coding: "coding-ai" 
  security: "security-ai"
  blockchain: "blockchain-ai"

logging:
  enabled: true
  directory: "~/ai-workspace/conversations"
  auto_cleanup_days: 30

settings:
  default_temperature: 0.7
  max_tokens: 4096
  context_window: 8192
EOF

echo "📋 Installation Summary:"
echo "✅ Directory structure created in ~/ai-workspace/"
echo "✅ Prompt templates created"
echo "✅ Management scripts created"
echo "✅ Conversation logging functions created"
echo ""
echo "🚀 Next steps:"
echo "1. Add to your ~/.zshrc:"
echo "   echo 'source ~/ai-workspace/scripts/ai-functions.zsh' >> ~/.zshrc"
echo "2. Reload shell: source ~/.zshrc"
echo "3. Create specialized models: ~/ai-workspace/scripts/create-specialized-models.sh"
echo "4. Start coding session: ai-code"
echo ""
echo "📁 Your AI workspace: ~/ai-workspace/"
echo "🔍 Search conversations: ai_search 'term'"
echo "📚 Recent chats: ai_recent"
EOF