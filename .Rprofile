.libPaths("/packages/")

## This makes sure that R loads the workflowr package
## automatically, everytime the project is loaded
if (requireNamespace("workflowr", quietly = TRUE)) {
  message("Loading .Rprofile for the current workflowr project")
  library("workflowr")
  workflowr::wflow_git_config(user.name = "Dave Tang", user.email = "davetingpongtang@gmail.com", overwrite = TRUE)
} else {
  message("workflowr package not installed, please run install.packages(\"workflowr\") to use the workflowr functions")
}
