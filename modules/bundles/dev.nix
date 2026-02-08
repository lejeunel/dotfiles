{ inputs, ... }:
{
  flake.modules.homeManager.dev = {

    imports = with inputs.self.modules.homeManager; [
      cpp
      python
      direnv
      lua
      latex
      golang
      javascript
      guile

    ];
  };

}
