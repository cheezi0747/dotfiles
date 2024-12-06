# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
export GPG_TTY=$TTY

# Add .NET Core SDK tools
export PATH="$PATH:/Users/cheezi/.dotnet/tools"
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"
