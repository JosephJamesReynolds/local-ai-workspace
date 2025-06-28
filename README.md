# Local AI Workspace for Digital Sovereignty

A privacy-focused, organized setup for running local Large Language Models (LLMs) with specialized AI assistants for coding, cybersecurity, and blockchain development.

## 🚀 Overview

This project provides a complete local AI workspace that enables true digital sovereignty - your AI assistants run entirely on your hardware, with no data sent to external servers. Perfect for developers who value privacy, want offline AI capabilities, or need specialized AI assistants for technical work.

**Key Features:**

- 🔒 **Complete Privacy** - All AI conversations stay on your machine
- 🎯 **Specialized AI Models** - Custom assistants for coding, security, and blockchain
- 📁 **Organized Workspace** - Structured model and prompt management
- ⚡ **Fast Access** - Clean, direct aliases for instant AI assistance
- 🛠 **Easy Setup** - Automated installation script for Linux

## 📋 Prerequisites

- **Linux** (tested on Arch Linux, should work on other distributions)
- **Ollama** installed ([installation guide](https://ollama.ai/download))
- **8GB+ RAM** minimum, 16GB+ recommended for 8B models
- **GPU** (optional) - Works with NVIDIA (proprietary or nouveau drivers), AMD, or CPU-only

**Platform Notes**:

- **Linux**: Full compatibility
- **Mac**: Adaptable with minor script modifications
- **Windows**: Requires WSL2 or PowerShell equivalents

## ⚡ Quick Start

1. **Clone and setup:**

   ```bash
   git clone https://github.com/JosephJamesReynolds/local-ai-workspace.git
   cd local-ai-workspace
   chmod +x scripts/setup.sh
   ./scripts/setup.sh
   ```

   **Note**: On non-Arch systems, install ollama first: `curl -fsSL https://ollama.com/install.sh | sh`

2. **Add functions to your shell:**

   ```bash
   echo 'source ~/ai-workspace/scripts/ai-functions.zsh' >> ~/.zshrc
   source ~/.zshrc
   ```

3. **Create specialized AI models:**

   ```bash
   ~/ai-workspace/scripts/create-specialized-models.sh
   ```

4. **Start using your AI assistants:**
   ```bash
   ai-code          # Coding assistant
   ai-sec           # Security expert
   ai-blockchain    # Blockchain specialist
   ```

## 🤖 Available AI Assistants

### Coding Assistant (`ai-code`)

- Specialized in blockchain development, cybersecurity, and Linux systems
- Focuses on clean, secure code and best practices
- Temperature: 0.1 (more focused/deterministic responses)

### Security Expert (`ai-sec`)

- Deep knowledge of network security and penetration testing
- Blockchain security and smart contract auditing expertise
- Linux system hardening and privacy tools
- Temperature: 0.2 (balanced between focused and creative)

### Blockchain Specialist (`ai-blockchain`)

- Expert in Solidity smart contract development
- DeFi protocols, DAOs, and Web3 frontend development
- Ethereum ecosystem and tooling knowledge
- Temperature: 0.1 (precise technical guidance)

## 📁 Workspace Structure

```
~/ai-workspace/
├── prompts/               # System prompt templates
│   ├── coding/
│   ├── security/
│   └── blockchain/
├── scripts/               # Management and utility scripts
│   ├── ai-functions.zsh   # Main aliases and functions
│   ├── create-specialized-models.sh
│   └── setup.sh
└── configs/               # Configuration files
    └── ai-config.yaml
```

## 🔧 Usage Examples

### Starting Conversations

```bash
# Specialized AI assistants
ai-code                    # Ask about coding problems
ai-sec                     # Cybersecurity questions
ai-blockchain             # Blockchain development help
```

### Model Management

```bash
ai-list                     # List all available models
ai-models                   # Check model storage details
ollama list                 # Direct ollama command
```

### Direct Model Access

```bash
ollama run coding-ai        # Direct access to coding assistant
ollama run security-ai      # Direct access to security expert
ollama list                 # See all installed models
```

## 🛡️ Privacy Features

- **Local Processing** - No data sent to external servers
- **Complete Privacy** - All conversations stay on your machine
- **No Telemetry** - Complete isolation from cloud AI services
- **Secure Storage** - All data stays on your filesystem with your permissions

## ⚙️ Customization

### Modify AI Personalities

Edit the system prompts in `prompts/*/system-prompt.txt` to customize your AI assistants' behavior and expertise.

### Add New Specialists

1. Create a new prompt file in `prompts/your-specialty/system-prompt.txt`
2. Add a new model creation section to `scripts/create-specialized-models.sh`
3. Add aliases in `scripts/ai-functions.zsh`

### Adjust Model Parameters

Edit the Modelfile generation in `create-specialized-models.sh` to modify:

- Temperature (creativity vs focus)
- Top-p (response diversity)
- Context length
- Other model parameters

## 🔍 Troubleshooting

### Performance Issues

- **High CPU usage during generation is normal** - models are computationally intensive
- Consider using quantized models (e.g., `llama3.1:8b-q4_0`) for better performance
- Ensure adequate RAM for your chosen model size

### Model Management

```bash
ollama list                 # Check installed models
ollama rm model-name        # Remove unused models
du -sh ~/.ollama/           # Check storage usage
```

### GPU and Performance

- **High CPU usage during text generation is normal** - models are computationally intensive
- **Nouveau (open source nvidia drivers)**: Works well with dual GPU setups, no configuration needed
- **Proprietary NVIDIA drivers**: Use `nvidia-smi` to monitor GPU usage if available
- **CPU-only mode**: Force with `CUDA_VISIBLE_DEVICES="" ollama run model-name`
- **AMD GPUs**: Supported with ROCm in recent ollama versions
- Consider quantized models (e.g., `llama3.1:8b-q4_0`) for better performance on limited hardware

## 🛠 Technical Details

- **Base Model**: Llama 3.1 8B (4.7GB download)
- **Framework**: Ollama for model management
- **Shell**: Zsh functions and aliases
- **Storage**: AI models stored in `~/.ollama/models/` (managed by ollama)
- **Workspace**: Configuration and prompts in `~/ai-workspace/`

## 🤝 Contributing

Contributions welcome! This project aims to make local AI accessible for digital sovereignty. Areas for improvement:

- Additional specialized AI personalities
- Better model management tools
- Integration with development workflows
- Support for other Linux distributions

## 📄 License

MIT License - Feel free to use, modify, and distribute.

## 🎯 About

Created by a blockchain developer who went from "barely knowing computers" to building sophisticated AI tooling in 3.5 years. This project embodies the principles of digital sovereignty - taking control of your tools and data.

**Why Local AI?**

- Privacy and data sovereignty
- Offline capability
- No API costs after initial setup
- Complete control over AI behavior and responses
- Educational value in understanding AI deployment

---

_"The best way to predict the future is to build it yourself."_
