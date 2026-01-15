{
  nixosModules = import ./nixos;

  homeManagerModules =
    (import ./applications) // (import ./desktop) // (import ./editors) // (import ./terminal);
}
