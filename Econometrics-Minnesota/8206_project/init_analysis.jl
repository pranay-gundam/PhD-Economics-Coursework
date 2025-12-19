using DataFrames, Plots, CSV, Dates, Statistics, LaTeXTables

# Load cleaned CPI data
cpi_data = CSV.read("data_cleaned/inflation_cleaned_pivot.csv", DataFrame)

itemcode_to_name = Dict(
    "CUSR0000SA0" => "All items",
    "CUSR0000SAF" => "Food",
    "CUSR0000SACE" => "Energy Commodities",
    "CUSR0000SEHF" => "Energy Services",
    "CUSR0000SACL1E" => "Commodities less food and energy commodities",
    "CUSR0000SASLE" => "Services less energy services",
    "FEDFUNDS" => "Effective Federal Funds Rate"
)

# Plot CPI trends for selected categories

## Aggregate Monthly CPI inflation Plot (2000 - Present)
cpi_data_2018 = filter(row -> row.date >= Date(2018, 1, 1), cpi_data)

cpi_data_2018 = filter(row -> row.date >= Date(2000, 1, 1), cpi_data)
plot(cpi_data_2018.date, cpi_data_2018.CUSR0000SA0, label="All items", xlabel="Date", 
        ylabel="Aggregate CPI (percent)", title="Monthly CPI Inflation (2000 - Present)", legend=false,
        linewidth = 2)
savefig("scratch_figures/aggregate_cpi_inflation_2000_present.png")
## Aggregate CPI and Food CPI Comparison Plot
plot(cpi_data_2018.date, cpi_data_2018.CUSR0000SA0, label="Aggregate CPI", xlabel="Date", 
        ylabel="Inflation (percent)", title="Aggregate vs Food (2018 - Present)", 
        linewidth = 2)
plot!(cpi_data_2018.date, cpi_data_2018.CUSR0000SAF, label="Food", linewidth = 2)
savefig("scratch_figures/aggregate_cpi_inflation_all_items_vs_food_2018_present.png")

## Energy Commodities and Services Comparison Plot
plot(cpi_data_2018.date, cpi_data_2018.CUSR0000SACE, label="Energy Commodities", xlabel="Date", 
        ylabel="Inflation (percent)", title="Energy Commodities vs Services (2018 - Present)", 
        linewidth = 2)
plot!(cpi_data_2018.date, cpi_data_2018.CUSR0000SEHF, label="Energy Services", linewidth = 2)
savefig("scratch_figures/energy_commodities_vs_energy_services_2018_present.png")

## Food and Energy Commodities Comparison Plot 
plot(cpi_data_2018.date, cpi_data_2018.CUSR0000SAF, label="Food", xlabel="Date", 
        ylabel="Inflation (percent)", title="Food vs Energy Commodities (2018 - Present)", 
        linewidth = 2)
plot!(cpi_data_2018.date, cpi_data_2018.CUSR0000SACE, label="Energy Commodities", linewidth = 2)
savefig("scratch_figures/food_vs_energy_commodities_2018_present.png")

# Do the same set of plots with the yoy inflation
# Load cleaned CPI YoY data
cpi_data_yoy = CSV.read("data_cleaned/inflation_yoy_cleaned_pivot.csv", DataFrame)
cpi_data_yoy_2018 = filter(row -> row.date >= Date(2018, 1, 1), cpi_data_yoy)
cpi_data_yoy_2000 = filter(row -> row.date >= Date(2000, 1, 1), cpi_data_yoy)

plot(cpi_data_yoy_2018.date, cpi_data_yoy_2018.CUSR0000SA0, label="All items", xlabel="Date", 
       ylabel="Percent", title="Year-over-Year CPI Inflation (2018 - Present)", legend=false,
       linewidth = 2)
savefig("scratch_figures/aggregate_cpi_yoy_inflation_2018_present.png")

plot(cpi_data_yoy_2000.date, cpi_data_yoy_2000.CUSR0000SA0, label="All items", xlabel="Date", 
       ylabel="Percent", title="Year-over-Year CPI Inflation (2000 - Present)", legend=false,
       linewidth = 2)
savefig("scratch_figures/aggregate_cpi_yoy_inflation_2000_present.png")

# Aggregate CPI and Food CPI Comparison Plot YoY
plot(cpi_data_yoy_2018.date, cpi_data_yoy_2018.CUSR0000SA0, label="Aggregate CPI", xlabel="Date", 
       ylabel="Inflation (percent)", title="Aggregate vs Food YoY (2018 - Present)", 
       linewidth = 2)
plot!(cpi_data_yoy_2018.date, cpi_data_yoy_2018.CUSR0000SAF, label="Food", linewidth = 2)
savefig("scratch_figures/aggregate_cpi_yoy_inflation_all_items_vs_food_2018_present.png")

# Energy Commodities and Services Comparison Plot YoY
plot(cpi_data_yoy_2018.date, cpi_data_yoy_2018.CUSR0000SACE, label="Energy Commodities", xlabel="Date", 
       ylabel="Inflation (percent)", title="Energy Commodities vs Services YoY (2018 - Present)", 
       linewidth = 2)
plot!(cpi_data_yoy_2018.date, cpi_data_yoy_2018.CUSR0000SEHF, label="Energy Services", linewidth = 2)
savefig("scratch_figures/energy_commodities_vs_energy_services_yoy_2018_present.png")

# Food and Energy Commodities Comparison Plot YoY
plot(cpi_data_yoy_2018.date, cpi_data_yoy_2018.CUSR0000SAF, label="Food", xlabel="Date", 
       ylabel="Inflation (percent)", title="Food vs Energy Commodities YoY (2018 - Present)",
       linewidth = 2)
plot!(cpi_data_yoy_2018.date, cpi_data_yoy_2018.CUSR0000SACE, label="Energy Commodities", linewidth = 2)
savefig("scratch_figures/food_vs_energy_commodities_yoy_2018_present.png")


# Plot all yoy variables together for comparison
plot(cpi_data_yoy_2000.date, cpi_data_yoy_2000.CUSR0000SA0, label="All items", linewidth = 2.5, xlabel="Date", 
        ylabel="Inflation (percent)", title="CPI Categories YoY Comparison (2018 - Present)")
plot!(cpi_data_yoy_2000.date, cpi_data_yoy_2000.CUSR0000SACE, label="Energy Commodities", linewidth = 2, color=:green)
plot!(cpi_data_yoy_2000.date, cpi_data_yoy_2000.CUSR0000SEHF, label="Energy Services", linewidth = 2, color=:orange)

plot!(cpi_data_yoy_2000.date, cpi_data_yoy_2000.CUSR0000SAF, label="Food", linewidth = 2, color=:purple)
plot!(cpi_data_yoy_2000.date, cpi_data_yoy_2000.CUSR0000SACL1E, label="Commodities less food and energy", linewidth = 2, color=:black)
plot!(cpi_data_yoy_2000.date, cpi_data_yoy_2000.CUSR0000SASLE, label="Services less energy services", linewidth = 2, color=:red)
savefig("scratch_figures/cpi_categories_yoy_comparison_2000_present.png")


# Normalize the axes for better comparison to deviations from meam? or percentage changes from base year
# in the plot, the second one seems a lot better.

# Plot with secondary y-axis for Energy Commodities
p = plot(cpi_data_yoy_2018.date, cpi_data_yoy_2018.CUSR0000SEHF, label=false, linewidth = 2, color=:orange, xlabel="Date", 
        ylabel="Inflation (percent)", title="CPI Categories YoY Comparison (2018 - Present)")
plot!(p, cpi_data_yoy_2018.date, cpi_data_yoy_2018.CUSR0000SAF, label=false, linewidth = 2, color=:purple)
plot!(p, cpi_data_yoy_2018.date, cpi_data_yoy_2018.CUSR0000SACL1E, label=false, linewidth = 2, color=:black)
plot!(p, cpi_data_yoy_2018.date, cpi_data_yoy_2018.CUSR0000SASLE, label=false, linewidth = 2, color=:red)
# Add Energy Commodities on secondary y-axis
p2 = twinx(p)
plot!(p2, cpi_data_yoy_2018.date, cpi_data_yoy_2018.CUSR0000SACE, label=false, linewidth = 2, color=:green, ylabel="Energy Commodities Inflation (percent)")

savefig("scratch_figures/cpi_categories_yoy_comparison_2018_present_twinx.png")


# Calculate variance for each sector and FFR
variance_data = Dict()
for col in names(cpi_data_yoy)[2:end]  # Skip date column
        variance_data[col] = var(skipmissing(cpi_data_yoy[!, col]))
end

# Create a DataFrame from the variance results
variance_table = DataFrame(
        Sector = [itemcode_to_name[code] for code in keys(variance_data)],
        Variance = collect(values(variance_data))
)

# Sort by variance descending
variance_table = sort(variance_table, :Variance, rev=true)

println(variance_table)


latex_code = "\\begin{table}\n" * latex_table(variance_table) * "\n\\end{table}"
open("scratch_figures/variance_table.tex", "w") do f
        write(f, latex_code)
end