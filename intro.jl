using Statistics

v = [1, 2, 3]

for i in v
    println(i)
end

using DataFrames

df = DataFrame(;a=[1,2],b=["a","b"])

describe(df)

select(df,"a")

select(df,a)
a= "b"
transform(df, :a=>ByRow(abs2); renamecols=false)

combine(groupby(df, :b), :a=>mean; renamecols=false)

df.a

df[2,:]

df[:, :a]

# mutating variants
# this adds in the column to the original dframe
transform!(df, :a=>ByRow(abs2) => :c)

function square(x)
    return x^2
end

square.(v)

square(x) = x^2 # like lambda in python


using SMLP2024
SMLP2024.datasets()
SMLP2024.dataset("sleepstudy")
sleepstudy=DataFrame(tbl)
transform(sleepstudy, :days=> ByRow(abs2))

function factor_name(x::AbstractString)
    return x
end
function factor_name(x::Integer)
    return string(x)
end
@code_lowered factor_name(1)

# put a df in R which can be read from R
@rput sleepstudy

varinfo()

@macroexpand @rget x

rcopy(reval("x"))

β #\beta


# Makie
# CairoMakie

using CairoMakie
scatter(1:8,1:8)

f = Figure()
ax = Axis(f[1,1])

scatter!(ax,1:100,1:100)

sleepstudy = dataset(:sleepstudy)

using AlgebraOfGraphics
using CairoMakie
using DataFrameMacros
using DataFrames
using MixedModels
using MixedModelsMakie
using SMLP2024: dataset

plt = data(sleepstudy) *
 mapping(:days, :reaction) *
 visual(Scatter)

draw(plt)

plt = data(sleepstudy) *
    mapping(:days => "Days of sleep deprivation",
        :reaction => "Reaction time (ms)",
        layout= :subj) *
    (visual(Scatter) + visual(Lines))

    plt = data(sleepstudy) *
    mapping(:days => "Days of sleep deprivation",
        :reaction => "Reaction time (ms)",
        layout= :subj) *
    (visual(Scatter) + linear())

shrinkageplot(mod)
caterpillar(mod;orderby=2) # organized by the 2nd column
qqcaterpillar(mod)
qqnorm(mod)
coefplot(mod)

# power simulation
using DataFrames
using MixedModels
using SMLP2024: datasets

fm1=fit(MixedModel,
@formula(reaction~1+days+(1+days|subj)),
dataset(:sleepstudy)
)
parametricbootstrap(MersenneTwister(42), 1000, fm1)


slpsim=DataFrame(dataset(:sleepstudy); copycols=true)

# set the DV to 0
slpsim[:, :reaction] .= 0.0
slpsimod = LinearMixedModel(@formula(reaction~1+days+(1+days|subj)), slpsim)

simulate!(MersenneTwister(42), slpsimod, β = [500, 50], σ=250)
slpsimodpw = parametricbootstrap(MersenneTwister(42), 
1000,slpsimod, β = [500, 50], σ=250)

# random effects
subj_re = create_re[100, 20]


