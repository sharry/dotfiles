{ pkgs, ... }:
let colors = {
	black = "#090C0C";
	white = "#E3E5E5";
	grad0 = "#A3AED2";
	grad1 = "#769FF0";
	grad2 = "#394260";
	grad3 = "#212736";
	grad4 = "#1D2230";
}; in
{
	programs.starship = {
		enable = true;
		enableZshIntegration = true;
		settings = {
			format = pkgs.lib.concatStrings [
				"[░▒▓](${colors.grad0})"
				"[  ](bg:${colors.grad0} fg:${colors.black})"
				"[$nix_shell](bg:${colors.grad0} fg:${colors.black})"
				"[](bg:${colors.grad1} fg:${colors.grad0})"
				"$directory"
				"[](fg:${colors.grad1} bg:${colors.grad2})"
				"$git_branch"
				"$git_status"
				"[](fg:${colors.grad2} bg:${colors.grad3})"
				"$dotnet"
				"$java"
				"$nodejs"
				"[](fg:${colors.grad3} bg:${colors.grad4})"
				"$direnv"
				"[ ](fg:${colors.grad4})"
				"\n$character"
			];

			directory = {
				style = "fg:${colors.white} bg:${colors.grad1}";
				format = "[ $path ]($style)";
				truncation_length = 3;
				truncation_symbol = "…/";
				substitutions = {
					"Documents" = "󰈙 ";
					"Downloads" = " ";
					"Music" = " ";
					"Pictures" = " ";
				};
			};

			git_branch = {
				symbol = "";
				style = "bg:${colors.grad2}";
				format = ''[[ $symbol $branch ](fg:${colors.grad1} bg:${colors.grad2})]($style)'';
			};

			git_status = {
				style = "bg:${colors.grad2}";
				format = ''[[($all_status$ahead_behind )](fg:${colors.grad1} bg:${colors.grad2})]($style)'';
			};

			dotnet = {
				symbol = "";
				style = "bg:${colors.grad3}";
				format = ''[[ $symbol $version ](fg:${colors.grad1} bg:${colors.grad3})]($style)'';
			};

			nodejs = {
				symbol = "";
				style = "bg:${colors.grad3}";
				format = ''[[ $symbol ($version) ](fg:${colors.grad1} bg:${colors.grad3})]($style)'';
			};

			java = {
				symbol = "";
				style = "bg:${colors.grad3}";
				format = ''[[ $symbol $version ](fg:${colors.grad1} bg:${colors.grad3})]($style)'';
			};

			direnv = {
				disabled = false;
				denied_msg = "⛔";
				allowed_msg = "🟢";
				not_allowed_msg = "🔴";
				format = ''[ $allowed env $loaded ](bg:${colors.grad4})'';
			};

			nix_shell = {
				disabled = false;
				format = "+  ";
			};

		};

	};
}
