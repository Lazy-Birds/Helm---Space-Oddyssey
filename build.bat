@echo off

set project_root=%~dp0%

pushd %project_root%

    odin run .
 
popd