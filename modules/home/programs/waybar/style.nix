''
* {
    border: none;
    border-radius: 0;
    font-family: Hack Nerd Font;
    font-size: 20px;
    min-height: 0;
}

window#waybar {
    background: rgba(43, 48, 59, 0.5);
/*    border-bottom: 3px solid rgba(100, 114, 125, 0.5);*/
    color: white;
}

tooltip {
  background: rgba(43, 48, 59, 0.5);
  border: 1px solid rgba(100, 114, 125, 0.5);
}
tooltip label {
  color: white;
}

#workspaces button {
    padding: 0 5px;
    color: white;
    border-bottom: 3px solid transparent;
}

#workspaces button.focused
#workspaces button.active {
    border-bottom: 3px solid #0000ff;
}

#mode, #clock, #battery, #network, #memory, #cpu, #pulseaudio {
    padding: 0 15px;
}

#mode {
    background: #64727D;
    border-bottom: 3px solid white;
}

#battery {
    background-color: #ffffff;
    color: black;
}

#battery.charging {
    color: white;
    background-color: #26A65B;
}

@keyframes blink {
    to {
        background-color: #ffffff;
        color: black;
    }
}

#battery.warning:not(.charging) {
    background: #f53c3c;
    color: white;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: steps(12);
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

''
