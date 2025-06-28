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
