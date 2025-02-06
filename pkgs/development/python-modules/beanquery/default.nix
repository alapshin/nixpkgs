{
  lib,
  beancount,
  click,
  buildPythonPackage,
  fetchFromGitHub,
  python-dateutil,
  pytestCheckHook,
  setuptools,
  tatsu-lts,
}:
buildPythonPackage {
  pname = "beanquery";
  version = "0.1.0-unstable-2025-02-04";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "beancount";
    repo = "beanquery";
    rev = "149b0b21afd67710ae931850b8ce54ee122b696d";
    hash = "sha256-hydpf+bhYM9aMAinWMEPseiIBG5qxXkAvRaYUdL97ns=";
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
