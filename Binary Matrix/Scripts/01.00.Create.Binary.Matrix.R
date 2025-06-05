# Load libraries ----------------------------------------------------------------
library(readxl)

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

# Read Matrix A Excel file --------------------------------------------------------
matrixA07 <- read_excel(file.path(inputsFolder, "MatrixA_07.xlsx"))

# Convert to matrix
matrixA07 <- as.matrix(matrixA07)

# Remove the first column
matrixA07 <- matrixA07[, -1]

# Convert to numeric and reshape
matrixA07 <- as.numeric(matrixA07)
matrixA07 <- matrix(matrixA07, nrow = 30, byrow = FALSE)

# Round and apply binary threshold
matrixA07 <- round(matrixA07, 4)
matrixA07 <- ifelse(matrixA07 >= 1 / 30, 1, 0)

# Convert back to data frame
binaryMatrix07 <- data.frame(matrixA07)

# Print the binary matrix result
print(binaryMatrix07)

# Saved binaryMatrix as CSV ------------------------------------------------
write.csv(binaryMatrix07, file = file.path(outputsFolder, "Binary_Matrix_07.csv"), row.names = FALSE)







