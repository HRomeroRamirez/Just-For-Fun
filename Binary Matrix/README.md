# Just-For-Fun Projects: Input-Output Binary Matrix

📌 Project: Binary Conversion of Puerto Rico’s 2007 Technical Coefficients Matrix.

This mini-project converts the 2007 Technical Coefficients Matrix (Matrix A) of Puerto Rico into a binary matrix for use in network applications. It uses a filter proposed by Aroche (1993) to identify significant inter-industry linkages.

🧠 Concept:
The original matrix (MatrixA_07.xlsx) represents technical coefficients between 30 economic sectors. To reveal the underlying network of interdependencies, we apply the Aroche (1993) filter:

Threshold: f = 1 / n,
where n = 30 sectors ⇒ f ≈ 0.0333
The result is a 30x30 binary adjacency matrix suitable for graph/network-based analysis.

📁 File Structure:
Input:	MatrixA_07.xlsx	Raw 30x30 -> Technical Coefficients Matrix.
Output:	Binary_Matrix_07.csv -> Resulting 30x30 binary matrix (adjacency form).
Scripts:	00.00.Setup.R	-> Environment setup and package loading and
00.01.Create.Binary.Matrix.R -> Script applying Aroche filter and exporting binary matrix

🧪 How to Run:
Open 00.00.Setup.R to initialize the environment.
Run 00.01.Create.Binary.Matrix.R to
load the original matrix from MatrixA_07.xlsx, 
apply the Aroche filter, and 
export Binary_Matrix_07.csv

📖 Reference:
Aroche, F. (1993). Economic structures in Brazil, Mexico and South Korea: An Input-Output application. Doctoral Thesis, Queen Mary University.
