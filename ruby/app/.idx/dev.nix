/*
  Copyright 2024 Google LLC
  
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.  
  
  You may obtain a copy of the License at
  
   https://www.apache.org/licenses/LICENSE-2.0
  
  Unless required by applicable law or agreed to in writing, software
  distributed  
  under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing  
  permissions and
  limitations under the License.
*/
# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-23.11"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.ruby
    pkgs.bundler
    pkgs.gcc
    pkgs.gnumake
  ];
  # Sets environment variables in the workspace
  env = {};
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      "Shopify.ruby-lsp"
      "rangav.vscode-thunder-client"
    ];
    workspace = {
      # Runs when a workspace is first created
      onCreate = {
        bundle-install = "bundle install";
        # Open editors for the following files by default, if they exist:
        default.openFiles = ["app.rb"];
      };
      # Runs when a workspace is (re)started
      onStart= {
        run-server = "bundle exec rerun 'ruby app.rb'";
      };
    };
  };
}