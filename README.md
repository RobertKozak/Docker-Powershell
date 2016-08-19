# Docker PowerShell
Microsoft's PowerShell on Ubuntu 16.04 running in a docker container.

# Usage
To run PowerShell:

    docker run -it --rm RobertKozak/powershell

 
As an alias:
    
    alias posh='docker run -it --rm RobertKozak/powershell'
    posh get-command
