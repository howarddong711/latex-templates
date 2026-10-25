$ErrorActionPreference = 'Stop'
if (-not (Get-Command latexmk -ErrorAction SilentlyContinue)) {
    throw 'latexmk not found. Add your TeX Live bin directory to PATH.'
}
Push-Location -LiteralPath $PSScriptRoot
try {
    & latexmk -norc -xelatex -interaction=nonstopmode -halt-on-error -file-line-error -synctex=1 main.tex
    if ($LASTEXITCODE -ne 0) { throw "LaTeX build failed (exit $LASTEXITCODE). See main.log." }
    Write-Output "PDF ready: $(Join-Path $PSScriptRoot 'main.pdf')"
} finally {
    Pop-Location
}
