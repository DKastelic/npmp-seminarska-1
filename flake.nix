{
  description = "Python with qiskit development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          python3
        ];

        shellHook = ''
          python -m venv .venv --copies
          source .venv/bin/activate
          pip install -r requirements.txt

          echo "Welcome to the Qiskit development environment!"
        '';

        env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath  [
          pkgs.stdenv.cc.cc.lib
          pkgs.libz
        ];
      };
    };
}
