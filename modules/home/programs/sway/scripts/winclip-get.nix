pkgs:

pkgs.writeShellScript "winclip-get" ''
          /mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -noprofile -command Get-Clipboard| ${pkgs.wl-clipboard}/bin/wl-copy
        ''
