{
inputs =
	{
	nixpkgs = { url = "github:NixOS/nixpkgs/nixos-24.11"; };
	flake-utils = { url = "github:numtide/flake-utils"; };
	}
	;

outputs =
	{ self, nixpkgs, flake-utils, ... }:
		flake-utils .lib .eachDefaultSystem
		(
		system:
			let
			pkgs =
				import nixpkgs
				{
				system = system;
				}
				;
			inherit (pkgs) kitty;


			in
			{ defaultPackage =
				kitty 
				.overrideAttrs
				(
				{ version, ... }:
					{
					src = ./.;
					}
				)
				; } );
}
