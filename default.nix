# ============================================================================ #
#
# Package shim exposing installable targets from `floco' modules.
#
# ---------------------------------------------------------------------------- #

{ floco  ? builtins.getFlake "github:aakropotkin/floco"
, lib    ? floco.lib
, system ? builtins.currentSystem
}: let

# ---------------------------------------------------------------------------- #

  ident   = "flow-typed";
  version = "3.8.0";


# ---------------------------------------------------------------------------- #

  fmod = lib.evalModules {
    modules = [
      "${floco}/modules/top"
      {
        config._module.args.pkgs =
          floco.inputs.nixpkgs.legacyPackages.${system}.extend
            floco.overlays.default;
      }
      # Loads our generated `pdefs.nix' as a "module config".
      ( lib.addPdefs ./pdefs.nix )
    ];
  };


# ---------------------------------------------------------------------------- #

  pkg = fmod.config.floco.packages.${ident}.${version};

# ---------------------------------------------------------------------------- #

in pkg.global


# ---------------------------------------------------------------------------- #
#
#
#
# ============================================================================ #
