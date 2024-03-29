{
  inputs,
  ...
}: {
  imports = [ inputs.isw-nix.nixosModule ];
  services.isw = {
    enable = true;
    address_profile = "MSI_ADDRESS_DEFAULT";

    # The default section created by this configuration is `NIX`
    # By changhing this value it is possible to load a different section
    # - A default one already defined in the config file
    # - Or a custom one defined in extraConfig
    section = "NIX";

    # 12:  Auto mode
    # 76:  Simple mode
    # 140: Advanced mode
    fan_mode = 12;

    cpu = {
      temp = {
        _0 = 30;    # cpu_temp_0
        _1 = 40;    # cpu_temp_1
        _2 = 48;    # cpu_temp_2
        _3 = 55;    # cpu_temp_3
        _4 = 65;    # cpu_temp_4
        _5 = 80;    # cpu_temp_5
      };

      speed = {
        _0 = 0;     # cpu_fan_speed_0
        _1 = 20;    # cpu_fan_speed_1
        _2 = 35;    # cpu_fan_speed_2
        _3 = 45;    # cpu_fan_speed_3
        _4 = 60;    # cpu_fan_speed_4
        _5 = 80;    # cpu_fan_speed_5
        _6 = 100;   # cpu_fan_speed_6
      };
    };

    gpu = {
      temp = {
        _0 = 35;    # gpu_temp_0
        _1 = 45;    # gpu_temp_1
        _2 = 52;    # gpu_temp_2
        _3 = 63;    # gpu_temp_3
        _4 = 77;    # gpu_temp_4
        _5 = 85;    # gpu_temp_5
      };

      speed = {
        _0 = 0;     # gpu_fan_speed_0
        _1 = 20;    # gpu_fan_speed_1
        _2 = 35;    # gpu_fan_speed_2
        _3 = 50;    # gpu_fan_speed_3
        _4 = 70;    # gpu_fan_speed_4
        _5 = 85;    # gpu_fan_speed_5
        _6 = 100;   # gpu_fan_speed_6
      };
    };

    extraConfig = ''
      # This gets appended at the end of isw.conf
    '';
  };
}