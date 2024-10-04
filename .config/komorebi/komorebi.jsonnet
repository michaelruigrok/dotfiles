
local workspaces = [
  [
    {
      "name": "1",
      "layout": "BSP"
    },
    {
      "name": "2",
      "layout": "BSP"
    },
    {
      "name": "3",
      "layout": "BSP"
    },
    {
      "name": "4",
      "layout": "BSP"
    },
    {
      "name": "5",
      "layout": "BSP"
    },
    {
      "name": "6",
      "layout": "BSP"
    }
  ],
  [
    {
      "name": "8",
      "layout": "BSP",
      "workspace_rules": [
         {
           "id": "Mattermost.exe",
           "kind": "Exe",
           "matching_strategy": "Equals"
         },
         {
           "id": "Spotify.exe",
           "kind": "Exe",
           "matching_strategy": "Regex"
         },
         {
           "id": "thunderbird.exe",
           "kind": "Exe",
           "matching_strategy": "Equals"
         }
      ]
    },
    {
      "name": "7",
      "layout": "BSP",
      "workspace_rules": [
      ]
    },
    {
      "name": "9",
      "layout": "BSP"
    },
    {
      "name": "10",
      "layout": "BSP"
    }
  ]
];

{
  "$schema": "https://raw.githubusercontent.com/LGUG2Z/komorebi/v0.1.23/schema.json",
  "app_specific_configuration_path": "$Env:USERPROFILE/applications.yaml",
  "window_hiding_behaviour": "Cloak",
  "cross_monitor_move_behaviour": "Insert",
  "default_workspace_padding": 8,
  "default_container_padding": 8,
  "border_padding": 4,
  "border_offset": -1,
  "border": true,
  "border_colours": {
    "stack": "#42a5f5",
    "single": "#00a542",
    "monocle": "#ff3399"
  },
  "monitors": (if std.extVar('singleMonitor') then
    [{
      "workspaces": workspaces[0] + workspaces[1],
    }]
  else
    [
      {
        "workspaces": workspaces[0],
      },
      {
        "workspaces": workspaces[1],
      },
    ]
  ),
}
