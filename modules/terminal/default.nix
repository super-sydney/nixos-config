{
  fish = import ./fish.nix;
  kitty = import ./kitty.nix;
} // (import ./tools)