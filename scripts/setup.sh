#!/bin/bash

# Local AI Organization Setup Script
# Run this to set up organized structure for your local LLMs

echo "🤖 Setting up Local AI Organization Structure..."

# Create directory structure
echo "📁 Creating directory structure..."
mkdir -p ~/ai-workspace/{configs,scripts,prompts}
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

# Create AI functions and aliases
cat > ~/ai-workspace/scripts/ai-functions.zsh << 'EOF'
# AI Assistant Functions and Aliases
# Source this in your ~/.zshrc

# Function to start AI chat with session info
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

# Model management
alias ai-list='ollama list'
alias ai-models='ls -la ~/.ollama/models/'
EOF

# Create configuration file
cat > ~/ai-workspace/configs/ai-config.yaml << 'EOF'
# Local AI Configuration
models:
  primary: "llama3.1:8b"
  coding: "coding-ai" 
  security: "security-ai"
  blockchain: "blockchain-ai"

settings:
  default_temperature: 0.7
  max_tokens: 4096
  context_window: 8192
EOF

echo "📋 Installation Summary:"
echo "✅ Directory structure created in ~/ai-workspace/"
echo "✅ Prompt templates created"
echo "✅ Management scripts created"
echo "✅ AI functions and aliases created"
echo ""
echo "🚀 Next steps:"
echo "1. Add to your ~/.zshrc:"
echo "   echo 'source ~/ai-workspace/scripts/ai-functions.zsh' >> ~/.zshrc"
echo "2. Reload shell: source ~/.zshrc"
echo "3. Create specialized models: ~/ai-workspace/scripts/create-specialized-models.sh"
echo "4. Start using AI: ai-code, ai-sec, ai-blockchain"
echo ""
echo "📁 Your AI workspace: ~/ai-workspace/"
echo "🚖 Available commands: ai-list, ai-models"