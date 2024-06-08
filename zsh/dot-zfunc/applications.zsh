vscode () { 
  VSCODE_CWD="$PWD"
  /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code "$@" --new-window
}

subl() {
  SUBLIME_CWD="$PWD"          # Set the current working directory to the present working directory
  /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl "$@" --new-window
}