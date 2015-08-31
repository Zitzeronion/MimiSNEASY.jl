using Mimi
using Lora

include("assim.jl")

# Get log-likelihood function
logli = construct_loglikelihood()

initial_guess = [2.7,2.9,1.0,4.2,0.9,23,0.03,-0.06,-33,286,19.5,0.1,2.0,0.45,2.25,0.55,0.9,0.95]

# These are the parameter estimates that R gets from maximising the posterior
rbest = [2.67391818, 3.13600522,   0.98236787,   4.17150643,   0.88898206,  23.01048615,   0.04972258,  -0.03610151, -25.70232473, 285.91278519,  19.71299613,   0.09730246, 2.04538221,   0.44754775,   2.73731543,   0.49014552,   0.81813141,   0.97858006]

# Init Lora model
mcmodel = model(logli, init=rbest)

step = [1.6,1.7,0.25,0.75,0.15,40,0.015,0.03,9,0.7,1.3,0.005,0.25,0.045,0.57,0.07,0.06,0.11]./10

mcchain = Lora.run(mcmodel, MH(x::Vector{Float64} -> rand(MvNormal(x, step))), SerialMC(nsteps=100_000, burnin=0))
