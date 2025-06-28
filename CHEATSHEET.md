# Local AI Workspace Cheat Sheet

## 🚀 Quick Start Commands

```bash
# Initial setup (one-time)
./scripts/setup.sh
echo 'source ~/ai-workspace/scripts/ai-functions.zsh' >> ~/.zshrc
source ~/.zshrc
~/ai-workspace/scripts/create-specialized-models.sh
```

## 🤖 AI Assistant Aliases

```bash
ai-code          # Coding assistant - blockchain, cybersecurity, Linux
ai-sec           # Security expert - pentesting, hardening, privacy
ai-blockchain    # Blockchain specialist - Solidity, DeFi, Web3
ai-general       # General AI - basic llama model
```

## 🛠 Model Management

```bash
ai-list              # List all available ollama models
ai-models            # Check model storage details
ollama list          # Same as above (direct ollama command)
ollama run model-name # Run specific model directly
ollama rm model-name # Remove unused model
du -sh ~/.ollama/    # Check storage usage of models
```

## 📂 File Locations

```bash
# Your workspace
~/ai-workspace/

# System prompts (customize AI behavior)
~/ai-workspace/prompts/coding/system-prompt.txt
~/ai-workspace/prompts/security/system-prompt.txt
~/ai-workspace/prompts/blockchain/system-prompt.txt

# Scripts and config
~/ai-workspace/scripts/ai-functions.zsh # Main functions file
~/ai-workspace/scripts/create-specialized-models.sh
~/ai-workspace/configs/ai-config.yaml   # Configuration

# Actual AI models (managed by ollama)
~/.ollama/models/    # Where models are stored (4.9GB each)
```

## 💡 Usage Examples

```bash
# Start a coding session
ai-code
# Then type: "How do I optimize this Solidity function?"

# Ask security questions
ai-sec
# Then type: "Best practices for securing a Linux server?"

# Blockchain development help
ai-blockchain
# Then type: "How do I implement a simple ERC20 token?"

# Direct model access
ollama run security-ai
```

## 🔧 Customization

```bash
# Edit AI personalities
codium ~/ai-workspace/prompts/coding/system-prompt.txt

# Add custom aliases to your shell
echo 'alias my-ai="ollama run coding-ai"' >> ~/.zshrc

# Recreate models after prompt changes
~/ai-workspace/scripts/create-specialized-models.sh
```

## ⚡ Performance Tips

```bash
# Use quantized models for better performance
ollama pull llama3.1:8b-q4_0
ollama create fast-coding-ai -f <(echo "FROM llama3.1:8b-q4_0")

# Force CPU-only mode (if GPU issues)
CUDA_VISIBLE_DEVICES="" ollama run coding-ai

# Monitor system resources
htop              # CPU/RAM usage
nvidia-smi        # GPU usage (if nvidia drivers available)
```

## 🔍 Troubleshooting

```bash
# Check if functions are loaded
type ai-code

# Reload functions if needed
source ~/ai-workspace/scripts/ai-functions.zsh

# Check ollama service
sudo systemctl status ollama

# View ollama logs
sudo journalctl -u ollama -f

# Check available models
ollama list
```

## 📊 Model Specs

| Model           | Size  | Focus         | Temperature | Best For              |
| --------------- | ----- | ------------- | ----------- | --------------------- |
| `coding-ai`     | 4.9GB | Programming   | 0.1         | Code, technical docs  |
| `security-ai`   | 4.9GB | Cybersecurity | 0.2         | Security analysis     |
| `blockchain-ai` | 4.9GB | Web3/DeFi     | 0.1         | Smart contracts, DeFi |
| `llama3.1:8b`   | 4.9GB | General       | 0.7         | General questions     |

## 🎯 Quick Reference

**Daily workflow:** `ai-code` → ask questions → get expert responses  
**Model switching:** Use different assistants for specialized knowledge  
**Customization:** Edit prompts → recreate models → enjoy personalized AI  
**Performance:** Monitor with `htop`, use quantized models if needed

## 🚀 Pro Tips

- **All conversations are private** - nothing leaves your machine
- **CPU usage spikes during generation are normal** - models are intensive
- **Customize prompts** to match your specific needs and coding style
- **Use direct `ollama run` commands** for quick one-off questions
- **Models work offline** - perfect for travel or restricted networks

---

_Save this file as `~/ai-workspace/CHEATSHEET.md` for quick reference!_
