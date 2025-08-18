let

	vars = import ../vars.nix;

	keyMap = { from, to }: {
		HIDKeyboardModifierMappingDst = to;
		HIDKeyboardModifierMappingSrc = from;
	};

	# Ref: https://developer.apple.com/library/archive/technotes/tn2450/_index.html
	# Formula: the code is the result in decimal of 0x700000000 or'd with the corresponding usage id (from the table)
	# Example: https://miniwebtool.com/bitwise-calculator/?data_type=16&number1=0x700000000&number2=0x39&operator=OR
	# Tools: https://hidutil-generator.netlify.app/

	capsLock      = 30064771129;
	deleteForward = 30064771148;

in
{
	system.keyboard = {
		enableKeyMapping = true;
		nonUS.remapTilde = true;
		userKeyMapping = [
			(keyMap { from = capsLock; to = deleteForward; })
		];
	};

	home-manager.users.${vars.personal.user}.targets.darwin.keybindings = {
		"^←" = "moveWordLeft:";
		"^→" = "moveWordRight:";
	};
}
