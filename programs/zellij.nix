let
	colors = {
		base00 = "#1e1e2e"; # base
		base01 = "#181825"; # mantle
		base02 = "#313243"; # surface0
		base03 = "#45475a"; # surface1
		base04 = "#585b70"; # surface2
		base05 = "#cdd6f4"; # text
		base06 = "#f5e0dc"; # rosewater
		base07 = "#b4befe"; # lavender
		base08 = "#f38ba8"; # red
		base09 = "#fab387"; # peach
		base0A = "#f9e2af"; # yellow
		base0B = "#a6e3a1"; # green
		base0C = "#94e2d5"; # teal
		base0D = "#92b3f4"; # blue
		base0E = "#cba6f7"; # mauve
		base0F = "#f2cdcd"; # flamingo
	};
in
{
	programs.zellij = {
		enable = true;
		enableZshIntegration = true;
	};

	xdg.configFile."zellij/config.kdl".text = ''

		mouse_mode true
		pane_frames false
		simplified_ui true
		theme "catppuccin-mocha"

		ui {
			pane_frames {
				hide_session_name true
			}
		}

		keybinds {
			shared_except "locked" {
				bind "Ctrl Shift f" { ToggleFloatingPanes; }
				bind "Ctrl Shift n" { NewPane; }
				bind "Ctrl Shift i" { MoveTab "Left"; }
				bind "Ctrl Shift o" { MoveTab "Right"; }
				bind "Ctrl Shift h" "Ctrl Shift Left" { MoveFocusOrTab "Left"; }
				bind "Ctrl Shift l" "Ctrl Shift Right" { MoveFocusOrTab "Right"; }
				bind "Ctrl Shift j" "Ctrl Shift Down" { MoveFocus "Down"; }
				bind "Ctrl Shift k" "Ctrl Shift Up" { MoveFocus "Up"; }
				bind "Ctrl Shift =" "Ctrl Shift +" { Resize "Increase"; }
				bind "Ctrl Shift -" { Resize "Decrease"; }
				bind "Ctrl Shift [" { PreviousSwapLayout; }
				bind "Ctrl Shift ]" { NextSwapLayout; }
			}
		}

	'';

	xdg.configFile."zellij/layouts/default.kdl".text = ''

		layout {
			swap_tiled_layout name="vertical" {
				tab max_panes=5 {
					pane split_direction="vertical" {
						pane
						pane { children; }
					}
				}
				tab max_panes=8 {
					pane split_direction="vertical" {
						pane { children; }
						pane { pane; pane; pane; pane; }
					}
				}
				tab max_panes=12 {
					pane split_direction="vertical" {
						pane { children; }
						pane { pane; pane; pane; pane; }
						pane { pane; pane; pane; pane; }
					}
				}
			}

			swap_tiled_layout name="horizontal" {
				tab max_panes=5 {
					pane
					pane
				}
				tab max_panes=8 {
					pane {
						pane split_direction="vertical" { children; }
						pane split_direction="vertical" { pane; pane; pane; pane; }
					}
				}
				tab max_panes=12 {
					pane {
						pane split_direction="vertical" { children; }
						pane split_direction="vertical" { pane; pane; pane; pane; }
						pane split_direction="vertical" { pane; pane; pane; pane; }
					}
				}
			}

			swap_tiled_layout name="stacked" {
				tab min_panes=5 {
					pane split_direction="vertical" {
						pane
						pane stacked=true { children; }
					}
				}
			}

			swap_floating_layout name="staggered" {
				floating_panes
			}

			swap_floating_layout name="enlarged" {
				floating_panes max_panes=10 {
					pane { x "5%"; y 1; width "90%"; height "90%"; }
					pane { x "5%"; y 2; width "90%"; height "90%"; }
					pane { x "5%"; y 3; width "90%"; height "90%"; }
					pane { x "5%"; y 4; width "90%"; height "90%"; }
					pane { x "5%"; y 5; width "90%"; height "90%"; }
					pane { x "5%"; y 6; width "90%"; height "90%"; }
					pane { x "5%"; y 7; width "90%"; height "90%"; }
					pane { x "5%"; y 8; width "90%"; height "90%"; }
					pane { x "5%"; y 9; width "90%"; height "90%"; }
					pane focus=true { x 10; y 10; width "90%"; height "90%"; }
				}
			}

			swap_floating_layout name="spread" {
				floating_panes max_panes=1 {
					pane {y "50%"; x "50%"; }
				}

				floating_panes max_panes=2 {
					pane { x "1%"; y "25%"; width "45%"; }
					pane { x "50%"; y "25%"; width "45%"; }
				}

				floating_panes max_panes=3 {
					pane focus=true { y "55%"; width "45%"; height "45%"; }
					pane { x "1%"; y "1%"; width "45%"; }
					pane { x "50%"; y "1%"; width "45%"; }
				}

				floating_panes max_panes=4 {
					pane { x "1%"; y "55%"; width "45%"; height "45%"; }
					pane focus=true { x "50%"; y "55%"; width "45%"; height "45%"; }
					pane { x "1%"; y "1%"; width "45%"; height "45%"; }
					pane { x "50%"; y "1%"; width "45%"; height "45%"; }
				}
			}

			default_tab_template {
				pane size=2 borderless=true {
					plugin location="https://github.com/dj95/zjstatus/releases/download/v0.19.2/zjstatus.wasm" {
						format_left   "{mode}#[bg=${colors.base00}] {tabs}"
						format_center ""
						format_right  "#[bg=#00000000,fg=${colors.base0D}]#[bg=${colors.base0D},fg=${colors.base01},bold] #[bg=${colors.base02},fg=${colors.base05},bold] {session} #[bg=${colors.base03},fg=${colors.base05},bold]"
						format_space  ""
						format_hide_on_overlength "true"
						format_precedence "crl"
						border_enabled  "false"
						border_char     "─"
						border_format   "#[fg=6C7086]{char}"
						border_position "top"

						mode_normal        "#[fg=${colors.base0D}]█#[bg=${colors.base0D},fg=${colors.base02},bold]NORMAL#[bg=${colors.base03},fg=${colors.base0D}]#[fg=${colors.base0D},bold]"
						mode_locked        "#[fg=${colors.base04}]█#[bg=${colors.base04},fg=${colors.base02},bold]LOCKED #[bg=${colors.base03},fg=${colors.base04}]#[fg=${colors.base04},bold]"
						mode_resize        "#[fg=${colors.base08}]█#[bg=${colors.base08},fg=${colors.base02},bold]RESIZE#[bg=${colors.base03},fg=${colors.base08}]#[fg=${colors.base08},bold]"
						mode_pane          "#[fg=${colors.base0B}]█#[bg=${colors.base0B},fg=${colors.base02},bold]PANE#[bg=${colors.base03},fg=${colors.base0B}]#[fg=${colors.base0B},bold]"
						mode_tab           "#[fg=${colors.base07}]█#[bg=${colors.base07},fg=${colors.base02},bold]TAB#[bg=${colors.base03},fg=${colors.base07}]#[fg=${colors.base07},bold]"
						mode_scroll        "#[fg=${colors.base0A}]█#[bg=${colors.base0A},fg=${colors.base02},bold]SCROLL#[bg=${colors.base03},fg=${colors.base0A}]#[fg=${colors.base0A},bold]"
						mode_enter_search  "#[fg=${colors.base0D}]█#[bg=${colors.base0D},fg=${colors.base02},bold]ENT-SEARCH#[bg=${colors.base03},fg=${colors.base0D}]#[fg=${colors.base0D},bold]"
						mode_search        "#[fg=${colors.base0D}]█#[bg=${colors.base0D},fg=${colors.base02},bold]SEARCHARCH#[bg=${colors.base03},fg=${colors.base0D}]#[fg=${colors.base0D},bold]"
						mode_rename_tab    "#[fg=${colors.base07}]█#[bg=${colors.base07},fg=${colors.base02},bold]RENAME-TAB#[bg=${colors.base03},fg=${colors.base07}]#[fg=${colors.base07},bold]"
						mode_rename_pane   "#[fg=${colors.base0D}]█#[bg=${colors.base0D},fg=${colors.base02},bold]RENAME-PANE#[bg=${colors.base03},fg=${colors.base0D}]#[fg=${colors.base0D},bold]"
						mode_session       "#[fg=${colors.base0E}]█#[bg=${colors.base0E},fg=${colors.base02},bold]SESSION#[bg=${colors.base03},fg=${colors.base0E}]#[fg=${colors.base0E},bold]"
						mode_move          "#[fg=${colors.base0F}]█#[bg=${colors.base0F},fg=${colors.base02},bold]MOVE#[bg=${colors.base03},fg=${colors.base0F}]#[fg=${colors.base0F},bold]"
						mode_prompt        "#[fg=${colors.base0D}]█#[bg=${colors.base0D},fg=${colors.base02},bold]PROMPT#[bg=${colors.base03},fg=${colors.base0D}]#[fg=${colors.base0D},bold]"
						mode_tmux          "#[fg=${colors.base09}]█#[bg=${colors.base09},fg=${colors.base02},bold]TMUX#[bg=${colors.base03},fg=${colors.base09}]#[fg=${colors.base09},bold]"

						// formatting for inactive tabs
						tab_normal              "#[fg=${colors.base0D}]#[bg=${colors.base0D},fg=${colors.base02},bold]{index} #[bg=${colors.base02},fg=${colors.base05},bold] {name}{floating_indicator}#[fg=${colors.base02},bold]"
						tab_normal_fullscreen   "#[fg=${colors.base0D}]#[bg=${colors.base0D},fg=${colors.base02},bold]{index} #[bg=${colors.base02},fg=${colors.base05},bold] {name}{fullscreen_indicator}#[fg=${colors.base02},bold]"
						tab_normal_sync         "#[fg=${colors.base0D}]#[bg=${colors.base0D},fg=${colors.base02},bold]{index} #[bg=${colors.base02},fg=${colors.base05},bold] {name}{sync_indicator}#[fg=${colors.base02},bold]"	

						// formatting for the current active tab
						tab_active              "#[fg=${colors.base09}]#[bg=${colors.base09},fg=${colors.base02},bold]{index} #[bg=${colors.base02},fg=${colors.base05},bold] {name}{floating_indicator}#[fg=${colors.base02},bold]"
						tab_active_fullscreen   "#[fg=${colors.base09}]#[bg=${colors.base09},fg=${colors.base02},bold]{index} #[bg=${colors.base02},fg=${colors.base05},bold] {name}{fullscreen_indicator}#[fg=${colors.base02},bold]"
						tab_active_sync         "#[fg=${colors.base09}]#[bg=${colors.base09},fg=${colors.base02},bold]{index} #[bg=${colors.base02},fg=${colors.base05},bold] {name}{sync_indicator}#[fg=${colors.base02},bold]"

						// separator between the tabs
						tab_separator           "#[bg=#00000000] "

						// indicators
						tab_sync_indicator       "  "
						tab_fullscreen_indicator " 󰊓 "
						tab_floating_indicator   " 󰹙 "
						command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
						command_git_branch_format      "#[fg=blue] {stdout} "
						command_git_branch_interval    "10"
						command_git_branch_rendermode  "static"
						datetime        "#[fg=6C7086,bold] {format} "
						datetime_format "%A, %d %b %Y %H:%M"
						datetime_timezone "Africa/Casablanca"
					}
				}

				children

			}
		}
	'';
}
