using LabControl
using Documenter

DocMeta.setdocmeta!(LabControl, :DocTestSetup, :(using LabControl); recursive=true)

makedocs(;
    modules=[LabControl],
    authors="Jan Kuhfeld <jan.kuhfeld@rub.de> and contributors",
    sitename="LabControl.jl",
    format=Documenter.HTML(;
        canonical="https://jqfeld.github.io/LabControl.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/jqfeld/LabControl.jl",
    devbranch="main",
)
