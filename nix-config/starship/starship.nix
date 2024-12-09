{
  "$schema" = "https://starship.rs/config-schema.json";

  add_newline = true;

  palette = "catppuccin_mocha";

  format = ''
    [](bg:transparent fg:green)$os$username$hostname[](fg:green bg:overlay0)$time[ ](fg:overlay0 bg:blue)$directory[](fg:blue bg:yellow)$git_branch$git_status$git_commit$git_metrics[](fg:yellow bg:transparent)$aws$python$cmd_duration
    $character
  '';

  character = {
    disabled = false;
    format = "$symbol  ";
    success_symbol = "[](bold fg:green)";
    error_symbol = "[](bold fg:purple)";
  };

  os = {
    format = "[$symbol]($style)";
    style = "bg:green fg:mantle";
    disabled = false;

    symbols = {
      AlmaLinux = " ";
      #Linux = " ";
      Macos = " ";
      Mint = " ";
      Raspbian = " ";
      Redhat = " ";
      RockyLinux = " ";
      Linux = " ";
      Ubuntu = " ";
      Unknown = " ";
      Windows = "󰍲 ";
    };
  };

  username = {
    style_user = "bg:green fg:mantle";
    style_root = "red bold";
    format = "[$user]($style)";
    disabled = false;
    show_always = true;
  };

  hostname = {
    ssh_only = false;
    format = "[@$hostname ](bg:green fg:mantle)";
    disabled = false;
  };

  time = {
    time_format = "%T";
    format = "[ 󱑍 $time ](bg:overlay0 fg:yellow)";
    disabled = false;
  };

  directory = {
    home_symbol = "󰋜 ~";
    truncation_length = 25;
    truncation_symbol = "󰇘 ";
    truncate_to_repo = true;
    style = "fg:mantle bg:blue";
    read_only = "󰍁";
    read_only_style = "fg:base bg:blue";
    format = "[  $path]($style)[ $read_only ]($read_only_style)";
  };

   directory.substitutions = {
    "Documents" = "󰈙 ";
    "Downloads" = " ";
    "Music" = "󰝚 ";
    "Pictures" = " ";
    "development" = "󰲋 ";
  };

  git_branch = {
    format = "[ $symbol$branch(:$remote_branch) ]($style)";
    style = "fg:base bg:yellow";
  };

  git_status = {
    format = "([\\[$all_status$ahead_behind\\]]($style))";
    style = "fg:surface0 bg:yellow";
  };

  git_metrics = {
    format = "([ +$added]($added_style))([ -$deleted ]($deleted_style))";
    added_style = "fg:surface1 bg:yellow";
    deleted_style = "fg:red bg:yellow";
    disabled = false;
  };

  aws = {
    format = " on [$symbol($profile) \\(($region)\\) \\[$duration\\] ]($style)";
    style = "bold peach";
    symbol = " ";

  #  profile_aliases = {
  #    administrator-production-ready-serverless = "admin-serverless";
  #  };
  };

  # Disabled modules
  azure = { disabled = true; };
  battery = { disabled = true; };
  buf = { disabled = true; };
  c = { disabled = true; };
  cmake = { disabled = true; };
  cmd_duration = { disabled = true; };
  cobol = { disabled = true; };
  conda = { disabled = true; };
  container = { disabled = true; };
  crystal = { disabled = true; };
  custom = { disabled = true; };
  # ... Add other disabled modules as needed ...

  palettes = {
    catppuccin_mocha = {
      rosewater = "#f5e0dc";
      flamingo = "#f2cdcd";
      pink = "#f5c2e7";
      mauve = "#cba6f7";
      red = "#f38ba8";
      maroon = "#eba0ac";
      peach = "#fab387";
      yellow = "#f9e2af";
      green = "#a6e3a1";
      teal = "#94e2d5";
      sky = "#89dceb";
      sapphire = "#74c7ec";
      blue = "#89b4fa";
      lavender = "#b4befe";
      text = "#cdd6f4";
      subtext1 = "#bac2de";
      subtext0 = "#a6adc8";
      overlay2 = "#9399b2";
      overlay1 = "#7f849c";
      overlay0 = "#6c7086";
      surface2 = "#585b70";
      surface1 = "#45475a";
      surface0 = "#313244";
      base = "#1e1e2e";
      mantle = "#181825";
      crust = "#11111b";
      transparent = "#00FFFFFF";
    };
  };
}

