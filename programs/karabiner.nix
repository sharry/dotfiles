{ ... }:
let
  configPath = ".config/karabiner/karabiner.json";
in
{
  home.file.${configPath}.text = ''
  {
    "profiles": [
        {
            "name": "Default profile",
            "selected": true,
            "simple_modifications": [
                {
                    "from": { "key_code": "caps_lock" },
                    "to": [{ "key_code": "delete_forward" }]
                }
            ],
            "virtual_hid_keyboard": { "keyboard_type_v2": "ansi" }
        }
    ]
  }
  '';
}