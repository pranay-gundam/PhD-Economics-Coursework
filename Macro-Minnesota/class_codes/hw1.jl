# This is code to generate the graphs in part 2e that draws the offer curves
using Plots

# Setting parameter values
w_1 = 2
w_2 = 0.75

b1 = 0.5 - 1
b2 = 0 - 1
b3 = -1 - 1


# Generating a series of z(p_t, p_{t+1})
z = collect(range(0, stop=5, length=1000))
y1 = -z .* (w_2 .+ z).^b1
y2 = -z .* (w_2 .+ z).^b2
y3 = -z .* (w_2 .+ z).^b3

plot(y1, z, label="b = 0.5", ylabel="z(pₜ, pₜ₊₁)", xlabel="y(pₜ, pₜ₊₁)", title="Offer Curves")
plot!(y2, z, label="b = 0")
plot!(y3, z, label="b = -1")