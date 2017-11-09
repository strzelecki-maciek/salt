{% from "docker/docker.map" import docker with context %}

include:
  - docker.deps

docker-ce:
  pkgrepo.managed:
    - humanname: Docker CE
    - name: deb https://download.docker.com/linux/ubuntu {{ docker.repo }} stable
    - file: /etc/apt/sources.list.d/docker-ce.list
    - key_url: https://download.docker.com/linux/ubuntu/gpg 
  pkg.installed:
    - version: {{ docker.version }}
