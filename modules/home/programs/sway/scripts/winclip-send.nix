pkgs:

pkgs.writeShellScript "winclip-send" ''
          ${pkgs.wl-clipboard}/bin/wl-paste | /mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -noprofile -command "chcp 65001 >\$null; clip.exe"
        ''
