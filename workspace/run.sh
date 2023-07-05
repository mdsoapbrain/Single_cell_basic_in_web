# Set the R library paths to the local directory
export R_LIBS="./R_libs"

# Check if the R packages are installed
if [ ! -d "$R_LIBS" ] || [ ! -f "$R_LIBS/shiny/DESCRIPTION" ]; then
  echo "Installing R packages..."
  
  # Create R library directory if it doesn't exist
  mkdir -p "$R_LIBS"
  
  # Install R package dependencies locally
  R -e "install.packages(c('shiny', 'Seurat', 'tidyverse'), lib = '$R_LIBS')"
fi

# Check if the app directory exists
if [ -d "$(dirname "$0")" ]; then
  # Run the Shiny app
  R -e "shiny::runApp('$(dirname "$0")')"
else
  echo "Shiny app directory does not exist"
fi
