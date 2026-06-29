
hl.on("hyprland.start", function () 
  hl.exec_cmd("waybar") -- Execute waybar, hyprpaper, firefox
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("awww img /win/arch/home/dms/.wallpapers/vibrant/almostsetsun.jpg")
end)