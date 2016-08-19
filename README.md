# Docker PowerShell
Microsoft's PowerShell on Ubuntu 16.04 (Xenial) running in a docker container.

A simple demonstration of getting Powershell into a Docker container. See Dockerfile for more information.

# Usage
To run PowerShell:

    docker run -it --rm robertkozak/powershell

 
As an alias:
    
    alias posh='docker run -it --rm robertkozak/powershell'
    posh get-command
