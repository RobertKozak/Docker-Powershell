# Docker PowerShell
Microsoft's PowerShell on Ubuntu 16.04 (Xenial) running in a docker container.

A simple demonstration of getting Powershell into a Docker container. This is a very small image with a compressed size of 105 MB and image size of 291.2 MB.

See [Dockerfile](https://raw.githubusercontent.com/RobertKozak/Docker-Powershell/master/Dockerfile) for more information.

# Usage
To run PowerShell:

    docker run -it --rm robertkozak/docker-powershell

 
As an alias:
    
    alias posh='docker run -it --rm robertkozak/docker-powershell'
    posh get-command
