# Justfile - Productivity recipes for dotfiles & development
# Usage: just [recipe-name] or just --list

set shell := ["zsh", "-cu"]

# Default recipe - show help
default:
    @just --list

# ============================================================
# DOTFILES MANAGEMENT
# ============================================================

# Update dotfiles and commit changes
@update-dotfiles:
    echo "📦 Updating dotfiles..."
    cd ~/.dotfiles
    git add -A
    git commit -m "update: dotfiles $(date +%Y-%m-%d)" || echo "✅ Nothing to commit"
    git log -1 --oneline

# Push dotfiles changes to remote
@push-dotfiles:
    cd ~/.dotfiles
    git push origin main
    echo "✅ Dotfiles pushed"

# Pull latest dotfiles
@pull-dotfiles:
    cd ~/.dotfiles
    git pull origin main
    echo "✅ Dotfiles updated"

# Reload shell configuration
@reload-shell:
    echo "🔄 Reloading shell..."
    exec zsh
    echo "✅ Shell reloaded"

# Install dotfiles (symlink to home)
@install-dotfiles:
    echo "🔗 Installing dotfiles..."
    cd ~/.dotfiles
    ln -sfv ~/.dotfiles/.zshrc ~/.zshrc
    echo "✅ Dotfiles installed"

# Sync .bashrc to home directory
@sync-bashrc:
    echo "📄 Syncing .bashrc..."
    cp -v ~/.dotfiles/.bashrc ~/.bashrc
    echo "✅ .bashrc synced"

# Sync tmux.conf to home directory
@sync-tmux:
    echo "📄 Syncing tmux.conf..."
    cp -v ~/.dotfiles/tmux.conf ~/.tmux.conf
    echo "✅ tmux.conf synced"

# Sync .bashrc and tmux.conf
@sync-configs: sync-bashrc sync-tmux
    echo "✅ All configs synced"

# ============================================================
# DEVELOPMENT WORKFLOWS
# ============================================================

# Initialize a new project
@new-project name:
    echo "🚀 Creating new project: {{name}}"
    mkdir -pv ~/projects/{{name}}
    cd ~/projects/{{name}}
    git init
    echo "# {{name}}" > README.md
    git add README.md
    git commit -m "initial commit"
    echo "✅ Project ready at ~/projects/{{name}}"

# Quick dev environment setup
@setup-dev:
    echo "⚙️  Setting up development environment..."
    python3 -m venv venv || echo "✓ venv exists"
    source venv/bin/activate
    pip install -r requirements.txt 2>/dev/null || echo "⚠️  No requirements.txt"
    echo "✅ Dev environment ready"

# Build project (auto-detects build system)
@build:
    #!/bin/zsh
    echo "🔨 Building project..."
    if [[ -f "Makefile" ]]; then
        make
    elif [[ -f "package.json" ]]; then
        npm run build
    elif [[ -f "setup.py" ]]; then
        python3 setup.py build
    elif [[ -f "go.mod" ]]; then
        go build ./...
    else
        echo "⚠️  No build system detected"
    fi
    echo "✅ Build complete"

# Run tests
@test:
    #!/bin/zsh
    echo "🧪 Running tests..."
    if [[ -f "package.json" ]]; then
        npm test
    elif [[ -f "pytest.ini" ]] || [[ -f "setup.py" ]]; then
        pytest -v
    elif [[ -f "go.mod" ]]; then
        go test ./...
    elif [[ -f "Makefile" ]]; then
        make test
    else
        echo "⚠️  No test runner detected"
    fi

# Start dev server
@dev:
    #!/bin/zsh
    echo "🚀 Starting dev server..."
    if [[ -f "docker-compose.yml" ]]; then
        docker compose up -d
        echo "✅ Docker services started"
    elif [[ -f "package.json" ]]; then
        npm run dev
    elif [[ -f "Makefile" ]]; then
        make dev
    else
        echo "⚠️  No dev server detected"
    fi

# Stop dev server/containers
@stop:
    #!/bin/zsh
    echo "⏹️  Stopping services..."
    if [[ -f "docker-compose.yml" ]]; then
        docker compose down
        echo "✅ Docker services stopped"
    else
        echo "⚠️  No services to stop"
    fi

# Lint code
@lint:
    #!/bin/zsh
    echo "🔍 Linting code..."
    if [[ -f "package.json" ]]; then
        npm run lint
    elif command -v pylint &> /dev/null; then
        pylint . --exit-zero
    elif command -v golint &> /dev/null; then
        golint ./...
    else
        echo "⚠️  No linter detected"
    fi

# ============================================================
# GIT WORKFLOWS
# ============================================================

# Show git status
@status:
    git status

# Quick commit with message
@commit message:
    git add -A
    git commit -m "{{message}}"
    echo "✅ Committed: {{message}}"

# Create feature branch
@feature name:
    git checkout -b feature/{{name}}
    echo "✅ Branch created: feature/{{name}}"

# Create bugfix branch
@bugfix name:
    git checkout -b bugfix/{{name}}
    echo "✅ Branch created: bugfix/{{name}}"

# Show recent commits
@log lines="20":
    git log --oneline -{{lines}}

# Show detailed log graph
@logp:
    git log --oneline --graph --all --decorate

# Pull and merge main
@sync:
    echo "🔄 Syncing with main..."
    git fetch origin
    git merge origin/main
    echo "✅ Synced"

# ============================================================
# SYSTEM & MAINTENANCE
# ============================================================

# Clean up temporary files and caches
@clean:
    echo "🧹 Cleaning up..."
    find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
    find . -type d -name "node_modules" -exec rm -rf {} + 2>/dev/null || true
    find . -type f -name ".DS_Store" -delete 2>/dev/null || true
    find . -type d -name ".next" -exec rm -rf {} + 2>/dev/null || true
    find . -type d -name "dist" -exec rm -rf {} + 2>/dev/null || true
    echo "✅ Cleanup complete"

# Update system packages
@system-update:
    echo "📦 Updating system..."
    sudo apt update
    sudo apt full-upgrade -y
    sudo apt autoremove -y
    echo "✅ System updated"

# Show disk usage
@disk-usage:
    echo "💾 Disk Usage:"
    du -sh * | sort -rh | head -20

# Show system info
@sysinfo:
    echo "📊 System Information:"
    uname -a
    echo ""
    echo "CPU: $(grep -c processor /proc/cpuinfo) cores"
    echo "RAM: $(free -h | grep Mem | awk '{print $2}')"
    echo "Disk: $(df -h / | awk 'NR==2 {print $3 " / " $2}')"

# Check all ports in use
@ports:
    echo "🔌 Ports in use:"
    netstat -tulpn | grep LISTEN | awk '{print $4}' | cut -d':' -f2 | sort -u

# Docker cleanup
@docker-clean:
    echo "🐳 Cleaning Docker..."
    docker system prune -f
    echo "✅ Docker cleanup complete"

# ============================================================
# QUICK UTILITIES
# ============================================================

# Create quick HTTP server
@serve port="8000":
    echo "🌐 Server running on port {{port}}"
    python3 -m http.server {{port}}

# Timer for pomodoro/breaks
@timer minutes="25":
    echo "⏱️  Timer: {{minutes}} minutes"
    sleep {{minutes}}m
    echo "🔔 Time's up!"

# Show weather (requires curl)
@weather city="London":
    curl -s "https://wttr.in/{{city}}?format=3"

# Search dotfiles content
@search pattern:
    echo "🔍 Searching for: {{pattern}}"
    grep -r "{{pattern}}" ~/.dotfiles --color=auto

# List all recipes
@recipes:
    @just --list --no-docs
