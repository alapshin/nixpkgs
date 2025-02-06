{
  lib,
  beancount,
  click,
  buildPythonPackage,
  fetchFromGitHub,
  python-dateutil,
  pytestCheckHook,
  setuptools,
  tatsu,
}:
let
  tatsu-lts = tatsu.overrideAttrs (oldAttrs: {
    src = fetchFromGitHub {
      owner = "dnicolodi";
      repo = "TatSu-LTS";
      version = "5.13.1";
      tag = "v5.13.1-LTS";
      hash = "sha256-cfGAWZDAnoD3ddhVIkOHyiv7gUDgnAWu1ZBvDEiQ2AQ=";
    };
  });
in
buildPythonPackage rec {
  pname = "beanquery";
  version = "0.2.0-unstable-2025-01-10";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "beancount";
    repo = "beanquery";
    rev = "e77a67996a54eef2e9d77b6352c74a40164e281d";
    hash = "sha256-XYfKAscm55lY4YjIGTQ6RMFnCPWemfszpheGQ9qjMiM=";
  };

  build-system = [ setuptools ];

  dependencies = [
    beancount
    click
    python-dateutil
    tatsu-lts
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [
    "beanquery"
  ];

  meta = with lib; {
    homepage = "https://github.com/beancount/beanquery";
    description = "Beancount Query Language";
    longDescription = ''
      A customizable light-weight SQL query tool that works on tabular data,
      including Beancount.
    '';
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ alapshin ];
    mainProgram = "bean-query";
  };
}
