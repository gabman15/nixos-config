{
  "temperature" = {
    hwmon-path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon2/temp1_input";
  };
  "disk" = {
    path = "/";
    format = "{path}: {percentage_used}%";
  };
  "disk#games" = {
    path = "/games";
    format = "{path}: {percentage_used}%";
  };
  "disk#anime" = {
    path = "/mnt/anime";
    format = "{path}: {percentage_used}%";
  };
}
