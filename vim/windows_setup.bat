REM Copies the bootstrap file into home directory so gvim can read the rest of our config
copy "%~dp0\vim_bootstrap" "%userprofile%\_vimrc"

REM Copied vimperatorrc - no bootstrap file for windows yet
copy "%~dp0\vimperatorrc" "%userprofile%\_vimperatorrc"

REM Create config redirect for neovim
echo set runtimepath^^=%~dp0 runtimepath+=%~dp0/after >> init.vim
echo let ^&packpath = ^&runtimepath >> init.vim
echo source %~dp0/vimrc >> init.vim

REM install nvim config
if not exist "%LOCALAPPDATA%\nvim" mkdir "%LOCALAPPDATA%\nvim"
move /Y init.vim "%LOCALAPPDATA%\nvim\init.vim"

REM install nvim plugin python
pip install --user pynvim
