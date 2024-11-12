import re

# Path to your input and output files
input_file = "LaTeX_to_change.tex"
output_file = "LaTeX_changed.txt"

# Read the input file
with open(input_file, "r") as file:
    text = file.read()

# Define replacements
replacements = [
    (r"\\documentclass\{[^}]*\}.*\\begin\{document\}", ""),
    (r"\\end\{document\}", ""),
    (r"\\begin\{itemize\}", ""),
    (r"\\end\{itemize\}", ""),
    (r"    \\item ", "- "),
    (r"\\section\*\{", "### "),
    (r"\\subsection\*\{", ""),
    (r"\\\(", "$"),
    (r"\\\)", "$"),
    (r"\\\[", "$$"),
    (r"\\\]", "$$")
]

# Apply replacements
for pattern, repl in replacements:
    text = re.sub(pattern, repl, text, flags=re.DOTALL)

# Write the output file
with open(output_file, "w") as file:
    file.write(text)