{
  nixosModules = import ./nixos;

  homeManagerModules =
    (import ./applications)
    // (import ./desktop)
    // (import ./editors)
    // (import ./languages)
    // (import ./terminal);
}
