# Load libraries ----------------------------------------------------------------
library(readxl)
library(dplyr)
library(ggplot2)
library(gridExtra)

# Clear Environment and Memory -----------------------------------------------
rm(list = ls())
gc()

# Try-Catch Block for Sourcing Setup File -------------------------------------
tryCatch({
  dirSet <- getSrcDirectory(function(x) { x })
  sourceFile <- list.files(dirSet, recursive = TRUE, full.names = TRUE)
  source(sourceFile[grepl("00.Setup.", sourceFile)])
}, error = function(e) {
  dirSet <- dirname(rstudioapi::getActiveDocumentContext()$path)
  sourceFile <- list.files(dirSet, recursive = TRUE, full.names = TRUE)
  source(sourceFile[grepl("00.Setup.", sourceFile)])
})

# Ensure the base output directory exists -------------------------------------
if (!dir.exists(outputsFolder)) {
  dir.create(outputsFolder, recursive = TRUE)
}

# Read GSCPI Excel file ----------------------------------------------------
dataGscpi <- read_excel(file.path(inputsFolder, "DataGSCPI.xlsx"))

# Operations ------------------------------------------------------------------

# Convert Date column to Date type if not already
dataGscpi$Date <- as.Date(dataGscpi$Date)

# Normalize the series to positive numbers
normalizedGscpi <- dataGscpi$GSCPI - min(dataGscpi$GSCPI) + 1

# Set the base to 100 in December 2006
baseIndex <- which(format(dataGscpi$Date, "%Y-%m") == "2006-12")
baseValue <- normalizedGscpi[baseIndex]
positiveGscpi <- normalizedGscpi / baseValue * 100

# Add PositiveGSCPI column to the existing data frame
dataGscpi <- dataGscpi %>%
  mutate(positiveGscpi = positiveGscpi)

# Generate a visualization of both GSCPI and PositiveGSCPI series side by side
plotOriginal <- ggplot(dataGscpi, aes(x = Date, y = GSCPI)) +
  geom_line(color = "blue") +  # Set color to blue
  labs(title = "Original GSCPI", x = "Date", y = "GSCPI") +
  theme_minimal()

plotNormalized <- ggplot(dataGscpi, aes(x = Date, y = positiveGscpi)) +
  geom_line(color = "blue") +  # Set color to blue
  labs(title = "GSCPI with a base of 100 in Dec 2006", x = "Date", y = "GSCPI") +
  theme_minimal()

# Arrange the plots side by side
grid.arrange(plotOriginal, plotNormalized, ncol = 2)

# Save outputs ---------------------------------------------------------------

# Save the original GSCPI series to a CSV file 
write.csv(dataGscpi, file = file.path(outputsFolder, "NewGSCPIData.csv"), row.names = FALSE)

# Save the side-by-side plots as an image
outputPlot <- file.path(outputsFolder, "GSCPI_Plots_SideBySide.png")
png(filename = outputPlot, width = 1200, height = 600)
grid.arrange(plotOriginal, plotNormalized, ncol = 2)
dev.off()





