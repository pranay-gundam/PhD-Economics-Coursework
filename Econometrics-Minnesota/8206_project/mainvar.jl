using DataFrames, AutoregressiveModels, CSV, Plots

# Load cleaned CPI data
yoy = false
if yoy
    cpi_data = CSV.read("data_cleaned/inflation_yoy_cleaned_pivot.csv", DataFrame)
else
    cpi_data = CSV.read("data_cleaned/inflation_cleaned_pivot.csv", DataFrame)
end

# Reorder columns to specified economic categories
var_order = [
	:CUSR0000SACE,   # Energy Commodities
	:CUSR0000SEHF,   # Energy Services
	:CUSR0000SAF,    # Food
	:CUSR0000SACL1E, # Commodities less food and energy commodities
	:CUSR0000SASLE,  # Services less energy services
	:FEDFUNDS        # Effective Federal Funds Rate
]
cpi_data = dropmissing(select(cpi_data, [:date; var_order]))

# Fit VAR model and reorder columns for the choleskyresiduals
names_data = 2:size(cpi_data, 2)  # Variables now start immediately after :date
lags = 2
var_model = fit(VARProcess, cpi_data, names_data, lags, choleskyresid = true)  

# Computing the IRFs 
shock_index = 1 # Index of the variable to shock (e.g., 2 for energy commodities)
dobootstrap = false

function basic_irfs_plot(var_model, shock_index, horizon; yoy=false)
    irf = impulse(var_model, shock_index, horizon, choleskyshock=true)
    irfs_norm = irf ./ irf[1,1,1]

    # Plotting the IRFs for Energy Commodities shock
    p1 = plot(irfs_norm[1, :, 1], title="Energy Commodities", 
        xlabel="Horizon (months)", 
        ylabel="Percentage Points (pp)",
        label = false,
        linewidth = 2)
    savefig(p1, "scratch_figures/irf_energy_commodities_lags=$(lags)_yoy=$(yoy).png")

    p2 = plot(irfs_norm[2, :, 1], title="Energy Services", 
        xlabel="Horizon (months)", 
        ylabel="Percentage Points (pp)",
        label = false,
        linewidth = 2)
    savefig(p2, "scratch_figures/irf_energy_services_lags=$(lags)_yoy=$(yoy).png")

    # Plotting the IRFs for Food shock
    p3 = plot(irfs_norm[3, :, 1], title="Food", 
        xlabel="Horizon (months)", 
        ylabel="Percentage Points (pp)",
        label = false,
        linewidth = 2)
    savefig(p3, "scratch_figures/irf_food_lags=$(lags)_yoy=$(yoy).png")
    p4 = plot(irfs_norm[4, :, 1], title="Commodities less food and energy", 
        xlabel="Horizon (months)", 
        ylabel="Percentage Points (pp)",
        label = false,
        linewidth = 2)
    savefig(p4, "scratch_figures/irf_commodities_less_food_energy_lags=$(lags)_yoy=$(yoy).png")

    p5 = plot(irfs_norm[5, :, 1], title="Services less energy services", 
        xlabel="Horizon (months)", 
        ylabel="Percentage Points (pp)",
        label = false,
        linewidth = 2)
    savefig(p5, "scratch_figures/irf_services_less_energy_lags=$(lags)_yoy=$(yoy).png")

    p6 = plot(irfs_norm[6, :, 1], title="Effective Federal Funds Rate", 
        xlabel="Horizon (months)", 
        ylabel="Percentage Points (pp)",
        label = false,
        linewidth = 2)
    savefig(p6, "scratch_figures/irf_federal_funds_rate_lags=$(lags)_yoy=$(yoy).png")

    # Create a 3x2 grid of all IRF plots
    if yoy
        all_plot_title = "IRFs to 1pp Energy Commodities Shock (lags=$(lags), YoY Inflation)"
    else
        all_plot_title = "IRFs to 1pp Energy Commodities Shock (lags=$(lags), MoM Inflation)"
    end
    p_grid = plot(p1, p2, p3, p4, p5, p6, layout=(3,2), size=(1200, 1000), 
                    plot_title=all_plot_title)
    savefig(p_grid, "scratch_figures/irf_grid_all_lags=$(lags)_yoy=$(yoy).png")
end

function bands_irfs_plot(var_model, shock_index, horizon, statespacesize)
    fillirf!(x) = impulse!(x.out, x.r, shock_index, choleskyshock=true)
    ndraw = 10000
    bootirfs = Array{Float64, 3}(undef, statespacesize, horizon, ndraw)

    bootstrap!(bootirfs=>fillirf!, var_model, initialindex=1, drawresid=iidresiddraw!)
    boot2 = view(bootirfs, 2, :, :)
    lb, ub, _ = confint(SuptQuantileBootBand(), boot2, level=0.68)

    res = 72 .* (6.5, 3.5)
    fig = Figure(; resolution=res, backgroundcolor=:transparent)
    ax = Axis(fig[1, 1], xlabel="Horizon (months)", ylabel="Impulse Response", backgroundcolor=:transparent)
    band!(ax, 0:36, lb, ub, color=(:red, 0.1))
    lines!(ax, 0:36, view(irf, 2, :), color=:red)
    lines!(ax, 0:36, lb, color=:red, linewidth=0.5)
    lines!(ax, 0:36, ub, color=:red, linewidth=0.5)
    ax.xticks = 0:12:36
    save("docs/src/assets/readmeexample.png", fig, pt_per_unit=1)
end 



if dobootstrap
    bands_irfs_plot(var_model, shock_index, 40, size(names_data)[1])
else
    basic_irfs_plot(var_model, shock_index, 40; yoy=yoy)
end




### ROBUSTNESS

## Choosing lag length based on AIC
#lag_max = 12
#aic_values = 1:lag_max
#aic_results = Dict()
#for lag in aic_values
#    model = fit(VARProcess, dropmissing(cpi_data), names_data, lag, choleskyresid = true)
#    aic_results[lag] = aic(model)
#end

## YoY Inflation VAR



## Using regional data (not seasonally adjusted)
