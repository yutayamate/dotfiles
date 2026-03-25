function podman_docker_setup() {
    if pgrep -f podman-machine >/dev/null 2>&1; then
        export DOCKER_HOST=unix://$(podman machine inspect --format '{{.ConnectionInfo.PodmanSocket.Path}}') DOCKER_BUILDKIT=0 COMPOSE_DOCKER_CLI_BUILD=0
    fi
}

add-zsh-hook precmd podman_docker_setup
